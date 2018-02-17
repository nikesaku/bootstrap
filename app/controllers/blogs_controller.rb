class BlogsController < ApplicationController
before_action :demand_login, only: [:new, :edit, :show, :destroy]
before_action :set_blog, only: [:show, :edit, :update, :destroy]

  def index
  end

  def articles
    @blogs = Blog.all
  end

  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    if @blog.save
      BlogMailer.blog_mail(@blog).deliver
      redirect_to articles_blogs_path, notice: 'ブログを作成しました！'
    else
      render 'new'
    end
  end

  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
    @post = Blog.find_by(id: params[:id])
    @user = User.find_by(id: @post.user_id)
  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      redirect_to articles_blogs_path, notice: 'ブログを編集しました！'
    else
      render 'edit'
    end
  end

  def destroy
    @blog.destroy
    redirect_to articles_blogs_path, notice: 'ブログを削除しました！'
  end

  def confirm
    @blog = Blog.new(blog_params)
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :content)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def demand_login
    unless !current_user.nil?
      flash[:danger] = 'ログインしてください'
      redirect_to new_session_path
    end
  end

end
