class ApplicationController < ActionController::API
  around_action :manage_error

  protected

  def manage_error
    begin
      yield
    rescue StandardError => e
      DiscordService.new(request, params, e, e.backtrace.join("\n")).send_error
      raise e
    end
  end


  # if ENV["RACK_ENV"] == "development"
  #   ENV.store("IMG_API_LINK", "http://localhost:3000/images/")
  # else
  #   ENV.store("IMG_API_LINK", "https://scrapysneake.herokuapp.com/images/")
  # end
end
