# frozen_string_literal: true

class Web::ApplicationController < ApplicationController
  helper_method :signed_in?
  rescue_from Pundit::NotAuthorizedError, with: :deny_access

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def signed_in?
    session[:user_id].present? && current_user.present?
  end

  def deny_access(_exception)
    redirect_to root_path, alert: t('common.please_sing_in')
  end
end
