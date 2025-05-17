# frozen_string_literal: true

class CompanyType < ApplicationRecord
  audited only: [:name]
end
