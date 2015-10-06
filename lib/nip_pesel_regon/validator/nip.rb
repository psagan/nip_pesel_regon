module NipPeselRegon
  module Validator

    # class responsible
    # for nip validation (including standard normalization)
    # please not only polish NIP's are valid with or without 'PL' prefix
    # NIP's with other prefixes like eg. 'DE', 'EN' are invalid
    class Nip < Abstract
      # array with weights
      WEIGHTS = [6, 5, 7, 2, 3, 4, 5, 6, 7]

      # pattern for NIP
      PATTERN = /^\d{10}$/

      private

      # main validation method
      def validate
        # check if NIP provided has proper format
        return false unless has_proper_format?

        # check if calculated sum modulo 11 is equal to last digit from NIP
        # if yes then validation is correct
        (calculate_sum % 11) == @number[9].to_i
      end

      # method responsible for detection if number provided has proper format
      def has_proper_format?
        !@number.nil? && matches_pattern?
      end

      # method responsible for pattern matching
      def matches_pattern?
        PATTERN =~ @number
      end

      # method responsible for sum calculation
      # every digit from first 9 digits of NIP is multiplied with corresponding
      # weight and summed
      def calculate_sum
        (0..8).to_a.inject(0) {|sum, i| sum += @number[i].to_i * WEIGHTS[i]}
      end

      # method responsible for
      # input number normalization before validation
      # 1. Makes input a string
      # 2. Removes all '-' and whitespaces
      # 3. remove 'PL' substring from the beginning if any
      def normalize
        @number = @number.to_s.gsub(/[-\s]/, '').gsub(/^PL/i, '') # only pl NIP's are valid
      end

    end
  end
end