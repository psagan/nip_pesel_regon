module NipPeselRegon
  module Validator
    # Base validation class with common functionality for validators.
    # Provides common public interface for validators.
    class Base

      attr_reader :number, :original_number, :options

      def initialize(number, options = {})
        # need to make input number a string because
        # whole functionality is based on strings
        @number = number.to_s
        # keep original number
        @original_number = number

        @options = options

        # normalize provided number
        normalize
      end

      # Check if number is valid.
      def valid?
        # check if number provided has proper format
        return false unless has_proper_format?
        validate
      end

      # To string conversion returns normalized number.
      def to_s
        number
      end

      private

      # method responsible for detection if number provided has proper format
      def has_proper_format?
        !number.nil? && matches_pattern?
      end

      # Method responsible for pattern matching.
      # Uses PATTERN constant from subclass.
      def matches_pattern?
        self.class::PATTERN =~ number
      end

      # Internal validation method - need to be overriden in subclasses.
      def validate
        raise NoMethodError, "No validate method defined in #{self.class}"
      end

      # Get checksum calculated by checksum calculator.
      def checksum
        @checksum ||= calculate_checksum
      end

      # Calculate checksum - uses checksum calculator.
      # Known dependency here as there are no other calculators
      # so for not complicating the code dependent class is placed directly here.
      def calculate_checksum
        NipPeselRegon::Calculator::Checksum.new(self.class::WEIGHTS, number).calculate
      end

      # Number normalization which depends on option provided.
      # Normalizes number when no 'strict' option.
      # Removes dashes and whitespaces from number.
      def normalize
        return number if options[:strict] && options[:strict] == true
        @number = number.gsub(/[-\s]/, '')
      end

    end
  end
end