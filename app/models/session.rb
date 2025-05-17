# frozen_string_literal: true

class Session < ApplicationRecord
  belongs_to :user
  before_create :generate_token

  private

  def generate_token; self.token = SecureRandom.hex(32); end
end
