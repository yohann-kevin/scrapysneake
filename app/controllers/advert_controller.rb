class AdvertController < ApplicationController
  skip_before_action :authorized

  def initialize
    @img_link = ENV.fetch("IMG_API_LINK")
    @carousel_img = [
      "#{@img_link}carousel/adidas-share.jpg",
      "#{@img_link}carousel/newbalance-327.jpg",
      "#{@img_link}carousel/nike-loops.jpg"
    ]
  end

  def send_image_carousel
    render json: { "image_path" => @carousel_img }
  end
end
