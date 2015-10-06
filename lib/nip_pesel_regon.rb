require "nip_pesel_regon/version"
require 'nip_pesel_regon/calculator/checksum'
require 'nip_pesel_regon/validator/abstract'
require "nip_pesel_regon/validator/nip"
require "nip_pesel_regon/validator/regon"

if defined? Rails
  require "nip_pesel_regon/integration/rails/nip"
end


module NipPeselRegon
  # Your code goes here...
end
