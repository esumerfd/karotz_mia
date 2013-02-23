require "spec_helper"

require "mia"

describe "mia" do
  it "returns text" do
    Mia.new.hello.should == "hello"
  end
end
