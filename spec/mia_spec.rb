require "spec_helper"

require "mia"

describe "mia" do
  it "returns text" do
    Mia.new.hello.should == "hello"
  end

  it "returns a random interactive_id" do
    Mia.new.interactive_id.should start_with("test_")
  end
end
