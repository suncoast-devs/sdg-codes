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
      redirect_to @link.url
    else
      redirect_to "https://suncoast.io"
    end
  end
end
