# frozen_string_literal: true

class ClicksController < ApplicationController
  before_action :authenticate!

  # GET /links
  def index
    @pagy, @clicks = pagy(Click.all.order(created_at: :desc))
  end
end
