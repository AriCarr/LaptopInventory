class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :is_admin, default: false
      t.boolean :active, default: false
      t.boolean :can_edit, default: false
      t.timestamps
    end
    add_index :users, :name
    add_index :users, :email
    add_index :users, [:name, :email], unique: true
  end
end
