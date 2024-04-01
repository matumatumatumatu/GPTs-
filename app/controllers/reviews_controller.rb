class ReviewsController < ApplicationController

  before_action :authenticate_member!, except: [:index, :show]
  before_action :set_product, only: [:create, :destroy]
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :check_ownership, only: [:edit, :update, :destroy]

  # 他のアクションは変更なし
  
def create
  @review = current_member.reviews.build(review_params.merge(product_id: @product.id))
  if @review.save
    redirect_to @product, notice: 'レビューが正常に投稿されました。'
  else
    redirect_to @product, alert: '投稿に失敗しました。'
  end
end

  def destroy
    @review.destroy
    redirect_to product_path(@review.product), notice: 'レビューが削除されました。'
  end

  private

    def set_product
      @product = Product.find(params[:product_id])
    end

def review_params
  params.require(:review).permit(:rating, comment_attributes: [:content, :member_id, :product_id])
end

    def set_review
        @review = Review.find(params[:id])
    end

    # レビューの所有者かどうかをチェックするメソッド
    def check_ownership
        unless @review.member == current_member
          redirect_to reviews_path, alert: 'You are not authorized to perform this action.'
        end
    end
end