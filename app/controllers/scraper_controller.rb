class ScraperController < ApplicationController
  def scrap
    # ScraperCourirController.scrap_courir
    # foot_locker_sneaker = ScraperFootlockerController.scrap_foot_locker

    chausport_sneaker = ScraperChausportController.scrap_chausport
    puts " "
    # puts foot_locker_sneaker.length
    render json: {"data" => sneaker = {
        "foot_locker" => "foot_locker_sneaker",
        "chausport" => chausport_sneaker
      }
    }
  end
end
