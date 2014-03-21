# encoding: UTF-8
require 'spec_helper'

module Cucumber
  module The
    describe Registry do
      subject(:registry) { Registry.new }
      after(:each) { registry.clear }

      it "can set and access values using hash notation" do
        registry[:foo] = "bar"
        registry[:foo].should == "bar"
      end

      it "can set and access values using messages" do
        registry.foo = "bar"
        registry.foo.should == "bar"
      end

      it "does not differentiate between symbols and strings" do
        registry[:foo] = "bar"
        registry["foo"].should == "bar"

        registry["bar"] = "baz"
        registry[:bar].should == "baz"
      end

      it "can tell if a key is set" do
        registry.should_not have_key(:foo)
        registry.should_not have_key('foo')

        registry.foo = "bar"

        registry.should have_key('foo')
        registry.should have_key(:foo)
      end

      it "raises an error when accessing unset values using hash notation" do
        expect {
          registry[:elephant]
        }.to raise_error /the elephant/
      end

      it "raises an error when accessing unset values using hash notation" do
        expect {
          registry.elephant
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
