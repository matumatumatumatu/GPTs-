class Tag < ApplicationRecord
  has_many :product_tags
  has_many :products, through: :product_tags
  has_many :site_admin_product_tags
  has_many :products, through: :site_admin_product_tags
end
