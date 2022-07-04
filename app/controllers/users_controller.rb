class UsersController < ApplicationController
  # method gets the User instance by user's id
  # it's used for displaying a user profile
  def show
    @user = User.find(params[:id])
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  # method gets all the users to displaying the list of users
  def index
    @users = User.paginate(page: params[:page], per_page: 2)
  end

  # method initiate a new user
  def new
    @user = User.new
  end

  # the method used for editing a user profile
  def edit
    @user = User.find(params[:id])
  end

  # method for updating users
  def update
    @user = User.find(params[:id])
    # updating new article with title and description params
    # when the article was updated parameterupdated_at updated automatically
    if @user.update(user_params)
      flash[:notice] = "Your profile was updated successfully!"
      # redirect to the articles page
      redirect_to @user
    else
      # redirecting to the edit page if the user wasn't updated
      render 'edit'
    end
  end

  # method for creating new users
  def create
     # creating new user with params(username, email, password)
     @user = User.new(user_params)
 
     # when the new user was created parameters created_at, updated_at sets automatically (see users table in schema.db)
     if @user.save
       flash[:notice] = "Welcome, #{@user.username}. You have successfully signed up!"
       # redirect to the articles page
       redirect_to articles_path
     else
       # redirecting to the new page if the user wasn't created
       render 'new'
     end
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end