# frozen_string_literal: true

class LinksController < ApplicationController
  before_action :authenticate!
  before_action :set_link, only: %i[show edit update destroy]

  # GET /links
  def index
    scope = case params[:f]
            when 'all' then Link.all
            when 'system' then Link.joins(:user).where(users: { email: 'hello@suncoast.io' })
            else Link.where(user: current_user)
            end

    @pagy, @links = pagy(scope.order(created_at: :desc))
  end

  # GET /links/1
  def show; end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit; end

  # POST /links
  def create
    @link = current_user.links.new(link_params)

    if @link.save
      redirect_to @link, notice: 'Link was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /links/1
  def update
    if @link.update(link_params)
      redirect_to @link, notice: 'Link was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /links/1
  def destroy
    @link.destroy
    redirect_to links_url, notice: 'Link was successfully destroyed.'
  end

  private

  def set_link
    @link = Link.find(params[:id])
  end

  def link_params
    params.require(:link).permit(:url, :slug, :label)
  end
end
