module NipPeselRegon
  module Validator
    class Base

      attr_reader :number, :original_number, :options

      def initialize(number, options = {})
        # need to make string from input number because
        # whole functionality is based on string
        @number = number.to_s
        # keep original number
        @original_number = number

        @options = options

        # normalize provided number
        normalize
      end

      def valid?
        # check if NIP provided has proper format
        return false unless has_proper_format?
        validate
      end

      def to_s
        number
      end

      private

      # method responsible for detection if number provided has proper format
      def has_proper_format?
        !number.nil? && matches_pattern?
      end

      # method responsible for pattern matching
      def matches_pattern?
        self.class::PATTERN =~ number
      end

      def validate
        raise NoMethodError, "No validate method defined in #{self.class}"
      end

      def checksum
        @checksum ||= calculate_checksum
      end

      def calculate_checksum
        NipPeselRegon::Calculator::Checksum.new(self.class::WEIGHTS, number).calculate
      end

      def normalize
        return number if options[:strict] && options[:strict] == true
        @number = number.gsub(/[-\s]/, '')
      end

    end
  end
end