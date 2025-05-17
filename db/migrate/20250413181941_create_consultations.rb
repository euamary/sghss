# frozen_string_literal: true

class CreateConsultations < ActiveRecord::Migration[8.0]
  def change
    create_table :consultations do |t|
      t.references :patient, null: false, foreign_key: { to_table: :users }
      t.references :professional, null: false, foreign_key: { to_table: :users }
      t.references :company, null: false, foreign_key: true
      t.references :consultation_type, null: false, foreign_key: true

      t.date :date, null: false
      t.time :start_time, null: false
      t.time :end_time
      t.string :status, null: false
      t.text :notes

      t.timestamps
    end
  end
end
