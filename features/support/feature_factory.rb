require 'pathname'
require 'tmpdir'
require 'timeout'

class CucumberFactory
  def self.use
    Dir.mktmpdir do |dir|
      @instance = new dir
      yield
    end
  ensure
    @instance = nil
  end

  def self.instance() @instance end

  attr_reader :status, :output

  def initialize(root)
    @root = Pathname(root)
    @status = nil
    @output = "(Have not been run yet)"
  end

  def create_feature(name, body)
    @root.join(name).open('w') do |file|
      file << "Feature: #{clean_name name}\n\n"
      file << body
    end
  end

  def create_step_definitions(name, body)
    @root
      .join('step_definitions')
      .tap { |dir| dir.mkpath }
      .join(name)
      .open('w') { |file| file << body }
  end

  def run
    Timeout.timeout(2) do
      IO.popen([$0, @root.to_s, err: [:child, :out]]) do |output|
        @output = output.read
      end
      @status = $?
    end
  end

  private
  def clean_name(name)
    name.gsub(/\.feature$/, '').gsub('_', ' ')
  end
end

Around do |scenario, block|
  CucumberFactory.use(&block)
end

Before do
  @cucumber_factory = CucumberFactory.instance
end
