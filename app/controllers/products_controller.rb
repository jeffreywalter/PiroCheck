class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_url
  end

  def create
    @product = Product.new(product_params)
    @product.save
    redirect_to products_url
  end

  private

  def product_params
    params.require(:product).permit(:name, :url)
  end
end
