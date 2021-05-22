require "nokogiri"
require "open-uri"

class ScraperFootlockerController < ApplicationController
  def self.scrap_foot_locker
    
  end

  def self.scrap_men_sneakers
    men_page_url = "https://www.footlocker.fr/fr/category/homme/chaussures.html"
    men_page = URI.open(men_page_url)
    men_page_html = Nokogiri::HTML(men_page)
    find_men_sneakers(men_page_html)
  end

  def self.find_men_sneakers(page)
    initial_url = "https://www.footlocker.fr"
    page_size = page.css(".product-container").length
    page = page.css(".product-container")[47]
    model = page.css(".ProductName-primary").text
    price = page.css(".ProductPrice").text
    link = page.css(".ProductCard-link")[0]["href"]
    image = find_image("https://www.footlocker.fr/", link)

    # //images.footlocker.com/is/image/FLEU/
    # id : 314520713604
    # ?wid=236&hei=236&fmt=png-alpha

    puts "-----------"
    puts "model : #{model}"
    puts " "
    puts "price : #{price.tr('^0-9,', '')}"
    puts " "
    puts "image path : #{image}"
    puts " "
    puts "link : #{initial_url}#{link}"
    puts " "
    puts "size : #{page_size}"
  end

  def self.find_image(start_uri, link)
    product_page = URI.open("#{start_uri}#{link}")
    product_page = Nokogiri::HTML(product_page)
    id = product_page.css(".Tab-panel")[0].text
    # plop.slice(0..(plop.index('world')))
    id = id.slice(0..(id.index("Color"))).tr('^0-9', '')
    initial_url_img = "images.footlocker.com/is/image/FLEU/"
    final_url_img = "?wid=236&hei=236&fmt=png-alpha"
    uri = "#{initial_url_img}#{id}#{final_url_img}"
  end
end
