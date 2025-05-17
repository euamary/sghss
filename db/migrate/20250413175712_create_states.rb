# frozen_string_literal: true

class CreateStates < ActiveRecord::Migration[8.0]
  def change
    create_table :states do |t|
      t.string :name, null: false
      t.string :acronym, null: false

      t.timestamps
    end
  end
end
