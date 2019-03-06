class AlterRoleColumnInUsers < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :gender, 'integer USING CAST(gender AS integer)'
  end
  def down
    change_column :users, :gender, :string
  end
end
