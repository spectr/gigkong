class AddVideoToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :video, :text
    add_index :events, :sk_id
  end

  def self.down
    remove_column :events, :video
  end
end
