# frozen_string_literal: true

module Web
  class AuthController < ApplicationController
    def callback
      @user = User.find_by(email: user_params[:email])
      @user = User.new(user_params) if @user.nil?

      if @user.save
        create_session(@user)
        redirect_to root_path, notice: t('.signed_in')
      else
        redirect_to root_path, alert: t('.cant_sign_in')
      end
    end

    def sign_out
      destroy_session
      redirect_to root_path, notice: t('.signed_out')
    end

    private

    def user_params
      user_info = request.env['omniauth.auth']['info']
      { email: user_info[:email], name: user_info[:name] || user_info[:nickname] }
    end
  end
end
