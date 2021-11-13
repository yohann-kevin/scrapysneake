require "bcrypt"

class AdministratorsController < ApplicationController
  before_action :set_administrator, only: %i[show update destroy]
  skip_before_action :authorized, only: [:login_admin]

  # GET /administrators
  def index
    @administrators = Administrator.all

    render json: @administrators
  end

  # GET /administrators/1
  def show
    render json: @administrator
  end

  # POST /administrators
  def create
    admin_name = administrator_params["name"]
    admin_password = BCrypt::Password.create(administrator_params["encrypted_password"])
    admin = {
      "name" => admin_name,
      "encrypted_password" => admin_password
    }
    @administrator = Administrator.new(admin)

    if @administrator.save
      render json: @administrator, status: :created, location: @administrator
    else
      render json: @administrator.errors, status: :unprocessable_entity
    end
  end

  def login_admin
    user_info = JSON.parse(request.body.read)
    administrator = Administrator.find_admin_by_name(user_info["name"])
    password = BCrypt::Password.new(administrator[0].encrypted_password)
    if password == user_info["password"]
      payload = { user_id: administrator[0].id }
      token = JWT.encode(payload, nil, "none")
      render json: {
        "token" => token,
        "response" => {
          "is_users" => true,
          "name" => true,
          "pass" => true
        }
      }
    else
      render json: {
        "response" => {
          "is_users" => false,
          "name" => false,
          "pass" => false
        }
      }
    end
  end

  # def hmac_secret
  #   ENV["API_SECRET_KEY"]
  # end

  # def check_token
  #   token = request.headers["Authorization"].split(" ")[1]
  #   decoded_array = JWT.decode(token, nil, false)
  #   payload = decoded_array.first
  #   puts payload
  # end

  # PATCH/PUT /administrators/1
  def update
    if @administrator.update(administrator_params)
      render json: @administrator
    else
      render json: @administrator.errors, status: :unprocessable_entity
    end
  end

  # DELETE /administrators/1
  def destroy
    @administrator.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_administrator
    @administrator = Administrator.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def administrator_params
    # params.require(:administrator).permit(:name, :encrypted_password)
    params.permit(:name, :encrypted_password)
  end
end
