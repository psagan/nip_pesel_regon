require 'test_helper'
require 'supermodel'
require "nip_pesel_regon/integration/rails"


module Test
  module Integration
    module Rails
      module Nip
        class Company < SuperModel::Base
          extend ActiveModel::Validations::HelperMethods
          validates_nip_of :nip
        end

        class NipTest < Minitest::Test

          def test_that_nip_validates_properly_in_model
            c = Company.new(nip: '5882247715')
            assert c.valid?
          end

          def test_that_improper_nip_do_not_validate_in_model
            c = Company.new(nip: '5882247716')
            refute c.valid?
          end

        end
      end
    end
  end
end

