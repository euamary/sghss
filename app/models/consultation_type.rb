# frozen_string_literal: true

class ConsultationType < ApplicationRecord
  audited only: [:name]
end
