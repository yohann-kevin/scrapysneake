class IndexController < ApplicationController
  def home
    render json: { "response" => "Welcome to scrappysneake !" }
  end
end
