class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :is_match,only: [:edit,:update]
  def index
    @customer = current_customer
    @post = Post.new
    @customers = Customer.page(params[:page]).per(10)
  end

  def show
    @post = Post.new
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
    redirect_to public_customer_path(current_customer)
    else
    render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name,:introduction,:profile_image)
  end

  def is_match
    customer = Customer.find(params[:id])
    unless customer.id == current_customer.id
      redirect_to public_customer_path(current_customer)
    end
  end

end
