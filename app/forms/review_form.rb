class ReviewForm
  include ActiveModel::Model

  attr_accessor :rating, :review_comment, :comment_content, :product_id, :member_id

  validates :rating, presence: true
  validates :review_comment, presence: true
  validates :comment_content, presence: true

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      review = Review.create!(rating: rating, comment: review_comment, product_id: product_id, member_id: member_id)
      Comment.create!(content: comment_content, product_id: product_id, member_id: member_id)
    end

    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end