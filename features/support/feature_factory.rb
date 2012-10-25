require 'pathname'
require 'tmpdir'
require 'timeout'

class CucumberFactory
  def self.use
    # Travis CI + JRuby have trouble with Dir.mktmpdir. After the resource
    # block is done Dir tries to remove the tmp directory, but that fails in
    # that configuration. We ignore these errors, but only after safeguarding
    # that we're not ignoring errors that was actually caused by our own code.
    error_in_test = false

    Dir.mktmpdir do |dir|
      @instance = new dir
      begin
        yield
      rescue Errno::EACCES
        error_in_test = true
        raise
      end
    end
  rescue Errno::EACCES => error
    raise if error_in_test
    warn "Could not remove temporary directory. Error: #{error}"
  ensure
    @instance = nil
  end

  def self.instance() @instance end

  attr_reader :status, :output

  def initialize(root)
    @root = Pathname(root)
    @status = nil
    @output = "(Have not been run yet)"
    ensure_structure
  end

  def create_feature(name, body)
    @root.join(name).open('w') do |file|
      file << "Feature: #{clean_name name}\n\n"
      file << body
    end
  end

  def create_step_definitions(name, body)
    create_file @root.join('step_definitions', name), body
  end

  def create_support(name, body)
    create_file @root.join('support', name), body
  end

  def run
    IO.popen("#{$0} #{@root.to_s}") do |output|
      @output = output.read
    end
    @status = $?
  end

  private
  def clean_name(name)
    name.gsub(/\.feature$/, '').gsub('_', ' ')
  end

  def ensure_structure
    @root.join('support').mkpath
    @root.join('step_definitions').mkpath
  end

  def create_file(path, body)
    path.open('w') { |file| file << body }
  end
end

Around do |scenario, block|
  CucumberFactory.use(&block)
end

Before do
  @cucumber_factory = CucumberFactory.instance
end
