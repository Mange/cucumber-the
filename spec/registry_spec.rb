# encoding: UTF-8
require 'spec_helper'

module Cucumber
  module The
    describe Registry do
      subject(:registry) { Registry.new }

      it "can set and access values" do
        registry[:foo] = "bar"
        registry[:foo].should == "bar"
      end

      it "raises an error when accessing unset values" do
        expect {
          registry[:elephant]
        }.to raise_error /the elephant/
      end

      it "can be cleared" do
        registry[:foo] = "bar"
        registry.clear
        expect { registry[:foo] }.to raise_error
      end
    end
  end
end
