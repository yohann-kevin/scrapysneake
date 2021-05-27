class AdminController < ApplicationController
  def initialize
    @adm_params = nil
  end
  
  def add_admin
    @adm_params = params[:adm]
    puts "controller"
    puts @adm_params
    manage_request(@adm_params)
    # Admin.new(@adm_params).read_data
  end

  def manage_request(request)
    # data = request.split("&")
    params = ActionController::Parameters.new({
      admin: {
        name: request.split("&")[0],
        password: request.split("&")[1]
      }
    })
    
    Admin.create(send_data(params))
  end

  def send_data(params)
    params.require(:admin).permit(:name, :password)
  end

  def read_data
    admin = {}
    admin = Admin.all
    puts "plop"
    puts admin[0].password
  end
end
