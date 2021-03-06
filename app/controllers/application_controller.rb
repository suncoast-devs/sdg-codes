class ApplicationController < ActionController::Base
  include Pagy::Backend

  def authenticate!
    redirect_to :sign_in unless signed_in?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue StandardError
    session[:user_id] = nil
  end

  helper_method :current_user

  def signed_in?
    !current_user.nil?
  end

  helper_method :signed_in?
end
