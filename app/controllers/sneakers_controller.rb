class SneakersController < ApplicationController
  skip_before_action :authorized
  before_action :set_sneaker, only: [:show, :update, :destroy]

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
    puts "------------"
    puts sneaker_params
    @sneaker = Sneaker.add_new_sneaker(sneaker_params)

    if @sneaker.save
      render json: @sneaker, status: :created, location: @sneaker
    else
      render json: @sneaker.errors, status: :unprocessable_entity
    end
  end

  def sneaker_count
    counter = {}

    0.upto(7) {
      |el|
      counter["days#{el}"] = {
        "counter_sneaker" => Sneaker.count_sneaker(el),
        "counter_sneaker_man" => Sneaker.count_sneaker_gender(el, "man"),
        "counter_sneaker_women" => Sneaker.count_sneaker_gender(el, "women")
      }
    }

    render json: counter
  end

  def count_most_seller
    seller = Sneaker.find_all_seller

    puts seller[0]
    most_seller = {
      "#{seller[0]}" => Sneaker.find_most_seller(seller[0]),
      "#{seller[1]}" => Sneaker.find_most_seller(seller[1]),
      "#{seller[2]}" => Sneaker.find_most_seller(seller[2]),
      "#{seller[3]}" => Sneaker.find_most_seller(seller[3])
    }

    render json: most_seller
  end

  def best_seller_price
    sneaker = Sneaker.find_best_seller_price
    render json: { "sneaker": sneaker }
  end

  # PATCH/PUT /sneakers/1
  def update
    if @sneaker.update(sneaker_params)
      render json: @sneaker
    else
      render json: @sneaker.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sneakers/1
  def destroy
    @sneaker.destroy
  end

  def delete_sneakers_by_seller
    if Rails.env == "development"
      Sneaker.remove_sneakers_by_seller(params[:seller])
    else
      puts "is in prod ! can't delete sneakers !"
    end
  end

  def reset_all_sneakers_data
    if Rails.env == "development"
      Sneaker.destroy_all
    else
      puts "is in prod ! can't delete sneakers"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sneaker
      @sneaker = Sneaker.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sneaker_params
      params.permit(:model, :price, :link, :gender, :seller, :image_path)
    end
end
