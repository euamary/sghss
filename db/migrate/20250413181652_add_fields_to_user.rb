# frozen_string_literal: true

class AddFieldsToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :name, :string
    add_column :users, :phone, :string
    add_reference :users, :company, null: true, foreign_key: true
    add_reference :users, :role, null: true, foreign_key: true
  end
end
