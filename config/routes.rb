Rails.application.routes.draw do
  get "/" => "index#home"

  get "/trend" => "trend#send_data"

  get "/advert" => "advert#send_image_carousel"
end
