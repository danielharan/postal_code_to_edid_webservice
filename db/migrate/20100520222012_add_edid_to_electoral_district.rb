class AddEdidToElectoralDistrict < ActiveRecord::Migration
  def self.up
    add_column :electoral_districts, :edid, :string
  end

  def self.down
    remove_column :electoral_districts, :edid
  end
end
