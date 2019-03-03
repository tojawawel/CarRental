class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone_number, :string
    add_index :users, :phone_number, unique: true
    add_column :users, :gender, :string
    add_column :users, :date_of_birth, :date
  end
end
