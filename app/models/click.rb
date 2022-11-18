# frozen_string_literal: true

class Click < ApplicationRecord
  belongs_to :link, counter_cache: true
end
