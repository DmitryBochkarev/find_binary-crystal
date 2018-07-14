require "./spec_helper"
require "file"

describe FindBinary do
  it "should find in a default paths" do
    crystal = FindBinary.find("crystal")
    crystal.should_not eq(nil)
    File.executable?(crystal.not_nil!).should eq(true)
  end

  it "should allow to find in a custom paths" do
    find_stub_bin = FindBinary.new("stub_bin")
    find_stub_bin.append_path(__DIR__ + "/fixtures/")

    stub_bin = find_stub_bin.find
    stub_bin.should_not eq(nil)
  end

  it "should ignore a non binaries" do
    find_stub_bin = FindBinary.new("non_binary")
    find_stub_bin.append_path(__DIR__ + "/fixtures/")

    stub_bin = find_stub_bin.find
    stub_bin.should eq(nil)
  end
end
