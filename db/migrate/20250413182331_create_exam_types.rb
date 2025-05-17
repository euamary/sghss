# frozen_string_literal: true

class CreateExamTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :exam_types do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :exam_types, :name, unique: true
  end
end
