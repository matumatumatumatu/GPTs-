class PostsController < ApplicationController
  before_action :authenticate_member!, only: [:new, :create, :edit, :update]
  before_action :check_ownership, only: [:edit, :update]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_product, only: [:new, :create]

  def index
    if params[:product_id]
      @product = Product.find(params[:product_id])
      @posts = @product.posts
    else
      @posts = Post.all
    end
  end
  
def destroy
  @post.destroy
  redirect_to posts_path, notice: '投稿が削除されました。'
end

  def new
    @post = @product.posts.build # 製品に紐づいた新しい投稿を作成
  end

  def create
    @post = @product.posts.build(post_params.merge(member: current_member)) # 製品とメンバーに紐づいた投稿を作成
    if @post.save
      redirect_to @product, notice: '投稿が作成されました。' # 製品の詳細ページにリダイレクト
    else
      render :new
    end
  end
  
  def show
  @post = Post.find(params[:id])
  @comments = @post.comments.order(created_at: :desc)
  Rails.logger.debug "この投稿に関連するコメント: #{@comments.inspect}"
end
  
  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: '投稿が更新されました。'
    else
      render :edit
    end
  end

  private

def check_ownership
  @post = Post.find(params[:id])
  Rails.logger.info "Current member ID: #{current_member.id}"
  Rails.logger.info "Post member ID: #{@post.member_id}"
# byebug
  unless @post.member_id == current_member.id
    redirect_to posts_path, alert: 'You are not authorized to perform this action.'
  end
end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_product
    @product = Product.find(params[:product_id]) # 製品IDから製品を取得
  end
  
  def post_params
    params.require(:post).permit(:title, :body, :status) # statusの扱いについては、アプリケーションの要件に応じて調整してください
  end

  def member_posts
    @member = Member.find(params[:member_id])
    @posts = @member.posts
    render :index # または、メンバー専用のビューを用意する
  end
  
end