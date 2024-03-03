module CommentsHelper
  def comment_belongs_to_current_member?(comment)
    comment.member == current_member
  end
end
