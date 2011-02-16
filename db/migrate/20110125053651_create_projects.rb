class CreateProjects < ActiveRecord::Migration
  
  def self.up
    create_table :projects do |t|
      t.string :name
      t.string :link
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size
      t.datetime :photo_updated_at
      t.string :year
      t.integer :position
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
  
end
