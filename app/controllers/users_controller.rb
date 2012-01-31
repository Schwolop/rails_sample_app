class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @title = @user.name # Rails auto-escapes ERB.
  end
  
  def new
    @user = User.new # Create an empty user, to be defined by submitting the form.
    @title = "Sign up"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @title = "Sign up"
      @user.password = "" # Clear the user's password and confirmation
      @user.password_confirmation = ""
      render 'new'
    end
  end
  
  def index
    @users = User.all
    render 'index'
  end

end
