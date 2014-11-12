require 'csv'
require 'sunlight/congress'
require 'erb'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zipcode)
  Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letters(id,form_letter)
  Dir.mkdir("output") unless Dir.exists?("output")

  filename = "output/thanks_#{id}.html"

  File.open(filename,'w') do |file|
    file.puts form_letter
  end
end

def clean_phone(phone)
  nums = phone.to_s.scan(/\d+/).join
  if nums.size < 10 || (nums.size == 11 && nums[0] != '1' ) || nums.size > 11
    '000-000-0000'
  elsif nums.size == 11 && nums[0] == '1'
    phone[1...11]
  else
    phone
  end
end

def peak(reg_times, time_method)
  freq = Hash.new(0)
  reg_times.map { |t| t.send(time_method)}.each do |h|
    freq[h] += 1
  end
  freq.keys.max { |a, b| freq[a] <=> freq[b] }
end

def peak_hours(reg_times)
  peak(reg_times, :hour)
end

def peak_day(reg_times)
  peak(reg_times, :wday)
end

puts "EventManager initialized."

contents = CSV.open '../event_attendees.csv', headers: true, header_converters: :symbol

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

reg_times = []

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  phone   = clean_phone(row[:homephone])
  reg_times << DateTime.strptime(row[:regdate], '%m/%d/%y %H:%M')

  legislators = legislators_by_zipcode(zipcode)
  form_letter = erb_template.result(binding)

  save_thank_you_letters(id,form_letter)
end

puts peak_hours(reg_times)
puts peak_day(reg_times)
