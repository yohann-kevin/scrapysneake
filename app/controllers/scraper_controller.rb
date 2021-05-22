class ScraperController < ApplicationController
  def scrap
    # ScraperCourirController.scrap_courir
    ScraperFootlockerController.scrap_men_sneakers

    render json: {"plop" => "plop"}
  end
end
