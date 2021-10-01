class ScraperController < ApplicationController
  # http://localhost:3000/scrap/footLocker&chausport&officialShop

  def scrap
    # ScraperCourirController.scrap_courir
    webapps = analyze_params(params[:webapp])
    puts " "
    render json: @data = find_sneakers(webapps)
  end

  def find_sneakers(webapps)
    {
      "response" => true,
      "data" => sneaker = {
        "foot_locker" => check_foot_locker(webapps),
        "chausport" => check_chausport(webapps),
        "official_shop" => check_official_shop(webapps),
        "jd_sport" => check_jd(webapps),
        "test" => test_site_scrap(webapps)
      }
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

  def check_chausport(webapps)
    webapps.each do |el|
      return ScraperChausportController.scrap_chausport if el == "chausport"
    end
    nil
  end

  def check_official_shop(webapps)
    webapps.each do |el|
      return ScraperOfficialshopController.scrap_officialshop if el == "officialShop"
    end
    nil
  end

  def check_jd(webapps)
    webapps.each do |el|
      return ScraperJdController.scrap_jd if el == "jd"
    end
    nil
  end

  # for test site
  def test_site_scrap(webapps)
    webapps.each do |el|
      return ScraperCourirController.scrap_courir if el == "courir"
    end
    nil
  end
end
