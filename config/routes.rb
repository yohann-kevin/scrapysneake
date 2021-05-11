Rails.application.routes.draw do
  get "/" => "index#home"

  get "/trend" => "trend#send_data"

  get "/advert" => "advert#send_image_carousel"

  get "/login/:log" => "login#find_logs"

  get "login/find/admin" => "find_admin#check_admin"

  get "admin/add/:adm" => "admin#add_admin"
end
