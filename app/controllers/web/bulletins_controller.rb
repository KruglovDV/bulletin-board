module Web
  class BulletinsController < ApplicationController
    def index
      @bulletins = Bulletin.all.order(created_ad: :desc)
    end
  end
end
