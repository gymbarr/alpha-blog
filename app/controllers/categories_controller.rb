class CategoriesController < ApplicationController

  # the method creates a new Category object
  def new
    @category = Category.new
  end

  def create
    # creating a new category with params(name)
    @category = Category.new(category_params)

    # when a new category was created parameters created_at, updated_at sets automatically (see users table in schema.db)
    if @category.save
      flash[:notice] = "Category \"#{@category.name}\" was successfully created!"
      # redirect to the category page
      redirect_to @category
    else
      # redirecting to the new page if the category wasn't created
      render 'new'
    end
  end

  # the method assign all the categories to the instance variable to show page of listing categories
  # with the use of will_paginate gem here was added a pagination
  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def show
    @category = Category.find(params[:id])
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end