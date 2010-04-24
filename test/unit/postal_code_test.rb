require 'test_helper'

class PostalCodeTest < ActiveSupport::TestCase
  test "cleaning of postal code" do
    assert_equal "A1A1A1", PostalCode.clean("A1A 1A1")
    assert_equal "A1A1A1", PostalCode.clean("A1A1A1")
    
    assert_equal "A1A1A1", PostalCode.clean("a1a 1a1")
    assert_equal "A1A1A1", PostalCode.clean("a1a1a1")
  end
  
  test "validation of code" do
    assert PostalCode.new(:code => "A1A 1A1").valid?
    
    assert ! PostalCode.new(:code => "W1A 1A1").valid?
    assert   PostalCode.new(:code => "A1W 1A1").valid?
    
    assert ! PostalCode.new(:code => "Z1A 1A1").valid?
    assert   PostalCode.new(:code => "A1Z 1A1").valid?

    assert ! PostalCode.new(:code => "junk").valid?
    assert ! PostalCode.new(:code => "Z1A1A1").valid?
  end
end
