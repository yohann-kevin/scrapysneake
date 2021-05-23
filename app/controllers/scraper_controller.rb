class ScraperController < ApplicationController
  def scrap
    # ScraperCourirController.scrap_courir
    # foot_locker_sneaker = ScraperFootlockerController.scrap_foot_locker
    # chausport_sneaker = ScraperChausportController.scrap_chausport
    official_shop_sneaker = ScraperOfficialshopController.scrap_officialshop

    puts " "
    # puts foot_locker_sneaker.length
    render json: {"data" => sneaker = {
        "foot_locker" => "foot_locker_sneaker",
        "chausport" => "chausport_sneaker",
        "official_shop" => official_shop_sneaker
      }
    }
  end
end
