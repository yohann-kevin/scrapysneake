class AdvertController < ApplicationController
  def initialize
    @image_path = [
      "https://scrapysneake.herokuapp.com/images/carousel/adidas-share.jpg",
      "https://scrapysneake.herokuapp.com/images/carousel/newbalance-327.jpg",
      "https://scrapysneake.herokuapp.com/images/carousel/nike-loops.jpg"
    ]
  end

  def send_image_carousel
    render json: { "image_path" => @image_path }
  end
end
