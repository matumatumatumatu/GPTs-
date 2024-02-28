# postはレビュー対象と概要
class PostsController < ApplicationController
  before_action :authenticate_member!, only: [:new, :create, :edit, :update]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :check_ownership, only: [:edit, :update]

  def index
    @posts = Post.all
  end

def destroy
  @post.destroy
  redirect_to posts_path, notice: '投稿が削除されました。'
end

  def new
    @post = Post.new
  end

def create
  @post = current_member.posts.new(post_params)
  if @post.save
    redirect_to @post, notice: '投稿が保存されました。'
  else
    render :new
  end
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
  
  def post_params
    params.require(:post).permit(:title, :body, :status, tag_ids: [])
  end
end