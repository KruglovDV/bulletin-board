# frozen_string_literal: true

module Web::Admin
  class HomeController < ApplicationController
    def index
      authorize Bulletin, policy_class: AdminHomePolicy
      @bulletins = Bulletin.under_moderation.order('created_at DESC').page(params[:page])
    end
  end
end
