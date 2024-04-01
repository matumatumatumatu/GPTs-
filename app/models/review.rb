class Review < ApplicationRecord
  belongs_to :member
  belongs_to :product
  has_one :comment, dependent: :destroy
end
