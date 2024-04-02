class Review < ApplicationRecord
  belongs_to :member
  belongs_to :product
  has_one :comment, dependent: :destroy
  accepts_nested_attributes_for :comment
end
