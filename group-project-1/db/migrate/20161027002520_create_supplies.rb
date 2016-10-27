class CreateSupplies < ActiveRecord::Migration[5.0]
  def change
    create_table :supplies do |t|
      t.string :name
      t.integer :quantity
      t.float :unit_cost
      t.integer :task_id

      t.timestamps
    end
  end
end
