# frozen_string_literal: true

class CreateMedicalRecords < ActiveRecord::Migration[8.0]
  def change
    create_table :medical_records do |t|
      t.references :patient, null: false, foreign_key: { to_table: :users }
      t.references :professional, null: false, foreign_key: { to_table: :users }
      t.references :company, null: false, foreign_key: true
      t.references :consultation, foreign_key: true

      t.date :date, null: false
      t.text :notes, null: false
      t.text :diagnosis

      t.timestamps
    end
  end
end
