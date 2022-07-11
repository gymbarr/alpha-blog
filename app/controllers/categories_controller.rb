class CategoriesController < ApplicationController
  # almost all operations with categories require admin permission
  before_action :require_admin, except: [:index, :show]
  # get a category object by it's id
  before_action :set_category, only: [:edit, :update, :destroy, :show]

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

  # the method for editing a category name
  def edit
  end

  # method for updating categories
  def update
    # updating category with the name params
    if @category.update(category_params)
      flash[:notice] = "Category was updated successfully!"
      # redirect to the category show page
      redirect_to @category
    else
      # redirecting to the edit page if category wasn't updated
      render 'edit'
    end
  end

  # method for deleting a category
  def destroy
    @category.destroy
    flash[:notice] = "The category was successfully deleted"
    redirect_to categories_path
  end

  # the method assign all the categories to the instance variable to show page of listing categories
  # with the use of will_paginate gem here was added a pagination
  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  # the method for displaying a category show page
  def show
    @articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  private

  # whitelisting a category parameters
  def category_params
    params.require(:category).permit(:name)
  end

  # get a category object by id
  def set_category
    @category = Category.find(params[:id])
  end

  # the method check if the current user is admin
  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "You don't have permission to do that action"
      redirect_to categories_path
    end
  end
end