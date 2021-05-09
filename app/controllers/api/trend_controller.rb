class Api::TrendController < ApplicationController
  def initialize
    @data = [
      {
        # imgPath: require("@/assets/sneakers/adidas-ozweego-celox.webp"),
        model: "Adidas Ozweego Celox",
        price: "120,00 €",
        gender: "Mixte",
        sellerName: "courir"
      },
      {
        # imgPath: require("@/assets/sneakers/air-jordan-one.webp"),
        model: "Jordan Air One",
        price: "130,00 €",
        gender: "Homme",
        sellerName: "courir"
      },
      {
        # imgPath: require("@/assets/sneakers/new-balance-327.png"),
        model: "New Balance 327",
        price: "90,00 €",
        gender: "Femme",
        sellerName: "courir"
      },
      {
        # imgPath: require("@/assets/sneakers/puma-mirage-tech.webp"),
        model: "Puma Mirage Tech",
        price: "100,00 €",
        gender: "Homme",
        sellerName: "courir"
      }
    ]
  end

  def send_data
    render json: @data
  end
end
