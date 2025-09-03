ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/mock"
require "factory_bot_rails"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Make FactoryBot's methods (build, create, etc.) available in tests
    include FactoryBot::Syntax::Methods

    # Add more helper methods to be used by all tests here...
  end
end
