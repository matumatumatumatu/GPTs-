class CommentsController < ApplicationController
  before_action :restrict_guest_user_access, only: [:create]
  before_action :set_comment, only: [:destroy] # この行を追加
  before_action :authorize_member!, only: [:destroy] # この行を追加

  
def index
  if params[:member_id].present?
    @member = Member.find(params[:member_id])
    @comments = @member.comments.order(created_at: :desc)
  else
    @comments = Comment.order(created_at: :desc)
  end
end

def create
  @post = Post.find(params[:post_id]) # ここを修正: @product -> @post
  @comment = @post.comments.new(comment_params.merge(member: current_member))

  if @comment.save
    Rails.logger.debug "コメントが保存されました: #{@comment.inspect}"
    redirect_to post_path(@post), notice: 'コメントが追加されました。'
  else
    Rails.logger.debug "コメントの保存に失敗しました: #{@comment.errors.full_messages.join(", ")}"
    redirect_to post_path(@post), alert: 'コメントの追加に失敗しました。'
  end
end

  def destroy
    # コメントが製品または投稿に関連しているかに基づいてリダイレクト先を決定
    redirect_path = @comment.product_id.present? ? product_path(@comment.product_id) : post_path(@comment.post_id)
    @comment.destroy
    redirect_to redirect_path, notice: 'コメントが削除されました。'
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def authorize_member!
    unless @comment.member == current_member
      redirect_to root_path, alert: 'コメントの削除は許可されていません。'
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end