require "spec_helper"

require "mia"

describe "mia" do

  it "holds the interactive_id" do
    mia = Mia.new
    mia.interactive_id = "1234"
    mia.interactive_id.should == "1234"
  end

  it "holds the id accross instances of mia" do
    Mia.new.interactive_id = "GLOBAL ID"

    Mia.new.interactive_id.should == "GLOBAL ID"
  end
end
