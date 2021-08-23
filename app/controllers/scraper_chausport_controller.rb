require "nokogiri"
require "open-uri"

class ScraperChausportController < ApplicationController
  def self.scrap_chausport
    @sneaker_chausport = []
    scrap_man_sneaker
    scrap_women_sneaker
  end

  def self.scrap_man_sneaker
    1.upto(20) {
      |i|
      man_page_url = "https://www.chausport.com/l/chaussures/homme.html?p=" + i.to_s
      puts man_page_url
      man_page = URI.parse(man_page_url).open
      man_page_html = Nokogiri::HTML(man_page)
      find_sneakers(man_page_html, "man")
    }
  end

  def self.scrap_women_sneaker
    1.upto(10) {
      |i|
      women_page_url = "https://www.chausport.com/l/chaussures/femme.html?p=" + i.to_s
      puts women_page_url
      women_page = URI.parse(women_page_url).open
      women_page_html = Nokogiri::HTML(women_page)
      find_sneakers(women_page_html, "man")
    }
  end

  def self.find_sneakers(page, gender)
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
    save_sneaker_chausport
  end

  def self.save_sneaker_chausport
    @sneaker_chausport.each do |el|
      sneaker = Sneaker.add_new_sneaker(el)
      sneaker.save if sneaker != nil
    end
    return @sneaker_chausport
  end
end
