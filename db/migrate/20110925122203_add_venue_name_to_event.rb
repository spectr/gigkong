class AddVenueNameToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :venue_name, :string
  end

  def self.down
    remove_column :events, :venue_name
  end
end
