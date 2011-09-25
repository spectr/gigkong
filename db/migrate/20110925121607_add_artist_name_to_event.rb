class AddArtistNameToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :artist_name, :string
  end

  def self.down
    remove_column :events, :artist_name
  end
end
