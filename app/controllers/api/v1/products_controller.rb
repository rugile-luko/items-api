class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: %i[show update destroy]

  # GET /products
  def index
    @products = Product.by_title(params[:title]).paginate(page: params[:page], per_page: 20)
    render json: {
      current_page: @products.current_page,
      per_page: @products.per_page,
      total_entries: @products.total_entries,
      products: @products
    }
  end

  # GET /products/1
  def show
    render json: @product, status: :ok
  end

  # POST /products
  def create
    @product = Product.create(product_params)
    if @product.save
      render json: @product, status: :created, location: api_v1_product_url(@product)
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.permit(:title, :description, :price, :status, :user_id)
  end
end
