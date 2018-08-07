module PostsHelper
  def user_is_authorized_for_post?(post)
    current_user !=nil && ((current_user == post.user || current_user.admin?) || (current_user == post.user || current_user.moderator?))
end
  def no_posts(user)
    "#{user.name} has not submitted any posts yet."
 end
end
