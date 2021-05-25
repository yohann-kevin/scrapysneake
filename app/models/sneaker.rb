class Sneaker < ApplicationRecord
  validates :model, presence: true
  validates :price, presence: true
  validates :link, presence: true
  validates :gender, presence: true
  validates :seller, presence: true
  validates :image_path, presence: true

  def self.add_new_sneaker(sneaker_params)
    is_in_db = false
    sneaker = Sneaker.new(sneaker_params)
    old_sneaker = Sneaker.where(model: sneaker_params[:model])
    if old_sneaker != nil
      old_sneaker.each do |el|
        is_in_db = true if el[:seller] == sneaker_params[:seller]
      end
    end
    return is_in_db ? false : sneaker
  end
end
