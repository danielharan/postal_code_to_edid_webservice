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
      PostalCode.expects(:scrape)
      get :search, :code => "A1A1A1"
    end
    
    should_respond_with :success
    should_respond_with_content_type 'application/json'
  end
end
