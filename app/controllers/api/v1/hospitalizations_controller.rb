module Api
  module V1
    class HospitalizationsController < ApplicationController
      before_action :set_hospitalization, only: [:show, :update, :destroy]

      def index
        authorize @hospitalizations

        @hospitalizations = policy_scope(Hospitalization)
        render json: @hospitalizations
      end

      def show
        authorize @hospitalization
        render json: @hospitalization
      end

      def create
        authorize Hospitalization
        
        @hospitalization = Hospitalization.new(hospitalization_params)
        
        if @hospitalization.save
          render json: @hospitalization, status: :created
        else
          render json: { errors: @hospitalization.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        authorize @hospitalization

        if @hospitalization.update(hospitalization_params)
          render json: @hospitalization
        else
          render json: { errors: @hospitalization.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize @hospitalization

        @hospitalization.destroy
        head :no_content
      end

      private

      def set_hospitalization
        @hospitalization = Hospitalization.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Hospitalization not found' }, status: :not_found
      end

      def hospitalization_params
        params.require(:hospitalization).permit(
          :patient_id, :professional_id, :bed_id, 
          :admission_date, :discharge_date, :reason, 
          :diagnosis, :treatment_summary, :notes, :status
        )
      end
    end
  end
end 