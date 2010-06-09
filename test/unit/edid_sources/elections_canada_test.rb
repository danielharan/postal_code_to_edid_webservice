require 'test_helper'

class EdidSources::ElectionsCanadaTest < ActiveSupport::TestCase
  test "should return nil when no results are found" do
    page = stub(:uri     => "http://www.elections.ca/scripts/pss/FindED.aspx?PC=H0H0H0&image.x=0&image.y=0",
                :content => fixture_file("H0H0H0.html"))
    EdidSources::ElectionsCanada.expects(:scrape).with("H0H0H0").returns(page)
    
    assert_equal nil, EdidSources::ElectionsCanada.edid_for("H0H0H0")
  end
  
  test "should a single result when possible" do
    page = stub(:uri => "http://www.elections.ca/scripts/pss/InfovoteMain_ne.aspx?" +
                        "L=e&ED=10007&EV=99&EV_TYPE=6&PC=A1A1A1&Prov=&ProvID=&MapID=&QID=-1&PageID=21&TPageID=")
    EdidSources::ElectionsCanada.expects(:scrape).with("A1A1A1").returns(page)
    
    assert_equal ["10007"], EdidSources::ElectionsCanada.edid_for("A1A1A1")
  end
  
  test "should return an empty array when more than 1 possibility exists" do
    page = stub(:uri     => "http://www.elections.ca/scripts/pss/FindED.aspx?PC=T5S2B9&image.x=0&image.y=0",
                :content => fixture_file("T5S2B9.html"))
    EdidSources::ElectionsCanada.expects(:scrape).with("T5S2B9").returns(page)
    
    assert_equal [], EdidSources::ElectionsCanada.edid_for("T5S2B9")
  end
end
