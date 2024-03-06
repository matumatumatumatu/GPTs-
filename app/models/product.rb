class Product < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :member
  has_many :posts
  has_many :reviews, dependent: :destroy
end
