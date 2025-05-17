module Api
  module V1
    class CitiesController < ApplicationController
      before_action :set_city, only: [:show, :update, :destroy]

      def index
        authorize @cities

        @cities = policy_scope(City)
        render json: @cities
      end

      def show
        authorize @city
        render json: @city
      end

      def create
        authorize @city
        
        @city = City.new(city_params)
        
        if @city.save
          render json: @city, status: :created
        else
          render json: { errors: @city.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        authorize @city

        if @city.update(city_params)
          render json: @city
        else
          render json: { errors: @city.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize @city

        @city.destroy
        head :no_content
      end

      private

      def set_city
        @city = City.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'City not found' }, status: :not_found
      end

      def city_params
        params.require(:city).permit(:name, :state_id)
      end
    end
  end
end 