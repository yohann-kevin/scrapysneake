Rails.application.routes.draw do
  resources :administrators

  resources :sneakers

  get "/sneakers/find/most_wanted" => "sneakers#find_sneakers_most_wanted"
  get "/sneakers/find/most_seller" => "sneakers#count_most_seller"

  post "/sneakers/delete/:seller" => "sneakers#delete_sneakers_by_seller"
  post "/sneakers/delete/all" => "sneakers#reset_all_sneakers_data"

  resources :messages

  get "/sneakers/find/:model" => "sneakers#find_sneakers"
  get "/sneakers/count/all" => "sneakers#sneaker_count"
  
  get "/" => "index#home"

  get "/trend" => "trend#send_data"

  get "/advert" => "advert#send_image_carousel"

  get "/login/:log" => "login#find_logs"
  get "login/find/admin" => "find_admin#check_admin"

  get "admin/add/:adm" => "admin#add_admin"
  get "admin/get" => "admin#read_data"

  get "partner/get" => "partner#send_partner"

  get "about/get" => "about#send_about"

  get "scrap/:webapp" => "scraper#scrap"
end
