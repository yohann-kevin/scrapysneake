require "nokogiri"
require "open-uri"

class ScraperFlightClubController < ApplicationController
  skip_before_action :authorized

  def self.scrap_flight_club
    @sneaker_flight_club = []
    scrap_sneaker
  end

  def self.scrap_sneaker
    page_url = "https://www.flightclub.com/sneakers"
    page = URI.parse(page_url).open
    page_html = Nokogiri::HTML(page)
    find_sneaker(page_html, "man")
  end

  def self.find_sneaker(page, gender)
    product = page.css(".iYMDAx")
    puts product
  end
end
