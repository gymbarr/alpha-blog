class UsersController < ApplicationController
  # method initiate a new user
  def new
    @user = User.new
  end
end