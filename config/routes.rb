Rails.application.routes.draw do
  get "/" => "index#home"

  get "/trend" => "trend#send_data"
end
