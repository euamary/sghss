# frozen_string_literal: true

class Hospitalization < ApplicationRecord
  enum :status, { active: 'active', discharged: 'discharged', transferred: 'transferred', cancelled: 'cancelled' }

  audited only: [:start_date, :end_date, :status, :patient_id, :professional_id, :company_id, :room_id]
end
