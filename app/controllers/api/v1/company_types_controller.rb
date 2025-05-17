module Api
  module V1
    class CompanyTypesController < ApplicationController
      before_action :set_company_type, only: [:show, :update, :destroy]

      def index
        authorize @company_types

        @company_types = policy_scope(CompanyType)
        render json: @company_types
      end

      def show
        authorize @company_type
        render json: @company_type
      end

      def create
        authorize @company_type
        
        @company_type = CompanyType.new(company_type_params)
        
        if @company_type.save
          render json: @company_type, status: :created
        else
          render json: { errors: @company_type.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        authorize @company_type

        if @company_type.update(company_type_params)
          render json: @company_type
        else
          render json: { errors: @company_type.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize @company_type

        @company_type.destroy
        head :no_content
      end

      private

      def set_company_type
        @company_type = CompanyType.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Company type not found' }, status: :not_found
      end

      def company_type_params
        params.require(:company_type).permit(:name)
      end
    end
  end
end 