# frozen_string_literal: true

module Web::Admin
  class BulletinsController < ApplicationController
    def index
      @bulletins = Bulletin.all.order('created_at DESC')
    end
  end
end
