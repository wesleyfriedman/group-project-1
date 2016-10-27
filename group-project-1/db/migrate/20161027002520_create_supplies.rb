class CreateSupplies < ActiveRecord::Migration[5.0]
  def change
    create_table :supplies do |t|
      t.string :name
      t.integer :quantity
      t.integer :unit_cost

      t.timestamps
    end
  end
end
