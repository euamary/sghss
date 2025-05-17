module Api
  module V1
    class ExamsController < ApplicationController
      before_action :set_exam, only: [:show, :update, :destroy]

      def index
        authorize @exams

        @exams = policy_scope(Exam)
        render json: @exams
      end

      def show
        authorize @exam
        render json: @exam
      end

      def create
        authorize Exam
        
        @exam = Exam.new(exam_params)
        
        if @exam.save
          render json: @exam, status: :created
        else
          render json: { errors: @exam.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        authorize @exam

        if @exam.update(exam_params)
          render json: @exam
        else
          render json: { errors: @exam.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize @exam

        @exam.destroy
        head :no_content
      end

      private

      def set_exam
        @exam = Exam.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Exam not found' }, status: :not_found
      end

      def exam_params
        params.require(:exam).permit(
          :name, :description, :patient_id, :professional_id, 
          :date, :status, :result, :notes, :exam_type_id
        )
      end
    end
  end
end 