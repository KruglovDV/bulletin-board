# frozen_string_literal: true

module Web
  class ProfileController < ApplicationController
    before_action :authenticate_user!

    def show
      @q = current_user.bulletins.ransack(params[:q])
      @bulletins = @q.result.order('created_at DESC').page(params[:page])
      @states = Bulletin.aasm.states
    end
  end
end
