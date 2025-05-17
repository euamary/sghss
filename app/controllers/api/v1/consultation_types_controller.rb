module Api
  module V1
    class ConsultationTypesController < ApplicationController
      before_action :set_consultation_type, only: [:show, :update, :destroy]

      def index
        authorize @consultation_types

        @consultation_types = policy_scope(ConsultationType)
        render json: @consultation_types
      end

      def show
        authorize @consultation_type
        render json: @consultation_type
      end

      def create
        authorize @consultation_type
        
        @consultation_type = ConsultationType.new(consultation_type_params)
        
        if @consultation_type.save
          render json: @consultation_type, status: :created
        else
          render json: { errors: @consultation_type.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        authorize @consultation_type

        if @consultation_type.update(consultation_type_params)
          render json: @consultation_type
        else
          render json: { errors: @consultation_type.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize @consultation_type

        @consultation_type.destroy
        head :no_content
      end

      private

      def set_consultation_type
        @consultation_type = ConsultationType.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Consultation type not found' }, status: :not_found
      end

      def consultation_type_params
        params.require(:consultation_type).permit(:name, :description, :duration)
      end
    end
  end
end 