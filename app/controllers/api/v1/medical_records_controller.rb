module Api
  module V1
    class MedicalRecordsController < ApplicationController
      before_action :set_medical_record, only: [:show, :update, :destroy]

      def index
        authorize @medical_records

        @medical_records = policy_scope(MedicalRecord)
        render json: @medical_records
      end

      def show
        authorize @medical_record
        render json: @medical_record
      end

      def create
        authorize MedicalRecord
        
        @medical_record = MedicalRecord.new(medical_record_params)
        
        if @medical_record.save
          render json: @medical_record, status: :created
        else
          render json: { errors: @medical_record.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        authorize @medical_record

        if @medical_record.update(medical_record_params)
          render json: @medical_record
        else
          render json: { errors: @medical_record.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize @medical_record

        @medical_record.destroy
        head :no_content
      end

      private

      def set_medical_record
        @medical_record = MedicalRecord.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Medical record not found' }, status: :not_found
      end

      def medical_record_params
        params.require(:medical_record).permit(
          :patient_id, :professional_id, :consultation_id, 
          :date, :diagnosis, :symptoms, :treatment_plan, 
          :notes, :follow_up_date
        )
      end
    end
  end
end 