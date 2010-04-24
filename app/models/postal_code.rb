class PostalCode < ActiveRecord::Base
  validates_format_of :code, :with => /[^\s\dDFIOQUWZ][0-9][^\s\dDFIOQU][0-9][^\s\dDFIOQU][0-9]/i
  
  has_many :postal_code_assignments
  
  def edid
    if (assigned = postal_code_assignments).length > 0
      assigned.first
    else
      self.class.scrape(code)
      # TODO: create the assignment for a specific source
    end
  end
  
  class << self
    def find_or_create_via_api(user_submitted_code)
      find_or_create_by_code user_submitted_code.gsub(" ", '').upcase
    end

    def scrape(code)
      {:code => "not implemented"}.to_json
    end
  end
end
