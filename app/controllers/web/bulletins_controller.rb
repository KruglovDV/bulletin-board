# frozen_string_literal: true

module Web
  class BulletinsController < ApplicationController
    before_action :authenticate_user!, except: %i[index show]

    def index
      @q = Bulletin.ransack(params[:q])
      @bulletins = @q.result.with_attached_image.published.order('created_at DESC').page(params[:page])
      @categories = Category.all
    end

    def show
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
    end

    def new
      @bulletin = Bulletin.new
    end

    def create
      @bulletin = current_user.bulletins.build(bulletin_params)
      if @bulletin.save
        redirect_to profile_path, notice: t('.bulletin_created')
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @bulletin = current_user.bulletins.find(params[:id])
      authorize @bulletin
    end

    def update
      @bulletin = current_user.bulletins.find(params[:id])
      authorize @bulletin
      if @bulletin.update(bulletin_params)
        redirect_to profile_path, notice: t('.bulletin_updated')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def archive
      @bulletin = current_user.bulletins.find(params[:id])
      authorize @bulletin
      if @bulletin.archive!
        redirect_to profile_path, notice: t('.archived')
      else
        redirect_to profile_path, alert: t('.cant_archive')
      end
    end

    def moderate
      @bulletin = current_user.bulletins.find(params[:id])
      authorize @bulletin
      if @bulletin.moderate!
        redirect_to profile_path, notice: t('.bulletin_under_moderation')
      else
        redirect_to profile_path, alert: t('.cant_moderate')
      end
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :category_id, :image)
    end
  end
end
