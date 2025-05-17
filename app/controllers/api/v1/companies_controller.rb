module Api
  module V1
    class CompaniesController < ApplicationController
      before_action :set_company, only: [:show, :update, :destroy]

      def index
        authorize @companies

        @companies = policy_scope(Company)
        render json: @companies
      end

      def show
        authorize @company
        render json: @company
      end

      def create
        authorize @company
        
        @company = Company.new(company_params)
        
        if @company.save
          render json: @company, status: :created
        else
          render json: { errors: @company.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        authorize @company

        if @company.update(company_params)
          render json: @company
        else
          render json: { errors: @company.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize @company

        @company.destroy
        head :no_content
      end

      private

      def set_company
        @company = Company.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Company not found' }, status: :not_found
      end

      def company_params
        params.require(:company).permit(:name, :cnpj, :address, :phone, :email)
      end
    end
  end
end 