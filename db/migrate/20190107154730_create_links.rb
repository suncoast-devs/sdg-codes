# frozen_string_literal: true

class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.references :user
      t.string :url
      t.string :slug
      t.string :label
      t.integer :clicks_count, null: false, default: 0

      t.timestamps
    end
  end
end
