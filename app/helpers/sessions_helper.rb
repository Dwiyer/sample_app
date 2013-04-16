module SessionsHelper
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    #current_user = user
  end
  
  def signed_in?
p 11111
p #current_user
    !current_user.nil?
  end

  def sign_out
    @current_user = nil
p @current_user
    cookies.delete(:remember_token)
  end

 # def current_user=(user)
  #  @current_user = user
  #end
  
  def current_user
p 222
p cookies[:remember_token]
p @current_user
p User.find_by_remember_token(cookies[:remember_token].to_s)
    @current_user ||= User.find_by_remember_token(cookies[:remember_token].to_s)
p @current_user
  end
end
