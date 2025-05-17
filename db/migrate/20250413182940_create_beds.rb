# frozen_string_literal: true

class CreateBeds < ActiveRecord::Migration[8.0]
  def change
    create_table :beds do |t|
      t.references :company, null: false, foreign_key: true
      t.string :number, limit: 20, null: false
      t.references :bed_type, null: false, foreign_key: true
      t.string :status, null: false

      t.timestamps
    end
  end
end
