# frozen_string_literal: true

require 'pagy/extras/bulma'

module ApplicationHelper
  include Pagy::Frontend
  USER_AGENT_PARSER = UserAgentParser::Parser.new

  def ua(ua_string)
    USER_AGENT_PARSER.parse(ua_string)
  end

  def sign_in_path
    "/auth/#{Rails.env.production? ? :google_oauth2 : :developer}"
  end
end
