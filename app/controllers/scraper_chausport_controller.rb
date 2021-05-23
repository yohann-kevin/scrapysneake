require "nokogiri"
require "open-uri"

class ScraperChausportController < ApplicationController
  def self.scrap_chausport
    @sneaker_chausport = []
    scrap_man_sneaker
    scrap_women_sneaker
  end

  def self.scrap_man_sneaker
    man_page_url = "https://www.chausport.com/l/chaussures/homme.html"
    man_page = URI.open(man_page_url)
    man_page_html = Nokogiri::HTML(man_page)
    find_sneaker(man_page_html, "man")
  end

  def self.scrap_women_sneaker
    women_page_url = "https://www.chausport.com/l/chaussures/femme.html"
    women_page = URI.open(women_page_url)
    women_page_html = Nokogiri::HTML(women_page)
    find_sneaker(women_page_html, "women")
  end

  def self.find_sneaker(page, gender)
    page_size = page.css(".product-item__container").length

    0.upto(page_size - 1) {
      |el|
      puts el
      section = page.css(".product-item__container")[el]
      section = section.css(".product-item__image-container")
      @sneaker_chausport << {
        "model" => "#{section.css(".product-item__brand").text} #{section.css(".product-item__model").text}".split.join(" "),
        "price" => section.css(".product-item__price-box-span").text.split.join(" ") ,
        "link" => section.css(".product-item__link")[0]["href"],
        "gender" => gender,
        "seller" => "Chausport",
        "image_path" => section.css(".product-item__image")[0]["data-src"]
      }
    }

    return @sneaker_chausport
  end
end
