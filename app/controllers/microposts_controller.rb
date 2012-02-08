class MicropostsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy

  def create
    @micropost  = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @feed_items = [] # Suppress the feed entirely if the post failed.
      render 'pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_back_or root_path
  end

  private

    def authorized_user
      if current_user.admin?
        @micropost = Micropost.find_by_id(params[:id])
      else
        @micropost = current_user.microposts.find_by_id(params[:id])
      end
      redirect_to root_path if @micropost.nil?
    end
end