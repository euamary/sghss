module Api
  module V1
    class PrescriptionsController < ApplicationController
      before_action :set_prescription, only: [:show, :update, :destroy]

      def index
        authorize @prescriptions

        @prescriptions = policy_scope(Prescription)
        render json: @prescriptions
      end

      def show
        authorize @prescription
        render json: @prescription
      end

      def create
        authorize Prescription
        
        @prescription = Prescription.new(prescription_params)
        
        if @prescription.save
          render json: @prescription, status: :created
        else
          render json: { errors: @prescription.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        authorize @prescription

        if @prescription.update(prescription_params)
          render json: @prescription
        else
          render json: { errors: @prescription.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize @prescription

        @prescription.destroy
        head :no_content
      end

      private

      def set_prescription
        @prescription = Prescription.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Prescription not found' }, status: :not_found
      end

      def prescription_params
        params.require(:prescription).permit(
          :patient_id, :professional_id, :date, 
          :notes, :status, :expiry_date,
          medication_items_attributes: [:id, :medication_id, :dosage, :frequency, :duration, :instructions, :_destroy]
        )
      end
    end
  end
end 