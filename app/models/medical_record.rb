# frozen_string_literal: true

class MedicalRecord < ApplicationRecord
  audited only: [:date, :notes, :diagnosis, :patient_id, :professional_id, :company_id, :consultation_id]
end
