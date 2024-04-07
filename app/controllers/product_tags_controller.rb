class ProductTagsController < ApplicationController
  before_action :set_product

  def create
    tag = Tag.find(params[:tag_id])
    @product.tags << tag
    redirect_to @product, notice: 'タグを追加しました。'
  end

  def destroy
    tag = @product.tags.find(params[:id])
    @product.tags.delete(tag)
    redirect_to @product, notice: 'タグを削除しました。'
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end
end
