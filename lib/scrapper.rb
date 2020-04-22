require 'pry'
require 'rubygems'
require 'nokogiri'
require 'open-uri'



class Scrapper
  attr_accessor :city_names, :city_emails, :my_hash

  def initialize(url)
    @city_names = []
    @city_emails = []
    @my_hash = {}
  end

  # Gets the names of each city & cleans them
  def get_city

    page = "https://www.annuaire-des-mairies.com/val-d-oise.html"

    region = Nokogiri::HTML(open(page))
    return @city_names = region.xpath("//a[contains(@class, 'lientxt')]/text()").map {|x| x.to_s.downcase.gsub(" ", "-") }
  end

  # Gets emails of each city
  def get_email
  
    for n in 0...@city_names.length

      page_url_ville = "https://www.annuaire-des-mairies.com/95/#{@city_names[n]}.html"

      ville_page = Nokogiri::HTML(open(page_url_ville))

      # Exception for empty emails
      begin
        @city_emails << ville_page.xpath("//html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]/text()").to_s
      rescue => e

        @city_emails << " "
      end
    end

    return @city_emails
  end

  # Creates a hash city + email
  def make_hash
    @my_hash = Hash[get_city.zip(get_email)]
  end

  # Saves the hash as a json file
  def save_as_JSON
    File.open("db/emails.json","w") do |mail|
      mail.puts(JSON.pretty_generate(@my_hash)) 
      end	
  end

  # Saves the hash as a csv file
  def save_as_csv
		CSV.open("db/emails.csv", "w") do |csv|
			csv << ["City", "Email"]
			@my_hash.each_pair  do |key, value|
			csv << [key, value]
		end
		end
  end
  
  # saves the hash as spreadsheet
  def save_as_spreadsheet

  end

  # Executes each method
  def perform
    get_city
    get_email
    make_hash
    save_as_JSON
    save_as_csv
  end
  
end