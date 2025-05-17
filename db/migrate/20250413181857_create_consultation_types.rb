# frozen_string_literal: true

class CreateConsultationTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :consultation_types do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :consultation_types, :name, unique: true
  end
end
