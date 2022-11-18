# frozen_string_literal: true

class HomeController < ApplicationController
  after_action :record_click, only: :url

  def index
    redirect_to :links if signed_in?
  end

  def url
    @link = Link.where(slug: params[:slug]).first

    if @link
      redirect_to merge_params(@link.url)
    else
      redirect_to 'https://suncoast.io'
    end
  end

  private

  def merge_params(url)
    if request.query_parameters.empty?
      url
    else
      uri = URI.parse(url)
      link_params = Rack::Utils.parse_query(uri.query)
      merged_params = request.query_parameters.merge(link_params)
      uri.query = Rack::Utils.build_query(merged_params)
      uri.to_s
    end
  end

  def record_click
    return unless @link

    @link.clicks.create({ ip_address: request.remote_ip, referrer: request.referer, user_agent: request.user_agent,
                          session: session.id })
  end
end
