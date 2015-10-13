module NipPeselRegon
  module Validator
    class Pesel < Abstract
      # last digit is 1 - it's not official weight but
      # but it will help to calculate all checksum like: a+3b+7c+9d+e+3f+7g+9h+i+3j+k
      # en - https://en.wikipedia.org/wiki/PESEL
      # pl - https://pl.wikipedia.org/wiki/PESEL
      WEIGHTS = [1, 3, 7, 9, 1, 3 ,7, 9, 1, 3, 1].freeze

      PATTERN = /^\d{11}$/

      private

      def validate
        checksum % 10 == 0
      end

    end
  end
end
