class DrinksController < ApplicationController
  require "openssl"
  require "nokogiri"
  require "open-uri"
  # url_home = "https://www.vinmonopolet.no/"
  # url = "https://www.vinmonopolet.no/search?q=:relevance:visibleInSearch:true&searchType=product&currentPage=0"
  # @html = Nokogiri::HTML(@page.body)
  def index
    @drinks = Drink.all.order(price: :desc)
  end

  def scrape2
    require "rubygems"
    require "mechanize"

    Drink.destroy_all

    count = page_number

    count.times do |page|
      url = "https://www.vinmonopolet.no/api/search?q=:relevance:visibleInSearch:true&searchType=product&currentPage=#{page}&fields=FULL&pageSize=100"

      agent = Mechanize.new
      @page = agent.get(url)

      list = JSON.parse(@page.body)

      products = list["productSearchResult"]["products"]

      products.each do |product|
        drink = Drink.new
        drink.name = product["name"]
        drink.category = product["main_category"]["name"]
        drink.product_code = product["code"]
        drink.price = product["price"]["value"].to_f
        drink.volume = product["volume"]["value"]
        drink.image_url = product["images"][1]["url"]
        drink.save!
      end
      puts "--> successfully scraped page #{page} / #{count}"
    end
  end

  def page_number
    url = "https://www.vinmonopolet.no/api/search?q=:relevance:visibleInSearch:true&searchType=product&currentPage=0&fields=FULL&pageSize=100"
    agent = Mechanize.new
    results = JSON.parse(agent.get(url).body)
    return results["productSearchResult"]["pagination"]["totalPages"]
  end
end
