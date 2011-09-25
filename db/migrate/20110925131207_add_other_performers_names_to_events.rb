class AddOtherPerformersNamesToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :other_performers_names, :string
  end

  def self.down
    remove_column :events, :other_performers_names
  end
end
