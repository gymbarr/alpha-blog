class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def show
  end

  # method assign all the articles to the instance variable
  def index
    @articles = Article.all
  end

  # method assign a new article to the instance variable
  def new
    @article = Article.new
  end

  def edit
  end

  # method for creating new articles
  def create
    # creating new article with title and description params
    @article = Article.new(article_params)

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

  # method for updatind articles
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

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end
end