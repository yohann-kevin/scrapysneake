require "pry"

class Sneaker < ApplicationRecord
  validates :model, presence: true
  validates :price, presence: true
  validates :link, presence: true
  validates :gender, presence: true
  validates :seller, presence: true
  validates :image_path, presence: true

  def self.add_new_sneaker(sneaker_params)
    sneaker_params[:id] = SecureRandom.uuid
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
    Sneaker.new(sneaker)
  end

  def self.find_sneaker_with_model(model)
    sneaker = Sneaker.where("model LIKE '%#{model}%'").order(price: :asc)
    wanted_update(sneaker)
    sneaker
  end

  def self.find_most_wanted_sneakers
    Sneaker.order(wanted: :desc).limit(8)
  end

  def self.find_sneaker_with_seller(seller)
    Sneaker.where(seller: seller)
  end

  def self.wanted_update(sneaker)
    sneaker.each do |el|
      el["wanted"] += 1
      el.save
    end
  end

  def self.count_sneaker(day_ago)
    Sneaker.where("created_at < ?", day_ago.days.ago).count
  end

  def self.count_sneaker_gender(day_ago, gender)
    Sneaker.where("gender = ? AND created_at < ?", gender, day_ago.days.ago).count
  end

  def self.count_sneaker_with_date(day_ago, gender)
    Sneaker.where("created_at < ?", day_ago.days.ago, gender: gender).count
  end

  def self.remove_sneakers_by_seller(seller)
    Sneaker.where(seller: seller).destroy_all
  end

  def self.find_all_seller
    sneakers = Sneaker.all
    all_seller = []
    sneakers.each do |el|
      all_seller.push(el["seller"]) unless all_seller.include?(el["seller"])
    end
    all_seller
  end

  def self.find_most_seller(seller)
    counter = 0
    sneakers = Sneaker.where(seller: seller)
    sneakers.each do |el|
      counter += el[:wanted]
    end
    counter
  end

  def self.increment_wanted(id)
    sneaker = Sneaker.find_by(id: id)
    unless sneaker.nil?
      sneaker[:wanted] += 1
      sneaker.save
    end
  end

  def self.find_best_seller_price
    @seller_price_average = {
      "foot_locker" => 0,
      "official_shop" => 0,
      "jd_sports" => 0,
      "corner" => 0,
      "error" => 0
    }

    @foot_locker_count = 0
    @official_shop_count = 0
    @jd_sport_count = 0
    @corner_count = 0

    all_sneakers = Sneaker.all
    all_sneakers.each do |el|
      compute_all_seller_price(el)
    end

    @seller_price_average["foot_locker"] = @seller_price_average["foot_locker"] / @foot_locker_count
    @seller_price_average["official_shop"] = @seller_price_average["official_shop"] / @official_shop_count
    @seller_price_average["jd_sports"] = @seller_price_average["jd_sports"] / @jd_sport_count
    @seller_price_average["corner"] = @seller_price_average["corner"] / @corner_count

    @seller_price_average
  end

  def self.compute_all_seller_price(sneaker)
    case sneaker.seller.downcase
    when "foot locker"
      @foot_locker_count += 1
      @seller_price_average["foot_locker"] += sneaker.price
    when "la boutique officielle"
      @official_shop_count += 1
      @seller_price_average["official_shop"] += sneaker.price
    when "jdsports"
      @jd_sport_count += 1
      @seller_price_average["jd_sports"] += sneaker.price
    when "corner"
      @corner_count += 1
      @seller_price_average["corner"] += sneaker.price
    else
      @seller_price_average["error"] += 1
    end
  end
end
