# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def create?
    @user
  end
end
