# frozen_string_literal: true

module Web::Admin
  class BulletinsController < ApplicationController
    def index
      @q = Bulletin.ransack(params[:q])
      @bulletins = @q.result.order('created_at DESC')
      @states = Bulletin.aasm.states.map(&:name)
    end

    def archive
      authorize_action
      @bulletin.archive!
      redirect_back fallback_location: root_path
    end

    def publish
      authorize_action
      @bulletin.publish!
      redirect_back fallback_location: root_path
    end

    def reject
      authorize_action
      @bulletin.reject!
      redirect_back fallback_location: root_path
    end

    private

    def authorize_action
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
    end
  end
end
