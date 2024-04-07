class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    # 製  def show
    @tag = Tag.find(params[:id])
    @products = @tag.products
    @posts = @tag.posts # 投稿に紐づくタグの場合は、Postモデルを使って表示
  end
end