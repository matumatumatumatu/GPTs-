class ProductsController < ApplicationController

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
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end
  
  def member_products
    @member = Member.find(params[:member_id])
    @products = @member.products
    render :index # または、メンバー専用のビューを用意する
  end
  
end