class PostalCode < ActiveRecord::Base
  validates_format_of :code, :with => /[^\s\dDFIOQUWZ][0-9][^\s\dDFIOQU][0-9][^\s\dDFIOQU][0-9]/i
  
  has_many :postal_code_assignments
  
  def edids
    scrape(code) unless postal_code_assignments.length > 0
    
    postal_code_assignments.collect(&:edid)
  end
  
  def scrape(code)
    EdidSources::ElectionsCanada.edids_for(code).each do |edid|
      postal_code_assignments.create :source_id          => Source.find_by_name("Elections Canada"),
                                     :electoral_district => ElectoralDistrict.find_or_create_by_edid(edid)
    end
  end
  
  class << self
    def find_or_create_via_api(user_submitted_code)
      find_or_create_by_code user_submitted_code.gsub(" ", '').upcase
    end
  end
end
