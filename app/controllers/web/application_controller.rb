class Web::ApplicationController < ApplicationController
  helper_method :signed_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def signed_in?
    session[:user_id].present? && current_user.present?
  end
end
