class CreateEventsUsersJoinTable < ActiveRecord::Migration[5.0]

  def change
    create_join_table :events, :users
  end

end
