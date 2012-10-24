# encoding: UTF-8
require 'spec_helper'

describe Cucumber::The do
  it "adds a The constant with a Registry" do
    The.should be_instance_of(Cucumber::The::Registry)
  end
end
