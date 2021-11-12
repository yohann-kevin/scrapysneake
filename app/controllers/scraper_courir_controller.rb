require "nokogiri"
require "open-uri"

class ScraperCourirController < ApplicationController
  def self.scrap_courir
    # home_page_url = "https://www.courir.com/fr/c/homme/?prefn1=typology&prefv1=SNEAKERS" not work redirection !
    # home_page_url = "https://www.fenom.com/fr/2-sneakers?page=1" not work 403 !
    # home_page_url = "https://stockx.com/fr-fr/sneakers?page=4" not work 403 !

    # home_page_url = "https://www.footlocker.fr/" scraper one page !
    # home_page_url = "https://www.chausport.com/" scraper one page !
    # home_page_url = "https://www.laboutiqueofficielle.com/" scraper one page !

    # home_page_url = "https://www.cornerstreet.fr/sneakers/voir-tous-les-produits.html?p=3" valider !
    # home_page_url = "https://www.footpatrol.fr/chaussures/" valider !
    # home_page_url = "https://www.overkillshop.com/en/sneaker.html?p=2" valider !

    # home_page_url = "https://www.urbanindustry.co.uk/collections/shoes?page=3" valider !
    # home_page_url = "https://www.titoloshop.com/eu_en/men/sneakers?p=4" valider !
    # home_page_url = "https://www.flightclub.com/sneakers?page=12" valider !

    # home_page_url = "https://www.jdsports.fr/homme/chaussures-homme/baskets/" valider !

    home_html = URI.parse(home_page_url).open
    home_page = Nokogiri::HTML(home_html)
    Rails.logger.debug home_page
    # find_most_wanted(home_page)
  end

  def self.find_most_wanted(home_page)
    # most_wanted = home_page.css(".most-wanted__container")
    # puts most_wanted
  end
end
