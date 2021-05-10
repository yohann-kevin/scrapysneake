class TrendController < ApplicationController
  def initialize
    @data = [
      {
        image_path: "http://localhost:3000/images/sneakers/adidas-ozweego-celox.png",
        model: "Adidas Ozweego Celox",
        price: "120,00 €",
        gender: "Mixte",
        seller_name: "courir"
      },
      {
        image_path: "http://localhost:3000/images/sneakers/air-jordan-one.png",
        model: "Jordan Air One",
        price: "130,00 €",
        gender: "Homme",
        seller_name: "courir"
      },
      {
        image_path: "http://localhost:3000/images/sneakers/new-balance-327.png",
        model: "New Balance 327",
        price: "90,00 €",
        gender: "Femme",
        seller_name: "courir"
      },
      {
        image_path: "http://localhost:3000/images/sneakers/puma-mirage-tech.png",
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
