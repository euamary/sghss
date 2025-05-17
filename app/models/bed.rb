# frozen_string_literal: true

class Bed < ApplicationRecord
  enum :status, { available: 'available', occupied: 'occupied', maintenance: 'maintenance' }

  audited only: [:number, :status, :room_id, :company_id]
end
