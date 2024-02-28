class FavoritesController < ApplicationController
  before_action :authenticate_member!

  def create
    @product = Product.find(params[:product_id])
    @favorite = @product.favorites.new(member: current_member)

    if @favorite.save
      redirect_to @product, notice: '製品をお気に入りに追加しました。'
    else
      redirect_to @product, alert: 'お気に入りに追加できませんでした。'
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    @favorite = @product.favorites.find_by(member: current_member)

    if @favorite
      @favorite.destroy
      redirect_to @product, notice: 'お気に入りから削除しました。'
    else
      redirect_to @product, alert: 'お気に入りを削除できませんでした。'
    end
  end
end