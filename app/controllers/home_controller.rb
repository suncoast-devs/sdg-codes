# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    redirect_to :links if signed_in?
  end

  def url
    @link = Link.where(slug: params[:slug]).first

    if @link
      @link.clicks.create({
        ip_address: request.remote_ip,
        referrer: request.referer,
        user_agent: request.user_agent,
        session: session.id,
      })

      unless request.query_parameters.empty?
        uri = URI.parse(@link.url)
        link_params = Rack::Utils.parse_query(uri.query)
        merged_params = request.query_parameters.merge(link_params)
        uri.query = Rack::Utils.build_query(merged_params)
        redirect_to uri.to_s
      else
        redirect_to @link.url
      end
    else
      redirect_to "https://suncoast.io"
    end
  end
end
