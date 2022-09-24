# frozen_string_literal: true

class AdminBulletinPolicy < ApplicationPolicy
  def index?
    @user.admin?
  end
end
