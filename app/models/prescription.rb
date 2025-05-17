# frozen_string_literal: true

class Prescription < ApplicationRecord
  audited only: [:content, :consultation_id, :professional_id, :patient_id, :company_id]
end
