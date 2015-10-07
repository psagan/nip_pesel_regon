module NipPeselRegon
  module Validator
    class Pesel < Abstract

      WEIGHTS = [1, 3, 7, 9, 1, 3 ,7, 9, 1, 3, 1].freeze

      attr_reader :checksum_calculator

      def initialize(number)
        super
        @checksum_calculator = NipPeselRegon::Calculator::Checksum.new(WEIGHTS, @number)
      end

      private

      def validate
        return false
      end

      def normalize
        @number
      end
    end
  end
end
