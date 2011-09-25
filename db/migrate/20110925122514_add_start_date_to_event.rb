class AddStartDateToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :start_date, :datetime
  end

  def self.down
    remove_column :events, :start_date
  end
end
