# frozen_string_literal: true

class Company < ApplicationRecord
  audited only: [:cnpj, :email, :name, :fantasy_name, :address, :address_number, :district, :city_id, :state_id, :zipcode, :phone, :company_type_id]
end
