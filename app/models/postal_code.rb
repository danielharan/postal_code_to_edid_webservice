class PostalCode < ActiveRecord::Base
  validates_format_of :code, :with => /[^\s\dDFIOQUWZ][0-9][^\s\dDFIOQU][0-9][^\s\dDFIOQU][0-9]/i
  
  def initialize(params)
    params[:code] = self.class.clean(params[:code])
    super
  end

  def self.clean(user_submited)
    user_submited.gsub(" ", '').upcase
  end
end
