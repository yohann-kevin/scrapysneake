class ApplicationController < ActionController::API
  around_action :manage_error
  before_action :authorized

  if ENV["RACK_ENV"] == "development"
    ENV.store("IMG_API_LINK", "http://localhost:3000/images/")
  else
    ENV.store("IMG_API_LINK", "https://scrapysneake.herokuapp.com/images/")
  end

  def auth_header
    request.headers["Authorization"]
  end

  def decoded_token
    return unless auth_header

    token = auth_header.split(" ")[1]
    begin
      JWT.decode(token, nil, false)
    rescue JWT::DecodeError
      nil
    end
  end

  def logged_in_user
    return unless decoded_token

    user_id = decoded_token[0]["user_id"]
    @user = Administrator.find_by(id: user_id)
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    render json: { message: "Please log in" }, status: :unauthorized if ENV["RAILS_ENV"] != "test" && !logged_in?
  end

  protected

  def manage_error
    yield
  rescue StandardError => e
    if ENV["RAILS_ENV"] == "production"
      error_save = FailedJob.new({ name: request, description: params, error: e, stack_trace: e.backtrace.join("\n") })
      error_save.save
      DiscordErrorService.new(request, params, e, e.backtrace.join("\n")).send_error
    end
    raise e
  end
end
