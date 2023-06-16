require "helper"
require "fluent/plugin/out_logplex_splitter.rb"

class LogplexSplitterOutputTest < Test::Unit::TestCase
  setup do
    Fluent::Test.setup
  end

  test "failure" do
    flunk
  end

  private

  def create_driver(conf)
    Fluent::Test::Driver::Output.new(Fluent::Plugin::LogplexSplitterOutput).configure(conf)
  end
end
