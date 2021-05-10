class LoginController < ApplicationController
  def initialize
    @name = "kirua"
    @pass = "Kercode4"
    @isUsers = false
    @isPass = false
    @isName = false
  end

  def find_logs
    logs_params = params[:log]
    puts logs_params
    check_logs(logs_params)
  end

  def check_logs(logs)
    log = logs.split("&")
    puts log
    if @name == log[0] && @pass == log[1]
      @isUsers = true
    else
      @isUsers = false
      check_error(log)
    end
    send_response
  end
  isUsers
  def check_error(log)
    @isName = true if log[0] != @name
    @isPass = true if log[1] != @pass
  end

  def send_response
    render json: {
      "response" => {
        "is_users" => @isUsers,
        "name" => @isName,
        "pass" => @isPass
      }
    }
  end
end
