# frozen_string_literal: true

class CreatePrescriptions < ActiveRecord::Migration[8.0]
  def change
    create_table :prescriptions do |t|
      t.references :consultation, null: false, foreign_key: true
      t.references :professional, null: false, foreign_key: { to_table: :users }
      t.references :patient, null: false, foreign_key: { to_table: :users }
      t.references :company, null: false, foreign_key: true

      t.text :content, null: false

      t.timestamps
    end
  end
end
