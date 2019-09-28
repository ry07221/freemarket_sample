class Product < ApplicationRecord
  has_many :images 
  has_one :dealing
  belongs_to :user
  belongs_to :category
end
