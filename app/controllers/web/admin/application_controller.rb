# frozen_string_literal: true

class Web::Admin::ApplicationController < Web::ApplicationController
  before_action :authenticate_user!, :authorize_admin!

  private

  def authorize_admin!
    return if current_user.admin?

    deny_access
  end
end
