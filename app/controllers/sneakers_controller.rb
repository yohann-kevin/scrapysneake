class SneakersController < ApplicationController
  skip_before_action :authorized
  before_action :set_sneaker, only: %i[show update destroy]

  # GET /sneakers
  def index
    @sneakers = Sneaker.all
    render json: @sneakers
  end

  # GET /sneakers/1
  def show
    render json: @sneaker
  end

  def find_sneakers
    @sneakers = Sneaker.find_sneaker_with_model(params[:model])

    render json: @sneakers
  end

  def find_sneakers_most_wanted
    @sneakers = Sneaker.find_most_wanted_sneakers

    render json: @sneakers
  end

  def find_sneakers_by_seller
    @sneaker = Sneaker.find_sneaker_with_seller(params[:seller])

    render json: @sneaker
  end

  # POST /sneakers
  def create
    Rails.logger.debug "------------"
    Rails.logger.debug sneaker_params
    @sneaker = Sneaker.add_new_sneaker(sneaker_params)

    if @sneaker.save
      render json: @sneaker, status: :created, location: @sneaker
    else
      render json: @sneaker.errors, status: :unprocessable_entity
    end
  end

  def sneaker_count
    counter = {}

    0.upto(7) do |el|
      counter["days#{el}"] = {
        "counter_sneaker" => Sneaker.count_sneaker(el),
        "counter_sneaker_man" => Sneaker.count_sneaker_gender(el, "man"),
        "counter_sneaker_women" => Sneaker.count_sneaker_gender(el, "women")
      }
    end

    render json: counter
  end

  def sneaker_count_seller
    sellers = Sneaker.find_all_seller
    seller_count = []
    sellers.each do |el|
      seller_count << { el.to_s => Sneaker.count_sneaker_by_seller(el) }
    end

    render json: seller_count
  end

  def count_most_seller
    sellers = Sneaker.find_all_seller
    most_seller = []
    sellers.each do |el|
      most_seller << { el.to_s => Sneaker.find_most_seller(el) }
    end

    render json: most_seller
  end

  def best_seller_price
    sneaker = Sneaker.find_best_seller_price
    render json: { "sneaker": sneaker }
  end

  def best_seller
    sellers = Sneaker.find_all_seller
    best_seller = []
    sellers.each do |el|
      best_seller << { el.to_s => [
        appear: Sneaker.find_most_seller(el),
        counter: Sneaker.where(seller: el).count,
        price: Sneaker.avergare_price_by_seller(el)
      ]}
    end
    
    render json: best_seller
  end

  # PATCH/PUT /sneakers/1
  def update
    if @sneaker.update(sneaker_params)
      render json: @sneaker
    else
      render json: @sneaker.errors, status: :unprocessable_entity
    end
  end

  def update_wanted
    Sneaker.increment_wanted(sneaker_params["id"])
  end

  # DELETE /sneakers/1
  def destroy
    @sneaker.destroy
  end

  def delete_sneakers_by_seller
    if Rails.env.development?
      Sneaker.remove_sneakers_by_seller(params[:seller])
    else
      Rails.logger.debug "is in prod ! can't delete sneakers !"
    end
  end

  def reset_all_sneakers_data
    if Rails.env.development?
      Sneaker.destroy_all
    else
      Rails.logger.debug "is in prod ! can't delete sneakers"
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_sneaker
    @sneaker = Sneaker.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def sneaker_params
    params.permit(:id, :model, :price, :link, :gender, :seller, :image_path)
  end
end
