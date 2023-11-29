class Public::PostsController < ApplicationController
  before_action :authenticate_customer!
  before_action :is_match,only: [:edit,:update]
  def index
    @customer = current_customer
    @posts = Post.all
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      flash[:notice] = "投稿成功"
    redirect_to post_path(@post.id)
    else
    @posts = Post.all
    flash[:alert] = "投稿失敗"
    render :index
    @post = Post.new
    end
  end

  def show
    @post_new = Post.new
    @comment = PostComment.new
    @post = Post.find(params[:id])
    @customer = @post.customer
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title,:body)
  end

  def is_match
    post = Post.find(params[:id])
    unless post.customer_id == current_customer.id
      redirect_to public_customer_path(current_customer)
    end
  end

end
