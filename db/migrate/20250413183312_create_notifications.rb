# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[8.0]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :message, null: false
      t.boolean :read, default: false
      t.datetime :sent_at, null: false
      t.string :delivery_channel, null: false
      t.string :context_type
      t.integer :context_id

      t.timestamps
    end

    add_index :notifications, [:context_type, :context_id]
  end
end
