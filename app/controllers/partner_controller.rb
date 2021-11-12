class PartnerController < ApplicationController
  skip_before_action :authorized

  def initialize
    super()
    @img_link = ENV.fetch("IMG_API_LINK")
    @data = [
      {
        "name": "La boutique officiel",
        "image_path": "#{@img_link}partners/boutiqueofficiel.png"
      },
      {
        "name": "Adidas",
        "image_path": "#{@img_link}partners/adidas.png"
      },
      {
        "name": "Courir",
        "image_path": "#{@img_link}partners/courir.png"
      },
      {
        "name": "Fila",
        "image_path": "#{@img_link}partners/fila.png"
      },
      {
        "name": "Nike",
        "image_path": "#{@img_link}partners/nike.png"
      },
      {
        "name": "Reebok",
        "image_path": "#{@img_link}partners/reebok.png"
      }
    ]
  end

  def send_partner
    render json: @data
  end
end
