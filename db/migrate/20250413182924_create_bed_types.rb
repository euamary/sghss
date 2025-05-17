# frozen_string_literal: true

class CreateBedTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :bed_types do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :bed_types, :name, unique: true
  end
end
