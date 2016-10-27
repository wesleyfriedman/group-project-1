class CreateEventUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :event_users do |t|
      t.integer :event_id
      t.integer :user_id
      t.boolean :host, :default => false

      t.timestamps
    end
  end
end
