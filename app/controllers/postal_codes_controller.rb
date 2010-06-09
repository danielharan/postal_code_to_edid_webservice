class PostalCodesController < ApplicationController
  def search
    code = PostalCode.find_or_create_via_api(params[:code])
    return render :text => "postal code invalid", :layout => false, :status => 404 unless code.valid?
    
    edid = code.edid
    if edid[:edid].nil?
      render :text => "postal code invalid", :layout => false, :status => 404
    else
      render :json => edid.to_json
    end
  end
end
