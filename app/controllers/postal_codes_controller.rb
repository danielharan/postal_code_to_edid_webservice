class PostalCodesController < ApplicationController
  def search
    code = PostalCode.find_or_create_via_api(params[:code])
    return not_found unless code.valid?
    
    edids = code.edids
    if edids.empty?
      render :json => {"error" => "Postal code could not be resolved"}, :layout => false
    elsif edids.first.nil?
      return not_found
    else
      render :json => edids, :layout => false
    end
  end
  
  def not_found
    render :json => {"error" => "Postal code invalid"}, :layout => false, :status => 404
  end
end
