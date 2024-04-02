class Comment < ApplicationRecord
  belongs_to :member, optional: true
  belongs_to :review
  belongs_to :product, optional: true
  belongs_to :post, optional: true
  validates :member, presence: true, unless: -> { review.present? }
end
