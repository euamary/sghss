module Api
  module V1
    class ConsultationsController < ApplicationController
      before_action :set_consultation, only: [:show, :update, :destroy]

      def index
        authorize @consultations

        @consultations = policy_scope(Consultation)
        render json: @consultations
      end

      def show
        authorize @consultation
        render json: @consultation
      end

      def create
        authorize Consultation
        
        @consultation = Consultation.new(consultation_params)
        
        if @consultation.save
          render json: @consultation, status: :created
        else
          render json: { errors: @consultation.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        authorize @consultation

        if @consultation.update(consultation_params)
          render json: @consultation
        else
          render json: { errors: @consultation.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize @consultation

        @consultation.destroy
        head :no_content
      end

      private

      def set_consultation
        @consultation = Consultation.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Consultation not found' }, status: :not_found
      end

      def consultation_params
        params.require(:consultation).permit(
          :patient_id, :professional_id, :scheduled_date, 
          :start_time, :end_time, :status, :notes, :reason
        )
      end
    end
  end
end 