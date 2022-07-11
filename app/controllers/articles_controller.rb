class ArticlesController < ApplicationController
  # get article object by id
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  # check that a user is logged in (order of calling methods :require_user and :require_same_user is matter! )
  before_action :require_user, except: [:show, :index]
  # check that the same user is logged in
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # the method for displaying an article show page
  def show
  end

  # the method assign all the articles to the instance variable to show page of listing articles
  # with the use of will_paginate gem here was added a pagination
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  # method initiate a new article
  def new
    @article = Article.new
  end

  def edit
  end

  # method for creating new articles
  def create
    
    # creating new article with title and description params
    @article = Article.new(article_params)
    # the author of the creating article is now logged in user
    @article.user = current_user

    # when the new article was created parameters created_at, updated_at sets automatically (see articles table in schema.db)
    if @article.save
      flash[:notice] = "Article was created successfully!"
      # redirect to the new article show page
      redirect_to @article
    else
      # redirecting to the new page if article wasn't created
      render 'new'
    end
  end

  # method for updating articles
  def update
    # updating new article with title and description params
    # when the article was updated parameterupdated_at updated automatically
    if @article.update(article_params)
      flash[:notice] = "Article was updated successfully!"
      # redirect to the article show page
      redirect_to @article
    else
      # redirecting to the edit page if article wasn't updated
      render 'edit'
    end
  end

  # method for deleting articles
  def destroy
    @article.destroy
    # redirecting to the articles listing page
    redirect_to articles_path
  end

  private

  # get an article instance by id
  def set_article
    @article = Article.find(params[:id])
  end

  # whitelisting articles params
  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  # restriction for a user not made actions with another user's articles through url
  def require_same_user
    # check if current user is the author of the article or the admin
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own articles"
      redirect_to @article
    end
  end
end