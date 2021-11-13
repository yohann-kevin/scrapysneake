class ScraperController < ApplicationController
  skip_before_action :authorized

  # http://localhost:3000/scrap/footLocker&chausport&officialShop

  def scrap
    # ScraperCourirController.scrap_courir
    webapps = analyze_params(params[:webapp])
    @gender = params[:gender]
    Rails.logger.debug @gender
    Rails.logger.debug " "
    render json: @data = find_sneakers(webapps)
  end

  def find_sneakers(webapps)
    sneaker = {
      "foot_locker" => check_foot_locker(webapps),
      "chausport" => check_chausport(webapps),
      "official_shop" => check_official_shop(webapps),
      "jd_sport" => check_jd(webapps),
      "flight_club" => check_flight_club(webapps),
      "corner" => check_corner(webapps),
      "test" => test_site_scrap(webapps)
    }
    {
      "response" => true,
      "data" => sneaker
    }
  end

  def analyze_params(params)
    params.split("&")
  end

  def check_foot_locker(webapps)
    webapps.each do |el|
      return ScraperFootlockerController.scrap_foot_locker if el == "footLocker"
    end
    nil
  end

  def check_official_shop(webapps)
    webapps.each do |el|
      return ScraperOfficialshopController.scrap_officialshop(@gender) if el == "officialShop"
    end
    nil
  end

  def check_jd(webapps)
    webapps.each do |el|
      return ScraperJdController.scrap_jd(@gender) if el == "jd"
    end
    nil
  end

  def check_flight_club(webapps)
    webapps.each do |el|
      return ScraperFlightClubController.scrap_flight_club if el == "flightClub"
    end
    nil
  end

  def check_corner(webapps)
    webapps.each do |el|
      return ScraperCornerController.scrap_corner if el == "corner"
    end
  end

  # for test site
  def test_site_scrap(webapps)
    webapps.each do |el|
      return ScraperCourirController.scrap_courir if el == "courir"
    end
    nil
  end

  # out !
  def check_chausport(webapps)
    webapps.each do |el|
      return ScraperChausportController.scrap_chausport if el == "chausport"
    end
    nil
  end
end
