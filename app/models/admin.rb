class Admin < ApplicationRecord
  # attr_accessible :name, :password

  def initialize(data)
    @data = data
  end

  def read_data
    puts "model"
    puts @data
  end
end
