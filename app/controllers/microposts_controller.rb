class MicropostsController < ApplicationController
  before_filter :authenticate

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
  end
end