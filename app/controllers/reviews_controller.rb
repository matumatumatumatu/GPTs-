class ReviewsController < ApplicationController

  before_action :authenticate_member!, except: [:index, :show]
  before_action :set_product, only: [:create, :destroy]
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :check_ownership, only: [:edit, :update, :destroy]

  # 他のアクションは変更なし
  
def create
  @review = @product.reviews.build(review_params)
  @review.member = current_member
    # 新しくビルドされたコメントに対して、current_memberのidをmember_idとして設定
  @review.comment.member = current_member if @review.comment.present?
  
  if @review.save
    # デバッグ: 保存されたレビューとコメントの確認
    Rails.logger.debug("Saved review: #{@review.inspect}")
    Rails.logger.debug("Associated comment: #{@review.comment.inspect}")

    redirect_to @product, notice: 'レビューが正常に投稿されました。'
  else
    # レビュー保存失敗時のエラーをログに出力
    Rails.logger.debug(@review.errors.full_messages)
    render 'products/show', alert: 'レビューの投稿に失敗しました。'
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
  params.require(:review).permit(:rating, comment_attributes: [:content])
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