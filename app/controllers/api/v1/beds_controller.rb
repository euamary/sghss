module Api
  module V1
    class BedsController < ApplicationController
      before_action :set_bed, only: [:show, :update, :destroy]

      def index
        authorize @beds

        @beds = policy_scope(Bed)
        render json: @beds
      end

      def show
        authorize @bed
        render json: @bed
      end

      def create
        authorize @bed
        
        @bed = Bed.new(bed_params)
        
        if @bed.save
          render json: @bed, status: :created
        else
          render json: { errors: @bed.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        authorize @bed

        if @bed.update(bed_params)
          render json: @bed
        else
          render json: { errors: @bed.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize @bed

        @bed.destroy
        head :no_content
      end

      private

      def set_bed
        @bed = Bed.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Bed not found' }, status: :not_found
      end

      def bed_params
        params.require(:bed).permit(:name, :bed_type_id, :room_id, :status)
      end
    end
  end
end 