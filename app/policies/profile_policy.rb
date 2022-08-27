# frozen_string_literal: true

class ProfilePolicy
  attr_reader :user

  def initialize(user, _record)
    @user = user
  end

  def index?
    user
  end
end
