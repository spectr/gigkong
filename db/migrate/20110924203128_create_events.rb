class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.integer :artist_id
      t.integer :venue_id

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
