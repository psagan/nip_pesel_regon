require 'test_helper'

# @todo - check if add namespace here
class RegonTest < Minitest::Test

  def test_true
    NipPeselRegon::Validator::Regon.new(56)
    assert true
  end

end