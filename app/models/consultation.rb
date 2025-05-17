# frozen_string_literal: true

class Consultation < ApplicationRecord
  enum :status, { scheduled: 'scheduled', completed: 'completed', cancelled: 'cancelled' }

  audited only: [:date, :status, :patient_id, :professional_id, :company_id, :consultation_type_id]
end
