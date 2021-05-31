class SneakersController < ApplicationController
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
    # counter = Sneaker.count_sneaker
    # counter_man = Sneaker.count_sneaker_gender("man")
    # counter_women = Sneaker.count_sneaker_gender("women")
    # render json: {
    #   "counter_sneaker" => counter,
    #   "counter_sneaker_man" => counter_man,
    #   "counter_sneaker_women" => counter_women
    # }

    counter = {}

    0.upto(7) {
      |el|
      # counter << {
      #   "days#{el}" => {
      #     "counter_sneaker" => Sneaker.count_sneaker(el),
      #     "counter_sneaker_man" => Sneaker.count_sneaker_gender(el, "man"),
      #     "counter_sneaker_women" => Sneaker.count_sneaker_gender(el, "women")
      #   }
      # }
      counter["days#{el}"] = {
        "counter_sneaker" => Sneaker.count_sneaker(el),
        "counter_sneaker_man" => Sneaker.count_sneaker_gender(el, "man"),
        "counter_sneaker_women" => Sneaker.count_sneaker_gender(el, "women")
      }
    }

    render json: counter
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

  def find_sneakers
    @sneakers = Sneaker.find_sneaker_with_model(params[:model])

    render json: @sneakers
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
