require "cucumber-the/version"
require "cucumber-the/registry"

module Cucumber
  module The
  end
end

The = Cucumber::The::Registry.new
