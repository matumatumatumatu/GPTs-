class CommentsController < ApplicationController
  before_action :restrict_guest_user_access, only: [:create]
  
def index
  if params[:member_id].present?
    @member = Member.find(params[:member_id])
    @comments = @member.comments.order(created_at: :desc)
  else
    @comments = Comment.order(created_at: :desc)
  end
end

def create
  @post = Post.find(params[:post_id])
  @comment = @post.comments.new(comment_params.merge(member: current_member))

  if @comment.save
    redirect_to post_path(@post), notice: 'コメントが追加されました。'
  else
    redirect_to post_path(@post), alert: 'コメントの追加に失敗しました。'
  end

end
  
  def destroy
  @comment = Comment.find(params[:id])
  @product = @comment.product
  if @comment.destroy
    redirect_to product_path(@product), notice: 'コメントが削除されました。'
  else
    redirect_to product_path(@product), alert: 'コメントの削除に失敗しました。'
  end
end

def member_comments 
  @member = Member.find(params[:id]) # メンバーを取得
  @comments = @member.comments.order(created_at: :desc) # そのメンバーのコメントを新しい順に取得

  render :index # indexビューを表示（または、メンバー専用のコメント一覧ビューを作成しても良い）
end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end