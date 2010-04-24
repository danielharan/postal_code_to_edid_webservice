class PostalCodesController < ApplicationController
  def search
    code = PostalCode.find_or_create_by_code(params[:code])

    if ! code.valid?
      render :text => "postal code invalid", :layout => false, :status => 404
    else
      render :json => code.edid.to_json
    end
  end
end
