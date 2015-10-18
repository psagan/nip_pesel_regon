require 'test_helper'

module Test
  module Validator
    class NotValidTest < Minitest::Test

      def test_that_not_valid_always_return_false
        validator = NipPeselRegon::Validator::NotValid.new
        refute validator.valid?
      end

    end
  end
end
