require "nokogiri"
require "open-uri"

class ScraperCornerController < ApplicationController
  def self.scrap_corner
    @sneaker_corner = []
    scrap_sneaker
    return @sneaker_corner
  end

  def self.scrap_sneaker
    1.upto(10) {
      |el|
      page_url = "https://www.cornerstreet.fr/sneakers/voir-tous-les-produits.html?p=" + el.to_s
      page = URI.parse(page_url).open
      page_html = Nokogiri::HTML(page)
      find_sneaker(page_html, "man")
    }
  end

  def self.find_sneaker(page, gender)
    page_size = page.css(".product-item").length
    1.upto(page_size - 1) {
      |el|
      puts el
      product = page.css(".product-item")[el]
      begin
        @sneaker_corner << {
          "model" => product.css(".text-uppercase")[1].text.strip,
          "price" => product.css(".price").text.strip,
          "link" => product.children[1]["href"],
          "gender" => gender,
          "seller" => "corner",
          "image_path" => product.css(".m-b-1")[0].css("source")[0]["srcset"],
        }
      rescue => exception
        puts exception
      end
    }
    save_sneaker_corner
  end

  def self.save_sneaker_corner
    @sneaker_corner.each do |el|
      sneaker = Sneaker.add_new_sneaker(el)
      sneaker.save if sneaker != nil
    end
  end
end
