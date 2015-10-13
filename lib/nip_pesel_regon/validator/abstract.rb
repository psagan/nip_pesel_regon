module NipPeselRegon
  module Validator
    class Abstract

      attr_reader :number, :original_number, :checksum_calculator, :options

      def initialize(number, options = {})
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
        @checksum = checksum_calculator.calculate unless @checksum
        @checksum
      end

      def checksum_calculator
        set_checksum_calculator unless @checksum_calculator
        @checksum_calculator
      end

      def normalize
        return number if options[:strict] && options[:strict] == true
        @number = number.gsub(/[-\s]/, '')
      end

      def set_checksum_calculator
        @checksum_calculator = NipPeselRegon::Calculator::Checksum.new(self.class::WEIGHTS, number)
      end

    end
  end
end