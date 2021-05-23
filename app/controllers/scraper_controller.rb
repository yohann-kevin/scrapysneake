class ScraperController < ApplicationController
  def scrap
    # ScraperCourirController.scrap_courir
    # foot_locker_sneaker = ScraperFootlockerController.scrap_foot_locker
    puts " "
    puts foot_locker_sneaker.length
    render json: {"data" => sneaker = {
        "foot_locker" => "foot_locker_sneaker"
      }
    }
  end
end
