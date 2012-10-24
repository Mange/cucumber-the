Given 'a feature "$name" with the following scenario:' do |name, scenario_body|
  @cucumber_factory.create_feature name, scenario_body
end

Given 'step definitions:' do |body|
  @cucumber_factory.create_step_definitions 'all.rb', body
end

Given 'the gem is loaded' do
  gempath = File.expand_path '../../../lib', __FILE__
  @cucumber_factory.create_support 'env.rb', <<-RUBY
    $LOAD_PATH << #{gempath.inspect}
    require "cucumber-the"
  RUBY
end

When 'I run the features' do
  @cucumber_factory.run
end

Then 'all scenarios should pass' do
  unless @cucumber_factory.status.success?
    fail "Some scenario did not pass. Output:\n#{@cucumber_factory.output}"
  end
end

Then 'a scenario should fail' do
  if @cucumber_factory.status.success?
    fail "Scenarios passed, but shouldn't have. Output:\n#{@cucumber_factory.output}"
  end
end

Then 'a scenario should fail with:' do |text|
  fail "Scenarios passed" if @cucumber_factory.status.success?
  @cucumber_factory.output.should include text
end
