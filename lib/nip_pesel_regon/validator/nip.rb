module NipPeselRegon
  module Validator

    # Class responsible
    # for NIP validation (including standard normalization).
    # Please note that only polish NIP's are valid with or without 'PL' prefix.
    # NIP's with other prefixes like eg. 'DE', 'EN' are invalid
    class Nip < Base
      # array with weights
      WEIGHTS = [6, 5, 7, 2, 3, 4, 5, 6, 7].freeze

      # pattern for NIP
      PATTERN = /^\d{10}$/

      private

      # main validation method
      def validate
        # check if calculated checksum modulo 11 is equal to last digit of NIP
        # if yes then validation is correct
        (checksum % 11) == number[-1].to_i
      end

      # Method responsible for
      # input number normalization before validation
      # - standard normalization + remove 'PL' substring from the beginning if any
      def normalize
        @number = super.gsub(/^PL/i, '') # only pl NIP's are valid
      end

    end
  end
end