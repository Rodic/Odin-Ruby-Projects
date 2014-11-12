require 'spec_helper'

describe Table do
  let(:table) { Table.new }

  describe "#new" do
    
    it "creates empty table" do
      expect(table).to be_an_instance_of(Table)
    end

    it "has fields array" do
      expect(table.instance_eval { @fields }).to be_an_instance_of(Array)
    end

    it "has 42 fileds" do
      expect(table.instance_eval { @fields }.count).to eq(42)
    end
  end
  
  describe "#pin" do
    
    context "table coords are invalid" do
      it "raises error when length is incorrect" do
        expect {table.pin("red", 7, 1)}.to raise_error("Invalid length")
      end

      it "raises error when height is incorrect" do
        expect {table.pin("red", 3, 6)}.to raise_error("Invalid height")
      end
    end
    
    context "table coords are valid" do
      
      context "table field is free" do
        
        it "pins colour to the table" do
          color = "red".ljust(7)
          table.pin(color, 2, 4)
          expect(table.instance_eval{
                   @fields[coords_to_index(2,4)] }).to eq(color)
        end
      end

      context "table field is not free" do

        it "raises error when pins to occupied field" do
          table.pin("red", 5, 1)
          expect {table.pin("red", 5, 1)}.to raise_error("Field is occupied")
        end
      end
    end
  end

  describe "#get_row" do
    
    it "returns correct values from the first row" do
      color  = "blue".ljust(7)
      row    = 0
      result = [color, color, color, color, color, color, color]
      fill_row(table, row, color)
      expect(table.instance_eval{ get_row(row) }).to eq(result)
    end

    it "returns correct values from the last row" do
      color  = "orange".ljust(7)
      row    = 5
      result = [ color, color, color, color, color, color, color ]
      fill_row(table, row, color)
      expect(table.instance_eval{ get_row(row) }).to eq(result)
    end
  end

  describe "#get_column" do

    it "returns correct values from the first column" do
      color  = "yellow".ljust(7)
      column = 0
      result = [ color, color, color, color, color, color ]
      fill_column(table, column, color)
      expect(table.instance_eval{ get_column(column) }).to eq(result)
    end

    it "returns correct values from the last column" do
      color  = "yellow".ljust(7)
      column = 6
      result = [ color, color, color, color, color, color ]
      fill_column(table, column, color)
      expect(table.instance_eval{ get_column(column) }).to eq(result)
    end
  end
    
  describe "#get_left_diagonal" do
    
    it "returns correct values from the main diagonal" do
      color = "green".ljust(7)
      table.pin(color, 0, 0)
      table.pin(color, 1, 1)
      table.pin(color, 2, 2)
      table.pin(color, 3, 3)
      table.pin(color, 4, 4)
      table.pin(color, 5, 5)
      results = [ color, color, color, color, color, color ]
      expect(table.instance_eval{ get_left_diagonal([3,3]) }).to eq(results)
    end

    it "returns correct values from the small diagonal" do
      color = "blue".ljust(7)
      table.pin(color, 0, 2)
      table.pin(color, 1, 3)
      table.pin(color, 2, 4)
      table.pin(color, 3, 5)
      results = [ color, color, color, color ]
      expect(table.instance_eval{ get_left_diagonal([2,4]) }).to eq(results)
    end
  end
  
  describe "#get_right_diagonal" do
    
    it "returns correct values from the main diagonal" do
      color = "red".ljust(7)
      table.pin(color, 6, 0)
      table.pin(color, 5, 1)
      table.pin(color, 4, 2)
      table.pin(color, 3, 3)
      table.pin(color, 2, 4)
      table.pin(color, 1, 5)
      results = [ color, color, color, color, color, color ]
      expect(table.instance_eval{ get_right_diagonal([3,3]) }).to eq(results)
    end

    it "returns correct values from the small diagonal" do
      color = "blue".ljust(7)
      table.pin(color, 6, 2)
      table.pin(color, 5, 3)
      table.pin(color, 4, 4)
      table.pin(color, 3, 5)
      results = [ color, color, color, color ]
      expect(table.instance_eval{ get_right_diagonal([5,3]) }).to eq(results)
    end
  end
  
  describe "#four_in_a_row?" do

    it "returns false if there are no four conn discs of the same color " do
      row = [ "blue", "red", "red", "blur", "red", "red" ]
      expect(table.instance_eval{ four_in_a_row?("red", row) }).to be_falsey
    end

    it "returns true when there are four connected discs of the same color" do
      row = [ "red", "red", "green", "green", "green", "green", "red" ]
      expect(table.instance_eval{ four_in_a_row?("green", row) }).to be_truthy
    end
  end
end
