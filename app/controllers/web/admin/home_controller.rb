# frozen_string_literal: true

module Web::Admin
  class HomeController < ApplicationController
    def index
      @bulletins = Bulletin.under_moderation.order('created_at DESC').page(params[:page])
    end
  end
end
