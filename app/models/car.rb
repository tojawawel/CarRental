class Car < ApplicationRecord
  belongs_to :user
  has_many :reviews

  validates :brand, :model, :year, :price, :description, :carpic, presence: true
  validates :price, numericality: { greater_than:0,  only_integer: true }
  mount_uploader :carpic, CarPicUploader

  def full_car
    "#{brand} #{model}"
  end
end
