class PostalCodeAssignment < ActiveRecord::Base
  belongs_to :postal_code
  belongs_to :source
  belongs_to :electoral_district
end
