require 'cucumber-the/registry'

Given 'there is a The registry' do
  @the_registry = Cucumber::The::Registry.new
end

Given /^I try to access :(\w+) from the registry$/ do |key|
  @the_key = key.to_sym
end

Then 'I should get an error containing "$message"' do |message|
  expect {
    @the_registry[@the_key]
  }.to raise_error { |error| error.message.should include message }
end
