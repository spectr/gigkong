class AddSkIdToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :sk_id, :integer
  end

  def self.down
    remove_column :events, :sk_id
  end
end
