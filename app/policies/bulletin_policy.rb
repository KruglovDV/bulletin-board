# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def show?
    @record.published? || record_belongs_to_user? || @user&.admin
  end

  def update?
    record_belongs_to_user?
  end

  def archive?
    record_belongs_to_user?
  end

  def moderate?
    record_belongs_to_user?
  end

  private

  def record_belongs_to_user?
    @user&.id == @record&.user_id
  end
end
