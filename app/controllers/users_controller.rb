class UsersController < ApplicationController
  def new
  end

  def create
    user = User.new(user_params)
    # remove leading/trailing whitespaces
    user.email = user.email.strip
    user.name = user.name.strip
    
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
