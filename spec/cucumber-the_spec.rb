# encoding: UTF-8
require 'spec_helper'

describe Cucumber::The do
  it "adds a The constant with a Registry" do
    The.should be_instance_of(Cucumber::The::Registry)
  end

  it "adds a Before block that clears the registry on every step" do
    The.should_receive(:clear)

    before_blocks.should have_at_least(1).block
    before_blocks.each(&:call)
  end
end
