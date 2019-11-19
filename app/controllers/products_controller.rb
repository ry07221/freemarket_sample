class ProductsController < ApplicationController

  def index
    @products = Product.includes(:images).order('created_at DESC')
  end
  
  def new
    @product = Product.new
    @product.images.build  ## 新規画像用
    # 関連したモデルのインスタンスを新しく作る場合はbuildメソッドを使用
  end
  
  def create
  end
  
  def edit
    @product = current_user.products.find(params[:id])
    @product.images.build  ## 新規画像用
  end
  
  def update
  end
  
  def destroy
  end
  
end