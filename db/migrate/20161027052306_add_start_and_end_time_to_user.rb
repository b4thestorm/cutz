class AddStartAndEndTimeToUser < ActiveRecord::Migration
  def change
    add_column :users, :start_time, :datetime
    add_column :users, :end_time, :datetime
  end
end
