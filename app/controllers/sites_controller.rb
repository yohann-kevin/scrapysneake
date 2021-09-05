class SitesController < ApplicationController
  # before_action :set_site, only: [:show, :update, :destroy]

  def index
    @site = Site.all

    render json: @site
  end

  def show
    render json: @site
  end

  def create
    # site_params[:uuid] = SecureRandom.uuid
    # puts site_params
    modify_params = site_params
    modify_params[:uuid] = SecureRandom.uuid
    puts modify_params
    @site = Site.new(modify_params)

    if @site.save
      render json: @site, status: :created, location: @site
    else
      render json: @site.errors, status: :unprocessable_entity
    end
  end

  def update
    if @site.update(site_params)
      render json: @site
    else
      render json: @site.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @site.destroy
  end

  private
    def set_site
      @site = Site.find(params[:uuid])
    end

    def site_params
      params.permit(:name)
    end
end
