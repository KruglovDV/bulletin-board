module Web
  class BulletinsController < ApplicationController
    def index
      @bulletins = Bulletin.all.order(created_ad: :desc)
    end

    def new
      @bulletin = Bulletin.new
    end

    def create
      @bulletin = current_user.bulletins.build(bulletin_params)
      if @bulletin.save
        redirect_to root_path, notice: t('.bulletin_created')
      else
        render :new
      end
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :category_id)
    end
  end
end
