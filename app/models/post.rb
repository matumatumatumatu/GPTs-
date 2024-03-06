class Post < ApplicationRecord
    belongs_to :member
    belongs_to :product
    has_many :comments, dependent: :destroy
end
