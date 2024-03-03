class Product < ApplicationRecord
  has_many :comments, dependent: :destroy
end
