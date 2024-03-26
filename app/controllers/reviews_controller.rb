class ReviewsController < ApplicationController

  before_action :authenticate_member!, except: [:index, :show]
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :check_ownership, only: [:edit, :update, :destroy]

  def index
    @reviews = Review.all
  end

  def new
    @review_form = ReviewForm.new
  end

def create
  @review_form = ReviewForm.new(review_form_params)
  Rails.logger.debug { "Review Form Params: #{review_form_params.inspect}" } # パラメータの確認
  if @review_form.save
    Rails.logger.debug { "Review successfully saved." }
    redirect_to product_path(@review_form.product_id), notice: 'レビューが正常に投稿されました。'
  else
    Rails.logger.debug { "Failed to save review." }
    redirect_to product_path(@review_form.product_id), alert: 'レビューの投稿に失敗しました。'
  end
end
  
  def show
    
  end


  def edit
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to product_path(@review.product_id), notice: 'レビューが更新されました。'
    else
      render :edit, alert: 'レビューの更新に失敗しました。'
    end
  end

  def destroy
    @review.destroy
    redirect_to reviews_path, notice: 'Review was successfully destroyed.'
  end

  private


def review_form_params
  params.require(:review_form).permit(:rating, :review_comment, :comment_content).merge(member_id: current_member.id, product_id: params[:product_id])
end

  def review_params
    # 必要なパラメータの設定。例えば:
    params.require(:review).permit(:rating, :comment)
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