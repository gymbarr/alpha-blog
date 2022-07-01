class UsersController < ApplicationController
  # method initiate a new user
  def new
    @user = User.new
  end

  # method for creating new users
  def create
     # creating new user with params(username, email, password)
     @user = User.new(user_params)
 
     # when the new user was created parameters created_at, updated_at sets automatically (see users table in schema.db)
     if @user.save
       flash[:notice] = "Welcome, #{@user.username}. You have successfully signed up!"
       # redirect to the new article show page
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