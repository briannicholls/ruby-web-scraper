require 'httparty'
require 'nokogiri'
require 'pry'

class Main

def initialize # initialize, ask user for subreddit name, display info
  @authors = {}
  @page
  @num = 25
  @subreddit
  set_subreddit
  build_authors_array
  display_authors
end

def get_authors_from_page # returns array of authors on @page
  authors = @page.body.to_s.split("author\":\"")
  authors = authors.map{ |a|
    a[0..a.index(",") - 2]
  }
  authors.shift
  authors
end

def set_subreddit #### DOESN'T ALWAYS GET PAGE - INVESTIGATE
  puts "Enter subreddit name:"
  @subreddit = gets.strip
  @page = HTTParty.get("http://reddit.com/r/#{@subreddit}")
  puts "page : : #{@page.class}"
end

def display_authors # prints all authors on first 9 pages
  puts "Authors on first 9 pages of subreddit:"
  @authors.each{ |a,v|
    puts "#{a} :: #{v}"
  }
end

def increment_page
  suffix = "?count=#{@num}"
  @num += 25
  @page = HTTParty.get("http://reddit.com/r/#{@subreddit}/#{suffix}")
end

def build_authors_array
  page = 1
  until page == 10
      @authors["PAGE #{page}"] = get_authors_from_page
      increment_page
      page += 1
  end
end


end
