# frozen_string_literal: true

class ExamType < ApplicationRecord
  audited only: [:name]
end
