class ProductsController < ApplicationController
 before_action :set_product, only: [:show, :edit, :update, :destroy]
 before_action :authenticate_member!, only: [:new, :edit]

  def index
    if params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @products = @tag.products
    else
      @products = Product.all
    end
  end

def show
  @product = Product.find(params[:id])
  @reviews = @product.reviews.includes(:comment)

  # デバッグ: 取得されたレビューの数と最初のレビューの内容を確認
  Rails.logger.debug("Number of reviews: #{@reviews.size}")
  @reviews.each do |review|
    Rails.logger.debug("Review: #{review.inspect}, Comment: #{review.comment.inspect}")
  end

  @new_review = @product.reviews.build
end

def new
  @product = Product.find(params[:product_id])
  @review = @product.reviews.build
  @review.build_comment # Commentのインスタンスを初期化
end

def edit
  @product = Product.find(params[:id])
  logger.debug "Editing product: #{@product.inspect}"
end
  
def member_products
  @member = Member.find(params[:id]) # 正しいパラメータ名に修正

  @products = @member.products

  render :index # または、メンバー専用のビューを用意する
end
  
def create
  @review = @product.reviews.new(review_params.merge(member: current_member))

  if @review.save
    redirect_to @product, notice: 'レビューが正常に投稿されました。'
  else
    flash[:alert] = 'レビューの投稿に失敗しました。' + @review.errors.full_messages.join(", ")
    redirect_to @product
  end
end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to @product, notice: '製品情報が正常に更新されました。'
    else
      render :edit
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      @product.destroy
    end
    redirect_to products_path, notice: '製品が正常に削除されました。'
  rescue ActiveRecord::RecordNotDestroyed
    redirect_to products_path, alert: '製品の削除に失敗しました。'
  end

private
  def product_params
    params.require(:product).permit(:name, :description)
  end
  
  def set_product
      @product = Product.find(params[:id])
  end

end