# frozen_string_literal: true

class BedType < ApplicationRecord
  audited only: [:name]
end
