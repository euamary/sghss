# frozen_string_literal: true

class CreateHospitalizations < ActiveRecord::Migration[8.0]
  def change
    create_table :hospitalizations do |t|
      t.references :patient, null: false, foreign_key: { to_table: :users }
      t.references :professional, null: false, foreign_key: { to_table: :users }
      t.references :bed, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true

      t.date :admission_date, null: false
      t.date :discharge_date
      t.text :reason, null: false
      t.string :status, null: false
      t.text :notes

      t.timestamps
    end
  end
end
