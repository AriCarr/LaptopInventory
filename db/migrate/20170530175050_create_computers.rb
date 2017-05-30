class CreateComputers < ActiveRecord::Migration[5.0]
  def change
    create_table :computers do |t|
      t.string :name
      t.boolean :active
      t.string :owner
      t.string :manufacturer
      t.string :model
      t.string :serial
      t.string :product
      t.integer :space
      t.float :processor
      t.float :ram

      t.timestamps
    end
  end
end
