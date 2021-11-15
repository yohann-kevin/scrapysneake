Rails.application.routes.draw do
  resources :administrators

  resources :sneakers

  get "/sneakers/find/most_wanted" => "sneakers#find_sneakers_most_wanted"
  # seller appearing the most in search
  get "/sneakers/find/most_seller" => "sneakers#count_most_seller"
  # best price seller
  get "/sneakers/search/best_seller_price" => "sneakers#best_seller_price"

  post "/sneakers/delete/:seller" => "sneakers#delete_sneakers_by_seller"
  post "/sneakers/delete/all" => "sneakers#reset_all_sneakers_data"

  post "/sneakers/click" => "sneakers#update_wanted"

  resources :messages

  get "/sneakers/find/:model" => "sneakers#find_sneakers"
  get "/sneakers/count/all" => "sneakers#sneaker_count"
  get "/sneakers/count/seller" => "sneakers#sneaker_count_seller"

  get "/sneakers/seller/:seller" => "sneakers#find_sneakers_by_seller"

  get "/" => "index#home"

  get "/trend" => "trend#send_data"

  get "/advert" => "advert#send_image_carousel"

  post "/login" => "administrators#login_admin"

  get "partner/get" => "partner#send_partner"

  get "about/get" => "about#send_about"

  get "scrap/:webapp" => "scraper#scrap"
  get "scrap/:webapp/:gender" => "scraper#scrap"
end
