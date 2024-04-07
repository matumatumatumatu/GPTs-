class SiteAdmin::ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      tag_ids = params[:product][:tag_ids]
      tag_ids.each do |tag_id|
        @product.tags << Tag.find(tag_id)
      end
      redirect_to @product
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end
end
