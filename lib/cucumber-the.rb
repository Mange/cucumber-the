module Cucumber
  module The
  end
end

require "cucumber-the/version"
require "cucumber-the/registry"

The = Cucumber::The::Registry.new

Before do
  The.clear
end
