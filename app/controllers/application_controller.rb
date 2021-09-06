class ApplicationController < ActionController::API
  if ENV["RACK_ENV"] == "development"
    ENV.store("IMG_API_LINK", "http://localhost:3000/images/")
  else
    ENV.store("IMG_API_LINK", "https://scrapysneake.herokuapp.com/images/")
  end
end
