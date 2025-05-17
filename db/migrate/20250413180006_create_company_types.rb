# frozen_string_literal: true

class CreateCompanyTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :company_types do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
