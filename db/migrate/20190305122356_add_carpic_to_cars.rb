class AddCarpicToCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :carpic, :string
  end
end
