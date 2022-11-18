# frozen_string_literal: true

class AddUniqueIndexToSlug < ActiveRecord::Migration[7.0]
  def change
    add_index :links, :slug, unique: true
  end
end
