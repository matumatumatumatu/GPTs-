class ReviewsController < ApplicationController

  before_action :authenticate_member!, except: [:index, :show]
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :check_ownership, only: [:edit, :update, :destroy]

  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
  end
  
  def show
    
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to reviews_path, notice: 'Review was successfully created.'
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

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:member_id, :product_id, :rating, :comment, :review_date)
  end

  # レビューの所有者かどうかをチェックするメソッド
  def check_ownership
    unless @review.member == current_member
      redirect_to reviews_path, alert: 'You are not authorized to perform this action.'
    end
  end
end