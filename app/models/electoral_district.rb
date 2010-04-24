class ElectoralDistrict < ActiveRecord::Base
  has_many :postal_code_assignments
end
