require "nokogiri"
require "open-uri"

class ScraperCourirController < ApplicationController

  def self.scrap_courir
    home_page_url = "https://www.courir.com/fr/c/homme/?prefn1=typology&prefv1=SNEAKERS"
    # home_page_url = "https://www.footlocker.fr/" scraper one page !
    # home_page_url = "https://www.chausport.com/" scraper one page !
    # home_page_url = "https://www.laboutiqueofficielle.com/" valider !
    home_html = URI.open(home_page_url)
    home_page = Nokogiri::HTML(home_html)
    # find_most_wanted(home_page)
  end

  def self.find_most_wanted(home_page)
    # most_wanted = home_page.css(".most-wanted__container")
    # puts most_wanted
  end
end
