class AdminController < ApplicationController
  def initialize
    @adm_params = nil
  end
  
  def add_admin
    @adm_params = params[:adm]
    puts "controller"
    puts @adm_params
    Admin.new(@adm_params).read_data
  end
end
