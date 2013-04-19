class UsersController < ApplicationController
  protect_from_forgery
  include SessionsHelper

  before_filter :authenticate, 
	only: [:edit, :update, :index, :destroy, :following, :followers]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success]="Welcome to the Sample App!"
      redirect_to @user    
    else
      render 'new'
    end
  end
  
  def show
    @user=User.find(params[:id])
    @microposts=@user.microposts.paginate(page: params[:page])
  end

  def index
    @users=User.paginate(page: params[:page], per_page: 10)
  end
  
  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    if @user.update_attributes(params[:user])
      if @user.is_admin?
        @user.name+="(admin)" 
        @user.save
      end
      flash[:success]="Profile updated!"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end 

  def destroy
    User.find(params[:id]).destroy
    flash[:success]="User destroy."
    redirect_to users_path
  end
  
  def following
    @title="Following"
    @user=User.find(params[:id])
    @users=@user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title="Followers"
    @user=User.find(params[:id])
    @users=@user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
  def admin_user
    redirect_to(root_path) unless current_user.is_admin?
  end
end
