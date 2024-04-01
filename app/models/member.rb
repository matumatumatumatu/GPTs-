class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :favorites
  has_many :favorite_products, through: :favorites, source: :product
  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :products
  has_many :reviews, dependent: :destroy 
end
