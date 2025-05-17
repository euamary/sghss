# frozen_string_literal: true

class CreateCompanies < ActiveRecord::Migration[8.0]
  def change
    create_table :companies do |t|
      t.string :cnpj, limit: 20
      t.string :email, null: false
      t.string :name, null: false
      t.string :fantasy_name, null: false
      t.string :address, null: false
      t.string :address_number, null: false
      t.string :district, null: false
      t.references :city, foreign_key: true
      t.references :state, foreign_key: true
      t.string :zipcode
      t.string :phone, null: false
      t.references :company_type, foreign_key: true

      t.timestamps
    end
  end
end
