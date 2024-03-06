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

  
  def show
    
  end

  def create
    @review_form = ReviewForm.new(review_form_params)
    if @review_form.save
      redirect_to product_path(params[:review_form][:product_id]), notice: 'レビューとコメントが正常に投稿されました。'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to reviews_path, notice: 'Review was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to reviews_path, notice: 'Review was successfully destroyed.'
  end

  private

  def review_form_params
    params.require(:review_form).permit(:rating, :review_comment, :comment_content, :product_id).merge(member_id: current_member.id)
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