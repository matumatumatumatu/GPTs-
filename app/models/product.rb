class Product < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  
  belongs_to :member
  
  has_many :posts, dependent: :destroy
  
  has_many :comments, dependent: :destroy
  
  has_many :reviews, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorited_members, through: :favorites, source: :member
  
  has_many :product_tags
  has_many :tags, through: :product_tags
  
  has_many :site_admin_product_tags
  has_many :tags, through: :site_admin_product_tags
end
