module NipPeselRegon
  module Calculator

    # This class is responsible
    # for calculating checksum based
    # on weights.
    #
    # Takes two arguments:
    # - weights
    # - number
    #
    # Example:
    #
    # weights = [ 2, 3, 4]
    # number = '123'
    #
    # calculator = NipPeselRegon::Calculator::Checksum.new(weights, number)
    # calculator.calculate # returns 20
    #
    class Checksum

      attr_reader :number, :weights

      def initialize(weights, number)
        @weights = weights
        @number = number
      end

      def calculate
        weights.each_with_index.inject(0) {|sum, (weight, i)| sum + number[i].to_i * weight}
      end

    end
  end
end