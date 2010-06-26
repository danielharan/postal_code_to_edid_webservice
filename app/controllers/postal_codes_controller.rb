class PostalCodesController < ApplicationController
  def search
    response.headers['Cache-Control'] = 'public, max-age=300'
    
    code = PostalCode.find_or_create_via_api(params[:code])
    return not_found unless code.valid?
    
    edids = code.edids
    if edids.empty?
      render :json => {"error" => "Postal code could not be resolved",
        "link"  => "http://www.elections.ca/scripts/pss/FindED.aspx?PC=#{code.code}&amp;image.x=0&amp;image.y=0"}, :layout => false
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
