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

  test "scraping of edid" do
    EdidSources::ElectionsCanada.stubs(:edid_for).returns(['10007'])
    assert_equal ['10007'], PostalCode.find_or_create_via_api("A1A 1A1").edids
    
    # was getting <["10007"]> expected but was <"--- \n- \"10007\"\n">. stupid cache
    assert_equal ['10007'], PostalCode.find_or_create_via_api("A1A 1A1").edids  
  end
  
  test "scraping of edid with unknown results returned" do
    EdidSources::ElectionsCanada.stubs(:edid_for).returns([])
    assert_equal [], PostalCode.find_or_create_via_api("T5S 2B9").edids
    
    assert_equal [], PostalCode.find_or_create_via_api("T5S 2B9").edids
  end
  
  test "calling edid for a non-existent non-cached postal code returns nil" do
    EdidSources::ElectionsCanada.stubs(:edid_for).returns(nil)
    assert_equal [nil], PostalCode.find_or_create_via_api("H0H 0H0").edids
    
    assert_equal [nil], PostalCode.find_or_create_via_api("H0H 0H0").edids
  end
end
