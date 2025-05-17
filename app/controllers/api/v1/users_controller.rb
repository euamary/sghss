module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: [:show, :update, :destroy]
      allow_unauthenticated_access if: :public_registration_allowed?

      def index
        authorize @users

        @users = policy_scope(User)
        render json: @users
      end

      def show
        authorize @user
        render json: @user
      end

      def create
        if !current_user && public_registration_allowed?
          user_params_with_role = user_params.merge(role: 'patient')
          @user = User.new(user_params_with_role)
        else
          authorize User
          @user = User.new(user_params)
        end
        
        if @user.save
          render json: @user, status: :created
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        authorize @user

        if @user.update(user_params)
          render json: @user
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize @user

        @user.destroy
        head :no_content
      end

      private

      def set_user
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'User not found' }, status: :not_found
      end

      def user_params
        if current_user&.admin?
          params.require(:user).permit(:email, :password, :password_confirmation, :name, :role, 
                                     :company_id, :specialty, :registration_number)
        else
          params.require(:user).permit(:email, :password, :password_confirmation, :name,
                                     :company_id, :specialty, :registration_number)
        end
      end

      def public_registration_allowed?
        Setting.find_by(key: 'allow_public_registration')&.value == 'true'
      end
    end
  end
end 