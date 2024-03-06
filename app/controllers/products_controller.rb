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
    logger.debug "関連する投稿の数: #{@product.posts.count}"
    
    @comments = @product.comments.order(created_at: :desc) # 新しいコメントから表示
    @comment = Comment.new(product: @product)
    @reviews = @product.reviews
    @review = Review.new
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end
  
def member_products
  @member = Member.find(params[:id]) # 正しいパラメータ名に修正
  logger.debug "Member: #{@member.inspect}" # メンバーのデバッグ出力
  
  @products = @member.products
  logger.debug "Products: #{@products.inspect}" # 製品のデバッグ出力
  
  render :index # または、メンバー専用のビューを用意する
end
  
def create
  @product = Product.new(product_params)
  @product.member = current_member

  if @product.save
    # 製品の保存に成功したら、関連する投稿を自動で作成
    @product.posts.create!(
      title: @product.name,
      body: "この製品についてのスレッドです。",
      member: current_member
    )
    redirect_to @product, notice: '製品が正常に作成され、関連するスレッドが追加されました。'
  else
    render :new
  end
end

  def destroy
    # 同じ名前を持つすべての製品を検索
    same_name_products = Product.where(name: @product.name)
    same_name_products.each do |product|
      product.destroy
    end
    redirect_to products_path, notice: '製品と同名の製品がすべて削除されました。'
  end

private
  def product_params
    params.require(:product).permit(:name, :description)
  end
  
  def set_product
      @product = Product.find(params[:id])
  end

end