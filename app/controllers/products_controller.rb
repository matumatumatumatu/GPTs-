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
end

  def new
    @product = Product.new
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
  @product = Product.new(product_params)
  @product.member = current_member
  if @product.save
    post = @product.posts.create(
      title: @product.name,
      body: "この製品についてのスレッドです。",
      member: current_member
    )
    redirect_to @product, notice: '製品が正常に作成され、関連するスレッドが追加されました。'
  else
    render :new
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