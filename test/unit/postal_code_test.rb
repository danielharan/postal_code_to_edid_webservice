require 'test_helper'

class PostalCodeTest < ActiveSupport::TestCase
  test "cleaning of postal code" do
    assert_equal "A1A1A1", PostalCode.find_or_create_via_api("A1A 1A1").code
    assert_equal "A1A1A1", PostalCode.find_or_create_via_api("A1A1A1").code

    assert_equal "A1A1A1", PostalCode.find_or_create_via_api("a1a 1a1").code
    assert_equal "A1A1A1", PostalCode.find_or_create_via_api("a1a1a1").code
  end
  
  test "validation of code" do
    assert PostalCode.find_or_create_via_api("A1A 1A1").valid?
    
    assert ! PostalCode.find_or_create_via_api("W1A 1A1").valid?
    assert   PostalCode.find_or_create_via_api("A1W 1A1").valid?
    
    assert ! PostalCode.find_or_create_via_api("Z1A 1A1").valid?
    assert   PostalCode.find_or_create_via_api("A1Z 1A1").valid?

    assert ! PostalCode.find_or_create_via_api("junk").valid?
    assert ! PostalCode.find_or_create_via_api("Z1A1A1").valid?
  end
end
