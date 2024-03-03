class CommentsController < ApplicationController
  before_action :restrict_guest_user_access, only: [:create]
  
  def index
    @comments = current_member.comments.order(created_at: :desc)
  end

def create
  @product = Product.find(params[:product_id])
  @comment = @product.comments.new(comment_params.merge(member: current_member))
  if @comment.save
    redirect_to product_path(@product), notice: 'コメントが追加されました。'
  else
    redirect_to product_path(@product), alert: 'コメントの追加に失敗しました。'
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

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end