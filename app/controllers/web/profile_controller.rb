# frozen_string_literal: true

module Web
  class ProfileController < ApplicationController
    def index
      authorize :profile, :index?
      @q = current_user.bulletins.ransack(params[:q])
      @bulletins = @q.result.order('created_at DESC').page(params[:page])
      @states = Bulletin.aasm.states.map(&:name)
    end
  end
end
