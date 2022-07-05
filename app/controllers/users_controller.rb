class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # method gets the User instance by user's id
  # it's used for displaying a user profile
  def show
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
  end

  # method for updating users
  def update
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
      # sign in user when he signed up
      session[:user_id] = @user.id
      flash[:notice] = "Welcome, #{@user.username}. You have successfully signed up!"
      # redirect to the articles page
      redirect_to articles_path
    else
      # redirecting to the new page if the user wasn't created
      render 'new'
    end
  end

  # method for deleting a user
  def destroy
    @user.destroy
    # finish the deleted user session
    session[:user_id] = nil
    flash[:notice] = "Account and all associated articles successfully deleted"
    redirect_to articles_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  # get a user instance by id
  def set_user
    @user = User.find(params[:id])
  end

  # restriction for a user not made actions with another user's profiles through url
  def require_same_user
    if current_user != @user
      flash[:alert] = "You can only edit or your own profile"
      redirect_to @user
    end
  end
end