module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :require_authentication, only: [ :create ]
      
      def create
        if user = User.authenticate_by(email_address: user_params[:email_address], password: user_params[:password])
          session = user.sessions.create!(user_agent: request.user_agent, ip_address: request.remote_ip)
          render json: { token: session.token }, status: :created
        else
          render json: { error: I18n.t("authentication.errors.invalid_credentials") }, status: :unauthorized
        end
      end

      def destroy
        Current.session.destroy
        head :no_content
      end

      private

      def user_params
        params.require(:user).permit(:email_address, :password)
      end
    end
  end
end 