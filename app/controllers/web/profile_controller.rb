# frozen_string_literal: true

module Web
  class ProfileController < ApplicationController
    def index
      authorize :profile, :index?
      @bulletins = current_user.bulletins
    end
  end
end
