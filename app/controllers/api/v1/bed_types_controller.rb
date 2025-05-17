module Api
  module V1
    class BedTypesController < ApplicationController
      before_action :set_bed_type, only: [:show, :update, :destroy]

      def index
        authorize @bed_types

        @bed_types = policy_scope(BedType)
        render json: @bed_types
      end

      def show
        authorize @bed_type
        render json: @bed_type
      end

      def create
        authorize @bed_type
        
        @bed_type = BedType.new(bed_type_params)
        
        if @bed_type.save
          render json: @bed_type, status: :created
        else
          render json: { errors: @bed_type.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        authorize @bed_type

        if @bed_type.update(bed_type_params)
          render json: @bed_type
        else
          render json: { errors: @bed_type.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize @bed_type

        @bed_type.destroy
        head :no_content
      end

      private

      def set_bed_type
        @bed_type = BedType.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Bed type not found' }, status: :not_found
      end

      def bed_type_params
        params.require(:bed_type).permit(:name)
      end
    end
  end
end 