class ChangeEventArtistNameColumnToHeadliner < ActiveRecord::Migration
  def self.up
    rename_column :events, :artist_name, :headliner
  end

  def self.down
  end
end
