class OrdersController < ApplicationController
  before_action :check_user

  def index
    @orders = current_user.orders.reverse_order
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.ordered? || @order.paid?
      status = params[:status]
      @order.update(status: status)
      if @order.save
        flash[:success] = "Order no #{@order.id} marked as #{status}"
        redirect_to admin_dashboard_path
      end
    end
  end

  private
  def check_user
    redirect_to login_path if !current_user
  end
end
