class PartnerController < ApplicationController
  def initialize
    @data = [
      {
        "name": "La boutique officiel",
        "image_path": "https://scrapysneake.herokuapp.com/images/partners/boutiqueofficiel.png"
      },
      {
        "name": "Adidas",
        "image_path": "https://scrapysneake.herokuapp.com/images/partners/adidas.png"
      },
      {
        "name": "Courir",
        "image_path": "https://scrapysneake.herokuapp.com/images/partners/courir.png"
      },
      {
        "name": "Fila",
        "image_path": "https://scrapysneake.herokuapp.com/images/partners/fila.png"
      },
      {
        "name": "Nike",
        "image_path": "https://scrapysneake.herokuapp.com/images/partners/nike.png"
      },
      {
        "name": "Reebok",
        "image_path": "https://scrapysneake.herokuapp.com/images/partners/reebok.png"
      }
    ]
  end

  def send_partner
    render json: @data
  end
end
