
# NipPeselRegon - rc2

[![Build Status](https://travis-ci.org/psagan/nip_pesel_regon.svg?branch=master)](https://travis-ci.org/psagan/nip_pesel_regon)

Validates polish identification numbers NIP, PESEL, REGON. Can be used in any ruby script or integrated with Rails validation

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nip_pesel_regon'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nip_pesel_regon

## Usage

```ruby
class Company < ActiveRecord::Base
    validates_nip_of :my_nip_field
    validates_pesel_of :my_pesel_field
    validates_regon_of :my_regon_field
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/psagan/nip_pesel_regon.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

