require 'test_helper'

class EdidSources::ElectionsCanadaTest < ActiveSupport::TestCase
  test "should return nil when no results are found" do
    response = mock('Net::HTTPOK')
    response.stubs(:[]).with("Location").returns(nil)
    response.stubs(:body).returns(fixture_file("H0H0H0.html"))

    EdidSources::ElectionsCanada.expects(:scrape).with("H0H0H0").returns(response)
    
    assert_equal [nil], EdidSources::ElectionsCanada.edids_for("H0H0H0")
  end
  
  test "should a single result when possible" do
    response = mock('Net::HTTPFound')
    response.stubs(:[]).with("Location").returns(  "/scripts/pss/InfovoteMain_ne.aspx?L=e&ED=10007&EV=99&EV_TYPE=6&PC=A1A1A1&Prov=&ProvID=&MapID=&QID=-1&PageID=21&TPageID=")
    EdidSources::ElectionsCanada.expects(:scrape).with("A1A1A1").returns(response)
    
    assert_equal ["10007"], EdidSources::ElectionsCanada.edids_for("A1A1A1")
  end
  
  test "should return an empty array when more than 1 possibility exists" do
    response = mock('Net::HTTPOK')
    response.stubs(:[]).with("Location").returns(nil)
    response.stubs(:body).returns(fixture_file("T5S2B9.html"))

    EdidSources::ElectionsCanada.expects(:scrape).with("T5S2B9").returns(response)
    
    assert_equal [], EdidSources::ElectionsCanada.edids_for("T5S2B9")
  end
end
