# frozen_string_literal: true

class CreateExams < ActiveRecord::Migration[8.0]
  def change
    create_table :exams do |t|
      t.references :patient, null: false, foreign_key: { to_table: :users }
      t.references :professional, null: false, foreign_key: { to_table: :users }
      t.references :company, null: false, foreign_key: true
      t.references :exam_type, null: false, foreign_key: true
      t.references :consultation, foreign_key: true

      t.date :scheduled_date, null: false
      t.date :result_date
      t.string :status, null: false
      t.text :result

      t.timestamps
    end
  end
end
