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

  def self.find_most_wanted_sneakers_model
    sneakers_wanted = Sneaker.where.not(wanted: 0)
    all_models = []
    sneakers_wanted.each do |sneaker|
      model = sneaker.model.split(" ")[0].downcase
      all_models.push(model)
    end
    all_models = all_models.tally
    all_models.each do |k, v|
      all_models.delete(k) if !v.nil? && v < 10
    end
    Hash[all_models.sort_by { |model, freq| [-freq, model] }]
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

  def self.count_sneaker_by_seller(seller)
    Sneaker.where(seller: seller).count
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
    return unless sneaker.nil?

    sneaker[:wanted] += 1
    sneaker.save
  end

  def self.average_price_by_seller(seller)
    seller_count = Sneaker.where(seller: seller).count
    all_price = Sneaker.where(seller: seller).pluck(:price)
    total = 0
    all_price.each do |el|
      total += el
    end
    total / seller_count
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

  def self.find_most_price_range
    max = Sneaker.maximum("price")
    index = 0
    price_sorted = []
    while index <= max do
      price_sorted << { index.to_s => Sneaker.where(price: index..(index+=10)).pluck("price").sort }
    end
    price_sorted
  end
end
