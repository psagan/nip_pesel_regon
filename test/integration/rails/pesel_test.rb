require 'test_helper'
require 'supermodel'
require "nip_pesel_regon/integration/rails"

module Test
  module Integration
    module Rails
      module Pesel
        class Company < SuperModel::Base
          extend ActiveModel::Validations::HelperMethods
          validates_pesel_of :pesel
        end

        class PeselTest < Minitest::Test

          def test_that_pesel_validates_properly_in_model
            c = Company.new(pesel: '00291600815')
            assert c.valid?
          end

          def test_that_improper_pesel_do_not_validate_in_model
            c = Company.new(pesel: '12345678901')
            refute c.valid?
          end

        end
      end
    end
  end
end


