require "nip_pesel_regon/version"
require 'nip_pesel_regon/calculator/checksum'
require 'nip_pesel_regon/validator/base'
require "nip_pesel_regon/validator/nip"
require "nip_pesel_regon/validator/regon"
require "nip_pesel_regon/validator/regon9"
require "nip_pesel_regon/validator/regon14"
require "nip_pesel_regon/validator/pesel"
require "nip_pesel_regon/validator/not_valid"


if defined? Rails
  require "nip_pesel_regon/integration/rails"
end


module NipPeselRegon
end
