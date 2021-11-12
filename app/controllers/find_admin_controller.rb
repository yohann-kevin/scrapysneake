class FindAdminController < ApplicationController
  def initialize
    super()
    @connect = true
    @name = "kirua"
    @pass = "Kercode4"
  end

  def check_admin
    response = "#{@name}&#{@pass}" if @connect
    find_admin(response)
  end

  def find_admin(response)
    render json: {
      "response" => response
    }
  end
end
