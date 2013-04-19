class MicropostsController < ApplicationController
  protect_from_forgery
  include SessionsHelper
  before_filter :authenticate
  before_filter :correct_user, only: :destroy
  def create
    @micropost=current_user.microposts.build(params[:micropost])
    if @micropost.save
p 11111
      @feed_items=current_user.feed.paginate(page: params[:page])#why need?
      flash[:success]="Micropost created!"#it disappears when use ajax
      render 'success'
    else
      @feed_items=current_user.feed.paginate(page: params[:page])#why need?
      #respond_to do |format|
        #format.html { redirect_to root_path }
        #format.js
      #end
      render 'failed'
p 33333
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end
  private
  def correct_user
    @micropost=current_user.microposts.find_by_id(params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
