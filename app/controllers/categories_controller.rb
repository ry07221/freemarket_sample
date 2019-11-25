class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @items = Item.search_category(@category.subtree_ids).page(params[:page]).per(2).order("created_at DESC")
  end

end

