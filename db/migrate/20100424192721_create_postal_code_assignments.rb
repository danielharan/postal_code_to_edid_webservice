class CreatePostalCodeAssignments < ActiveRecord::Migration
  def self.up
    create_table :postal_code_assignments do |t|
      t.integer :postal_code_id
      t.integer :electoral_district_id
      t.integer :source_id

      t.timestamps
    end
  end

  def self.down
    drop_table :postal_code_assignments
  end
end
