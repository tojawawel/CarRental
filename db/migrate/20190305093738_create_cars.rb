class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.string :brand
      t.string :model
      t.date :year
      t.integer :price
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
