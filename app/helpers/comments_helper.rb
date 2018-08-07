module CommentsHelper
  def user_is_authorized_for_comment?(comment)
   current_user && (current_user == comment.user || current_user.admin?)
  end

  def no_comments(user)
    "#{user.name} has not submitted any comments yet."
  end

end
