class CreatePortfolios < ActiveRecord::Migration
  def self.up
    create_table :portfolios do |t|
      t.string :name 
      t.integer :position
      t.integer :photos_count, :default => 0
      t.boolean :visible, :default => true
      t.references :rep_photo
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :portfolios
  end
end
