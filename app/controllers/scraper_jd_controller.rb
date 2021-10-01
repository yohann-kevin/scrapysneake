require "nokogiri"
require "open-uri"

class ScraperJdController < ApplicationController

  def self.scrap_jd
    @sneaker_jd = []
    scrap_man_sneaker
  end

  def self.scrap_man_sneaker
    index = 0
    0.upto(10) {
      home_page_url = "https://www.jdsports.fr/homme/chaussures-homme/baskets/?from=" + index.to_s
      puts home_page_url
      @home_html = URI.parse(home_page_url).open
      home_page = Nokogiri::HTML(@home_html)
      find_sneaker(home_page, "man")
      index += 72
    }
    return @sneaker_jd
  end

  def self.find_sneaker(page, gender)
    page_size = page.css(".productListItem").length

    0.upto(page_size - 1) {
      |el|
      puts el
      section = page.css(".productListItem")[el]
      link = "https://www.jdsports.fr" + section.css(".itemImage")[0]["href"]
      @sneaker_jd << {
        "model" => section.css(".itemTitle").children.text.strip,
        "price" => section.css(".pri").text,
        "link" => link,
        "gender" => gender,
        "seller" => "JDsports",
        "image_path" => find_image_path(link)
      }
    }
    save_sneaker_jd
  end

  def self.find_image_path(link)
    sneaker_html = URI.parse(link).open
    sneaker_page = Nokogiri::HTML(sneaker_html)
    sneaker_page.css(".imgMed")[0]["src"]
  end

  def self.save_sneaker_jd
    @sneaker_jd.each do |el|
      sneaker = Sneaker.add_new_sneaker(el)
      sneaker.save if sneaker != nil
    end
    return @sneaker_jd
  end
end
