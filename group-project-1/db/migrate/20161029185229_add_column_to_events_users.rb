class AddColumnToEventsUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :events_users, :accepted, :boolean
  end
end
