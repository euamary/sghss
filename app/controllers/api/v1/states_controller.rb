module Api
  module V1
    class StatesController < ApplicationController
      before_action :set_state, only: [:show, :update, :destroy]

      def index
        authorize @states

        @states = policy_scope(State)
        render json: @states
      end

      def show
        authorize @state
        render json: @state
      end

      def create
        authorize @state
        
        @state = State.new(state_params)
        
        if @state.save
          render json: @state, status: :created
        else
          render json: { errors: @state.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        authorize @state

        if @state.update(state_params)
          render json: @state
        else
          render json: { errors: @state.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize @state

        @state.destroy
        head :no_content
      end

      private

      def set_state
        @state = State.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'State not found' }, status: :not_found
      end

      def state_params
        params.require(:state).permit(:name, :uf)
      end
    end
  end
end 