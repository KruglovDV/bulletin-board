# frozen_string_literal: true

class AdminHomePolicy < ApplicationPolicy
  def index?
    @user.admin?
  end
end
