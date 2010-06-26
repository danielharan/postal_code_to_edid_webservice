require 'test_helper'

class PostalCodesControllerTest < ActionController::TestCase
  context "on GET to search with invalid postal code" do
    setup do
      get :search, :code => "Z1Z1Z1"
    end
    
    should_respond_with 404
    should "respond with error message" do
      assert_equal({"error" => "Postal code invalid"}, JSON.parse(@response.body))
    end
  end

  context "on GET to search with a VALID postal code that is not yet cached" do
    setup do
      PostalCode.any_instance.expects(:edids).returns(["10007"])
      get :search, :code => "A1A1A1"
    end
    
    should_respond_with :success
    should_respond_with_content_type 'application/json'
    
    should "respond with error message" do
      assert_equal ["10007"], JSON.parse(@response.body)
    end
  end
  
  context "on GET to search with a postal code that doesn't return a result" do
    setup do
      PostalCode.any_instance.expects(:edids).returns([nil])
      get :search, :code => "H0H0H0"
    end
    
    should_respond_with :not_found
    should "respond with error message" do
      assert_equal({"error" => "Postal code invalid"}, JSON.parse(@response.body))
    end
  end
  
  context "on GET to search with a valid postal code that can't be resolved" do
    setup do
      PostalCode.any_instance.expects(:edids).returns([])
      get :search, :code => "T5S2B9"
    end
  
    should_respond_with :success
    should_respond_with_content_type 'application/json'
    should "respond with error message" do
      assert_equal({"error" => "Postal code could not be resolved", "link"  => "http://www.elections.ca/scripts/pss/FindED.aspx?PC=T5S2B9&amp;image.x=0&amp;image.y=0"}, JSON.parse(@response.body))
    end
  end
end
