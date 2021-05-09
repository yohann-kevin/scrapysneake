Rails.application.routes.draw do
  get "/trend" => "api/trend#send_data"
end
