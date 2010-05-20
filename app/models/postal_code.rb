class PostalCode < ActiveRecord::Base
  validates_format_of :code, :with => /[^\s\dDFIOQUWZ][0-9][^\s\dDFIOQU][0-9][^\s\dDFIOQU][0-9]/i
  
  has_many :postal_code_assignments
  
  def edid
    assignment = if (assigned = postal_code_assignments).length > 0
      assigned.first
    else
      scrape(code)
    end
    
    {:code => code, :edid => assignment.edid}
  end
  
  def scrape(code)
    edid = EdidSources::ElectionsCanada.edid_for(code)
    postal_code_assignments.create :source_id          => Source.find_by_name("Elections Canada"),
                                   :electoral_district => ElectoralDistrict.find_or_create_by_edid(edid)
  end
  
  class << self
    def find_or_create_via_api(user_submitted_code)
      find_or_create_by_code user_submitted_code.gsub(" ", '').upcase
    end
  end
end
