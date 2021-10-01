require "nokogiri"
require "open-uri"

class ScraperOfficialshopController < ApplicationController
  def self.scrap_officialshop
    @sneaker_official_shop = []
    scrap_man_low_sneaker
    scrap_women_low_sneaker
    scrap_man_high_sneaker
    scrap_women_high_sneaker
  end

  def self.scrap_man_low_sneaker
    1.upto(20) {
      |i|
      man_page_url = "https://www.laboutiqueofficielle.com/baskets-chaussures-2/baskets-basses-91.html?sexe=Homme&page=" + i.to_s
      man_page = URI.parse(man_page_url).open
      man_page_html = Nokogiri::HTML(man_page)
      find_sneaker(man_page_html, "man")
    }
    return @sneaker_official_shop
  end

  def self.scrap_women_low_sneaker
    1.upto(7) {
      |i|
      women_page_url = "https://www.laboutiqueofficielle.com/baskets-chaussures-2/baskets-basses-91.html?sexe=Femme&page=" + i.to_s
      women_page = URI.parse(women_page_url).open
      women_page_html = Nokogiri::HTML(women_page)
      find_sneaker(women_page_html, "women")
    }
    return @sneaker_official_shop
  end

  def self.scrap_man_high_sneaker
    1.upto(2) {
      |i|
      man_page_url = "https://www.laboutiqueofficielle.com/baskets-chaussures-2/baskets-montantes-92.html?sexe=Homme&page=" + i.to_s
      man_page = URI.parse(man_page_url).open
      man_page_html = Nokogiri::HTML(man_page)
      find_sneaker(man_page_html, "man")
    }
    return @sneaker_official_shop
  end

  def self.scrap_women_high_sneaker
    women_page_url = "https://www.laboutiqueofficielle.com/baskets-chaussures-2/baskets-montantes-92.html?sexe=Femme"
    women_page = URI.parse(women_page_url).open
    women_page_html = Nokogiri::HTML(women_page)
    find_sneaker(women_page_html, "women")
  end

  def self.find_sneaker(page, gender)
    initial_link = "https://www.laboutiqueofficielle.com"
    page_size = page.css(".c-product-thumbnail").length

    0.upto(page_size - 1) {
      |el|
      puts el
      section = page.css(".c-product-thumbnail")[el]
      mark = section.css(".c-product-thumbnail__title").text
      model = section.css(".c-product-thumbnail__desc").text
      @sneaker_official_shop << {
        "model" => build_model(mark, model),
        "price" => section.css(".c-price").text,
        "link" => "#{initial_link}#{page.css(".c-product-thumbnail")[el]["href"]}",
        "gender" => gender,
        "seller" => "La Boutique officielle",
        "image_path" => section.css(".c-product-thumbnail__img-wrapper").css("img")[0]["src"],
      }
    }
    save_sneaker_official_shop
  end

  def self.build_model(mark, model)
    model = "#{mark} #{model}"
    arr = model.split(" ")
    final_model = ""
    0.upto(4) {
      |el|
      final_model += "#{arr[el]} "
    }
    return final_model.tr("0-9","")
  end

  def self.save_sneaker_official_shop
    @sneaker_official_shop.each do |el|
      sneaker = Sneaker.add_new_sneaker(el)
      sneaker.save if sneaker != nil
    end
    return @sneaker_official_shop
  end
end
