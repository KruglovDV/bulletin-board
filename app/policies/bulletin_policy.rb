# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def create?
    @user
  end

  def update?
    @user&.id == @record.user.id
  end

  def archive?
    (@user.admin? || @user.id == @record.user.id) && @record.may_archive?
  end

  def publish?
    @user.admin? && @record.may_publish?
  end

  def reject?
    @user.admin? && @record.may_reject?
  end

  def moderate?
    @user&.id == @record.user.id && @record.may_moderate?
  end
end
