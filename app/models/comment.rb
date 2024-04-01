class Comment < ApplicationRecord
  belongs_to :review
  belongs_to :product, optional: true
  belongs_to :member
  belongs_to :post, optional: true
end
