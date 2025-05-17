module Api
  module V1
    class RolesController < ApplicationController
      before_action :set_role, only: [:show, :update, :destroy]

      def index
        authorize @roles

        @roles = policy_scope(Role)
        render json: @roles
      end

      def show
        authorize @role
        render json: @role
      end

      def create
        authorize @role
        
        @role = Role.new(role_params)
        
        if @role.save
          render json: @role, status: :created
        else
          render json: { errors: @role.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        authorize @role

        if @role.update(role_params)
          render json: @role
        else
          render json: { errors: @role.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize @role

        @role.destroy
        head :no_content
      end

      private

      def set_role
        @role = Role.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Role not found' }, status: :not_found
      end

      def role_params
        params.require(:role).permit(:name, :description)
      end
    end
  end
end 