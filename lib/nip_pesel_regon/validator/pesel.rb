module NipPeselRegon
  module Validator
    class Pesel < Abstract
      # last digit is 1 - it's not official weight but
      # but it will help to calculate all checksum like: a+3b+7c+9d+e+3f+7g+9h+i+3j+k
      # https://pl.wikipedia.org/wiki/PESEL
      WEIGHTS = [1, 3, 7, 9, 1, 3 ,7, 9, 1, 3, 1].freeze

      PATTERN = /^\d{11}$/

      attr_reader :checksum_calculator

      def initialize(number)
        super
        @checksum_calculator = NipPeselRegon::Calculator::Checksum.new(WEIGHTS, @number)
      end

      private

      def validate
        # check if PESEL provided has proper format
        return false unless has_proper_format?
        calculate_sum % 10 == 0
      end

      # method responsible for detection if number provided has proper format
      def has_proper_format?
        !@number.nil? && matches_pattern?
      end

      # method responsible for pattern matching
      def matches_pattern?
        PATTERN =~ @number
      end

      def calculate_sum
        @checksum_calculator.calculate
      end

      def normalize
        @number = @number.to_s.gsub(/[-\s]/, '')
      end
    end
  end
end
