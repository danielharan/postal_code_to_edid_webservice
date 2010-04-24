class CreatePostalCodes < ActiveRecord::Migration
  def self.up
    create_table :postal_codes do |t|
      t.string :code
      t.string :freebase_id

      t.timestamps
    end
  end

  def self.down
    drop_table :postal_codes
  end
end
