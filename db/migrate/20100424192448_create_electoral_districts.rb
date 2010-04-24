class CreateElectoralDistricts < ActiveRecord::Migration
  def self.up
    create_table :electoral_districts do |t|
      t.string :name_en
      t.string :name_fr
      t.string :map_url

      t.timestamps
    end
  end

  def self.down
    drop_table :electoral_districts
  end
end
