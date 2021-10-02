require "nokogiri"
require "open-uri"

class ScraperFootlockerController < ApplicationController
  def self.scrap_foot_locker
    @sneaker_foot_locker = []
    scrap_man_sneakers
    scrap_women_sneakers
  end

  def self.scrap_man_sneakers
    man_page_url = "https://www.footlocker.fr/fr/category/homme/chaussures.html"
    man_page = URI.parse(man_page_url).open
    man_page_html = Nokogiri::HTML(man_page)
    find_sneakers(man_page_html, "man")
  end

  def self.scrap_women_sneakers
    women_page_url = "https://www.footlocker.fr/fr/category/femme/chaussures.html"
    women_page = URI.parse(women_page_url).open
    women_page_html = Nokogiri::HTML(women_page)
    find_sneakers(women_page_html, "women")
  end

  def self.find_sneakers(page, gender)
    initial_url = "https://www.footlocker.fr"
    page_size = page.css(".product-container").length
    0.upto(page_size - 1) {
      |el|
      puts el
      section = page.css(".product-container")[el]
      product_link = section.css(".ProductCard-link")[0]["href"]
      @sneaker_foot_locker << {
        "model" => section.css(".ProductName-primary").text,
        "price" => section.css(".ProductPrice").text.tr('^0-9,', ''),
        "link" => "#{initial_url}#{product_link}",
        "gender" => gender,
        "seller" => "Foot Locker",
        "image_path" => find_image("https://www.footlocker.fr/", product_link)
      }
    }
    save_sneaker_foot_locker
    # return @sneaker_foot_locker
  end

  # //images.footlocker.com/is/image/FLEU/
  # id : 314520713604
  # ?wid=236&hei=236&fmt=png-alpha
  def self.find_image(start_uri, link)
    product_page = URI.parse("#{start_uri}#{link}").open
    product_page = Nokogiri::HTML(product_page)
    
    begin
      id = product_page.css(".Tab-panel")[0].text
      id = id.slice(0..(id.index("Color"))).tr('^0-9', '')
      initial_url_img = "images.footlocker.com/is/image/FLEU/"
      final_url_img = "?wid=236&hei=236&fmt=png-alpha"
      uri = "#{initial_url_img}#{id}#{final_url_img}"
    rescue => e
      puts e
      uri = "error"
    end
  end

  def self.save_sneaker_foot_locker
    @sneaker_foot_locker.each do |el|
      sneaker = Sneaker.add_new_sneaker(el)
      sneaker.save if sneaker != nil
    end
    return @sneaker_foot_locker
  end
end
