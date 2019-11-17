require 'httparty'
require 'nokogiri'
require 'pry'

page = HTTParty.get(‘https://www.reddit.com/r/popular/’)

# puts page.code

authors = page.body.split("author\":\"")

# authors[10].index("\\")

# authors[10][0..authors[10].index(",")]

authors = authors.map{ |a|
  a[0..a.index(",") - 1]
}

authors.shift
