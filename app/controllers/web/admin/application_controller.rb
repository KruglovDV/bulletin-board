# frozen_string_literal: true

class Web::Admin::ApplicationController < Web::ApplicationController
  before_action :authenticate_admin

  private

  def authenticate_admin
    return if current_user&.admin?

    redirect_to root_path
  end
end
