module Api
  module V1
    class ExamTypesController < ApplicationController
      before_action :set_exam_type, only: [:show, :update, :destroy]

      def index
        authorize @exam_types

        @exam_types = policy_scope(ExamType)
        render json: @exam_types
      end

      def show
        authorize @exam_type
        render json: @exam_type
      end

      def create
        authorize @exam_type
        
        @exam_type = ExamType.new(exam_type_params)
        
        if @exam_type.save
          render json: @exam_type, status: :created
        else
          render json: { errors: @exam_type.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        authorize @exam_type

        if @exam_type.update(exam_type_params)
          render json: @exam_type
        else
          render json: { errors: @exam_type.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize @exam_type

        @exam_type.destroy
        head :no_content
      end

      private

      def set_exam_type
        @exam_type = ExamType.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Exam type not found' }, status: :not_found
      end

      def exam_type_params
        params.require(:exam_type).permit(:name, :description, :preparation, :duration)
      end
    end
  end
end 