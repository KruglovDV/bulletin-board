class BulletinPolicy < ApplicationPolicy
  def create?
    @user
  end
end
