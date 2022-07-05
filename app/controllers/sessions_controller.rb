class SessionsController < ApplicationController
  def new
  end

  # the method for sign in users
  def create
    # find the user by entered email
    # to prevent case sensivity errors using downcase method
    user = User.find_by(email: params[:session][:email].downcase)
    # if user with such email exist and was entered a correct password
    if user && user.authenticate(params[:session][:password])
      # session id stores the signed in user's id
      session[:user_id] = user.id
      flash[:notice] = "Signed in successfully"
      # show user's profile page
      redirect_to user
    else
      # authenticate with errors
      flash.now[:alert] = "Incorrect email or password"
      render 'new'
    end
  end

  # the method delete a session when a user loged out
  def destroy
    session[:user_id] = nil
    # flash[:notice] = "Signed out"
    # show home page
    redirect_to root_path
  end
end