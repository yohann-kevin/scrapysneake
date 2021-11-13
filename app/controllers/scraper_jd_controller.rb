require "nokogiri"
require "open-uri"

class ScraperJdController < ApplicationController
  def self.scrap_jd(gender)
    @sneaker_jd = []
    case gender
    when "women"
      scrap_women_high_sneaker
      scrap_women_sneaker
      scrap_women_classic_sneaker
    when "man"
      scrap_man_high_sneaker
      scrap_man_sneaker
      scrap_man_classic_sneaker
    else
      scrap_jd("women")
      scrap_jd("man")
    end
  end

  def self.scrap_man_sneaker
    index = 0
    0.upto(10) do
      home_page_url = "https://www.jdsports.fr/homme/chaussures-homme/baskets/?from=#{index}"
      Rails.logger.debug home_page_url
      @home_html = URI.parse(home_page_url).open
      home_page = Nokogiri::HTML(@home_html)
      find_sneaker(home_page, "man")
      index += 72
    end
    @sneaker_jd
  end

  def self.scrap_women_sneaker
    index = 0
    0.upto(6) do
      home_page_url = "https://www.jdsports.fr/femme/chaussures-femme/baskets/?from=#{index}"
      Rails.logger.debug home_page_url
      @home_html = URI.parse(home_page_url).open
      home_page = Nokogiri::HTML(@home_html)
      find_sneaker(home_page, "women")
      index += 72
    end
    @sneaker_jd
  end

  def self.scrap_man_high_sneaker
    home_page_url = "https://www.jdsports.fr/homme/chaussures-homme/?facet-product-type-jd=baskets_hautes"
    Rails.logger.debug home_page_url
    @home_html = URI.parse(home_page_url).open
    home_page = Nokogiri::HTML(@home_html)
    find_sneaker(home_page, "man")
    @sneaker_jd
  end

  def self.scrap_women_high_sneaker
    home_page_url = "https://www.jdsports.fr/femme/chaussures-femme/?facet-product-type-jd=baskets_hautes"
    Rails.logger.debug home_page_url
    @home_html = URI.parse(home_page_url).open
    home_page = Nokogiri::HTML(@home_html)
    find_sneaker(home_page, "women")
    @sneaker_jd
  end

  def self.scrap_man_classic_sneaker
    index = 0
    0.upto(5) do
      home_page_url = "https://www.jdsports.fr/homme/chaussures-homme/baskets-classiques/?from=#{index}"
      Rails.logger.debug home_page_url
      @home_html = URI.parse(home_page_url).open
      home_page = Nokogiri::HTML(@home_html)
      find_sneaker(home_page, "man")
      index += 72
    end
    @sneaker_jd
  end

  def self.scrap_women_classic_sneaker
    index = 0
    0.upto(2) do
      home_page_url = "https://www.jdsports.fr/femme/chaussures-femme/baskets-classiques/?from=#{index}"
      Rails.logger.debug home_page_url
      @home_html = URI.parse(home_page_url).open
      home_page = Nokogiri::HTML(@home_html)
      find_sneaker(home_page, "women")
      index += 72
    end
    @sneaker_jd
  end

  def self.find_sneaker(page, gender)
    page_size = page.css(".productListItem").length
    Rails.logger.debug page_size
    0.upto(page_size - 1) do |el|
      section = page.css(".productListItem")[el]
      link = "https://www.jdsports.fr#{section.css('.itemImage')[0]['href']}"
      @sneaker_jd << {
        "model" => section.css(".itemTitle").children.text.strip,
        "price" => section.css(".pri").text,
        "link" => link,
        "gender" => gender,
        "seller" => "JDsports",
        "image_path" => find_image_path(link)
      }
    end
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
      sneaker&.save
    end
    @sneaker_jd
  end
end
