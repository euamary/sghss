# frozen_string_literal: true

class Notification < ApplicationRecord
  enum :delivery_channel, { email: 'email', sms: 'sms', push: 'push' }

  audited only: [:title, :message, :delivery_channel, :context_type, :context_id, :user_id] 
end
