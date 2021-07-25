require "pry"

class Sneaker < ApplicationRecord
  validates :model, presence: true
  validates :price, presence: true
  validates :link, presence: true
  validates :gender, presence: true
  validates :seller, presence: true
  validates :image_path, presence: true

  def self.add_new_sneaker(sneaker_params)
    is_in_db = false
    old_sneaker = Sneaker.where(model: sneaker_params["model"])
    if !old_sneaker.length.zero?
      old_sneaker.each do |el|
        is_in_db = true if el["seller"] != sneaker_params["seller"]
      end
      sneaker = Sneaker.new(sneaker_params) if is_in_db
    else
      is_in_db = true
      sneaker = Sneaker.new(sneaker_params)
    end
    return sneaker if is_in_db
  end

  def add_foot_locker_sneaker(sneaker)
    puts sneaker
    sneaker = Sneaker.new(sneaker)
    puts sneaker
  end

  def self.find_sneaker_with_model(model)
    sneaker = Sneaker.where("model LIKE '%#{model}%'").order(price: :asc)
  end

  def self.count_sneaker(day_ago)
    Sneaker.where("created_at < ?", day_ago.days.ago).count
  end

  def self.count_sneaker_gender(day_ago, gender)
    # Sneaker.where(gender: gender).count
    Sneaker.where("gender = ? AND created_at < ?", gender, day_ago.days.ago).count
  end

  def self.count_sneaker_with_date(day_ago, gender)
    Sneaker.where("created_at < ?", day_ago.days.ago, gender: gender).count
  end
end
