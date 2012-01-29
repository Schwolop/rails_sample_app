class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @title = @user.name # Rails auto-escapes ERB.
  end
  
  def new
    @title = "Sign up"
  end

end
