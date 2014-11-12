require 'jumpstart_auth'
require 'bitly'
require 'klout'

class MicroBlogger
  attr_reader :client

  def initialize
    puts 'Initializing MicroBlogger'
    @client = JumpstartAuth.twitter

    @followers_list = nil
    @friends_list = nil
    
    Bitly.use_api_version_3
    @bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')

    Klout.api_key = 'xu9ztgnacmjx3bu82warbr3h'
  end

  def followers_list
    unless @followers_list
      @followers_list = @client.followers.map {|f| @client.user(f).screen_name}
    end
    @followers_list
  end

  def friends_list
    unless @friends_list
      @friends_list = @client.friends.map { |f| @client.user(f).screen_name }
    end
    @friends_list
  end
  
  def tweet(message)
    if message.length >= 140
      puts "Message too long!"
    else
      @client.update(message)
    end
  end

  def dm(target, message)
    if followers_list.include? target
      puts "Trying to send #{target} this direct message:"
      puts message
      tweet("d @#{target} #{message}")
    else
      puts "Target is not your follower"
    end
  end

  def spam_my_followers(message)
    followers_list.each do |f|
      dm(f, message)
    end
  end

  def everyones_last_tweet
    
    friends_list.each do |f|
      puts "#{@client.user(f).screen_name}"
      puts "#{@client.user(f).status.created_at.strftime("%b %d")}"
      puts "#{@client.user(f).status.text}"
      puts "-" * 80
    end
  end

  def shorten(original_url)
    puts "Shortering this URL: #{original_url}"
    short = @bitly.shorten(original_url).short_url
    puts short
    short
  end

  def tweet_with_url(message)
    m = message.split(" ").map { |p| p =~ /http:.*/ ? shorten(p) : p }.join(" ")
    tweet(m)
  end

  def klout_score
    friends_list.each do |friend|
      puts friend
      identity = Klout::Identity.find_by_screen_name(friend)
      user = Klout::User.new(identity.id)
      puts user.score.score
      puts "-" * 80
    end
  end
  
  def run
    puts "Welcome to the JSL Twitter Client!"
    command = ""
    until command == "q"
      printf "enter command: "
      parts = gets.chomp.downcase.split(" ")
      command = parts[0]
      case command
      when "q"    then puts "Goodbye"
      when "t"    then tweet(parts[1..-1].join(" "))
      when "dm"   then dm(parts[1], parts[2..-1].join(" "))
      when "sf"   then spam_my_followers(parts[1..-1].join(" "))
      when "elt"  then everyones_last_tweet
      when "s"    then shorten(parts[1..-1].join(" "))
      when "turl" then tweet_with_url(parts[1..-1].join(" "))
      when "k"    then klout_score
      else
        puts "Sorry, I don't know how to #{command}"
      end
    end
  end
end


blogger = MicroBlogger.new
blogger.run
