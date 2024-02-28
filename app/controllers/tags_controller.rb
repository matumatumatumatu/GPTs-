class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    # 製品に紐づくタグの場合は以下のコードを使用
    @products = @tag.products

    # 投稿に紐づくタグの場合は以下のコードを使用（必要に応じて）
    # @posts = @tag.posts
  end
end
