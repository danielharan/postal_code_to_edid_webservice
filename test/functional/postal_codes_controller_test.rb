require 'test_helper'

class PostalCodesControllerTest < ActionController::TestCase
  context "on GET to search with invalid postal code" do
    setup do
      get :search, :code => "Z1Z1Z1"
    end
    
    should_respond_with 404
  end

  context "on GET to search with a VALID postal code that is not yet cached" do
    setup do
      PostalCode.any_instance.expects(:edid).returns({:code => "A1A1A1", :edid => ["10007"]})
      get :search, :code => "A1A1A1"
    end
    
    should_respond_with :success
    should_respond_with_content_type 'application/json'
  end
  
  context "on GET to search with a postal code that doesn't return a result" do
    setup do
      PostalCode.any_instance.expects(:edid).returns({:code => "H0H0H0", :edid => nil})
      get :search, :code => "H0H0H0"
    end
    
    should_respond_with :not_found
  end
  
  context "on GET to search with a valid postal code that can't be resolved" do
    setup do
      PostalCode.any_instance.expects(:edid).returns({:code => "T5S2B9", :edid => []})
      get :search, :code => "T5S2B9"
    end
  
    should_respond_with :success
    should_respond_with_content_type 'application/json'
  end
end
