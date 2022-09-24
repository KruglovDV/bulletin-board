# frozen_string_literal: true

module Web::Admin
  class BulletinsController < ApplicationController
    def index
      authorize Bulletin, policy_class: AdminBulletinPolicy
      @q = Bulletin.ransack(params[:q])
      @bulletins = @q.result.order('created_at DESC').page(params[:page])
      @states = Bulletin.aasm.states
    end

    def archive
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin

      if @bulletin.archive!
        redirect_back fallback_location: root_path, notice: t('.archived')
      else
        redirect_back fallback_location: root_path, alert: t('.cant_archive')
      end
    end

    def publish
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin

      if @bulletin.publish!
        redirect_back fallback_location: root_path, notice: t('.published')
      else
        redirect_back fallback_location: root_path, alert: t('.cant_publish')
      end
    end

    def reject
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin

      if @bulletin.reject!
        redirect_back fallback_location: root_path, notice: t('.rejected')
      else
        redirect_back fallback_location: root_path, alert: t('.cant_reject')
      end
    end
  end
end
