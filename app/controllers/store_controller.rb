class StoreController < ApplicationController
  def add_to_cart
    begin
      product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid product #{params[:id]}")
      redirect_to_index("Invalid Product")
    else
      @cart = find_cart
      @cart.add_product(product)
    end
  end
  
  def empty_cart
    session[:cart] = nil
    redirect_to_index("Your cart is currently empty")
  end
  
  def index
    @products = Product.find_products_for_sale
  end

private

  def redirect_to_index(msg)
    flash[:notice] = msg
    redirect_to :action => :index
  end

  def find_cart
    session[:cart] ||= Cart.new
  end
end
