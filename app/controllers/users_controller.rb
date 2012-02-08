class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  before_filter :signed_in_user_shouldnt_be_here, :only => [:new, :create]
  
  def show
    @user = User.find(params[:id])
    @title = @user.name # Rails auto-escapes ERB.
    @microposts = @user.microposts.paginate(:page => params[:page])
  end
  
  def new
    @user = User.new # Create an empty user, to be defined by submitting the form.
    @title = "Sign up"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @title = "Sign up"
      @user.password = "" # Clear the user's password and confirmation
      @user.password_confirmation = ""
      render 'new'
    end
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def edit
    @title = "Edit user"
  end

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end
  
  def destroy
    user_to_destroy = User.find(params[:id])
    if current_user?(user_to_destroy)
      flash[:error] = "Admins cannot destroy themselves."
    else
      user_to_destroy.destroy
      flash[:success] = "User destroyed."
    end
    redirect_to users_path
  end

  private
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
    
    def signed_in_user_shouldnt_be_here
      redirect_to(root_path) unless !signed_in?
    end

end
