# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def show?
    @record.published? || @record.user.id == @user&.id || @user&.admin
  end

  def update?
    @user&.id == @record&.user&.id
  end

  def archive?
    @user.admin? || @user.id == @record.user.id
  end

  def publish?
    @user.admin?
  end

  def reject?
    @user.admin?
  end

  def moderate?
    @user.id == @record.user.id
  end
end
