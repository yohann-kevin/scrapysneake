class TrendController < ApplicationController
  skip_before_action :authorized

  def initialize
    @img_link = ENV.fetch("IMG_API_LINK")
    @data = [
      {
        image_path: "#{@img_link}sneakers/adidas-ozweego-celox.png",
        model: "Adidas Ozweego Celox",
        price: "120,00 €",
        gender: "Mixte",
        seller_name: "courir"
      },
      {
        image_path: "#{@img_link}sneakers/air-jordan-one.png",
        model: "Jordan Air One",
        price: "130,00 €",
        gender: "Homme",
        seller_name: "courir"
      },
      {
        image_path: "#{@img_link}sneakers/new-balance-327.png",
        model: "New Balance 327",
        price: "90,00 €",
        gender: "Femme",
        seller_name: "courir"
      },
      {
        image_path: "#{@img_link}sneakers/puma-mirage-tech.png",
        model: "Puma Mirage Tech",
        price: "100,00 €",
        gender: "Homme",
        seller_name: "courir"
      }
    ]
  end

  def send_data
    render json: @data
  end  
end
