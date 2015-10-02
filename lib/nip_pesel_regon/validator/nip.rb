module NipPeselRegon
  module Validator
    class Nip < Abstract
      # array with weights
      WEIGHTS = [6, 5, 7, 2, 3, 4, 5, 6, 7]

      # pattern for NIP
      PATTERN = /^(PL)?(\d{10})$/i

      private

      # main validation method
      def validate
        # check if NIP provided has proper format
        return false unless has_proper_format?

        # extract all numbers from NIP provided
        @raw_nip = extract_numbers

        # check if calculated sum modulo 11 is equal to last digit from NIP
        (calculate_sum % 11) == @raw_nip[9].to_i
      end

      def has_proper_format?
        !@num.nil? && !@num.empty? && matches_pattern?
      end

      def matches_pattern?
        PATTERN =~ @num
      end

      # calculate
      def calculate_sum
        (0..8).to_a.inject(0) {|sum, i| sum += @raw_nip[i].to_i * WEIGHTS[i]}
      end

      def extract_numbers
        @num.match(PATTERN).captures[1]
      end

      # method responsible for
      # input number normalization.
      # 1. Makes input a string
      # 2. Removes all '-' and whitespaces
      #
      #
      #
      def normalize
        @num = @num.to_s.gsub(/[-\s]/, '')
        # @num = @num.to_s
      end

    end
  end
end