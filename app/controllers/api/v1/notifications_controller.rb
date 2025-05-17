module Api
  module V1
    class NotificationsController < ApplicationController
      before_action :set_notification, only: [:show, :update, :destroy, :mark_as_read]

      def index
        authorize @notifications

        @notifications = policy_scope(Notification)
        render json: @notifications
      end

      def show
        authorize @notification
        render json: @notification
      end

      def create
        authorize Notification
        
        @notification = Notification.new(notification_params)
        
        if @notification.save
          render json: @notification, status: :created
        else
          render json: { errors: @notification.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        authorize @notification

        if @notification.update(notification_params)
          render json: @notification
        else
          render json: { errors: @notification.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize @notification

        @notification.destroy
        head :no_content
      end

      def mark_as_read
        authorize @notification
        
        if @notification.update(read: true)
          render json: @notification
        else
          render json: { errors: @notification.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_notification
        @notification = Notification.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Notification not found' }, status: :not_found
      end

      def notification_params
        params.require(:notification).permit(
          :user_id, :title, :message, :read, :notification_type, 
          :link, :source_type, :source_id
        )
      end
    end
  end
end 