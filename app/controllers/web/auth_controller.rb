module Web
  class AuthController < ApplicationController
    def callback
      @user = User.find_or_initialize_by(user_params)
      session[:user_id] = @user.id if @user.save
      redirect_to root_path
    end

    private

    def user_params
      user_info = request.env['omniauth.auth']['info']
      { email: user_info[:email], name: user_info[:name] }
    end
  end
end