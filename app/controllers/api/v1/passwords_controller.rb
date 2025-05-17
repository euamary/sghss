module Api
  module V1
    class PasswordsController < ApplicationController
      allow_unauthenticated_access
      before_action :set_user_by_token, only: %i[ edit update ]

      def new; end

      def create
        if user = User.find_by(email_address: params[:email_address])
          user.regenerate_token_for(:password_reset)
          PasswordsMailer.with(user: user).reset.deliver_later
        end

        head :ok
      end

      def edit
      end

      def update
        if user = User.find_by_token_for(:password_reset, params[:token])
          user.update(password_params)
          user.clear_token_for(:password_reset)
          head :ok
        else
          render json: { error: I18n.t('authentication.errors.invalid_token') }, status: :bad_request
        end
      end

      private
      
      def set_user_by_token
        @user = User.find_by_password_reset_token!(params[:token])
      rescue ActiveSupport::MessageVerifier::InvalidSignature
        redirect_to new_password_path, alert: "Password reset link is invalid or has expired."
      end

      def password_params
        params.permit(:password, :password_confirmation)
      end
    end
  end
end 