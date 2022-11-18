# frozen_string_literal: true

class AddUserAgentToClicks < ActiveRecord::Migration[5.2]
  def change
    add_column :clicks, :user_agent, :string
  end
end
