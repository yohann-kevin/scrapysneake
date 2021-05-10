Rails.application.routes.draw do
  get "/" => "index#home"

  get "/trend" => "trend#send_data"

  get "/advert" => "advert#send_image_carousel"

  # get "/api/stories/tag/:tag" => "api/tags#find_stories_by_tags"

  get "/login/:log" => "login#find_logs"
end
