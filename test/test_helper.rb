# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require_relative "minifactory"
require "minitest/autorun"

# Kludgey convenience method so we can compare arrays without caring about
# the order of their elements
# TODO: probably shouldn't live here. make it a refinement? write a custom
#       minitest matcher?
# class Array
module Enumerable
  def same_elements_as?(other)
    to_set == other.to_set
  end
end

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
