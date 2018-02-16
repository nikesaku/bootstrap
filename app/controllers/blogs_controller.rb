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
    if @blog.save
      redirect_to articles_blogs_path, notice: 'ブログを作成しました！'
    else
      render 'new'
    end
  end

  def show
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
    render :new if @blog.invalid?
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :content)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def demand_login
    unless !current_user.nil?
      flash[:danger] = 'ログインしてください'
      redirect_to new_session_path
    end
  end

end
