class BlogMailer < ApplicationMailer
  def blog_mail(blog)
    @blog = blog
    @user_email = @blog.user.email
    mail to: @user_email, subject: "投稿の確認メール"
  end
end
