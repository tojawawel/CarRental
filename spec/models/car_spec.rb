require 'rails_helper'

RSpec.describe Car, type: :model do
  describe 'database columns' do
    it {should have_db_column :brand}
    it {should have_db_column :model}
    it {should have_db_column :year}
    it {should have_db_column :description}
    it {should have_db_column :carpic}
    it {should have_db_column :price}
  end

  describe 'associations' do
    it {should belong_to(:user)}
  end

  describe 'validations' do
    it {should validate_presence_of(:brand)}
    it {should validate_presence_of(:model)}
    it {should validate_presence_of(:year)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:carpic)}
    it {should validate_presence_of(:price)}
    it {should validate_numericality_of(:price).is_greater_than(0).only_integer }
  end

  describe "custom methods" do
    it "has full car name - brand and model" do
      car = Car.new(brand: "Ford", model: "Focus")
      expect(car.full_car).to eq("Ford Focus")
    end
  end
end
