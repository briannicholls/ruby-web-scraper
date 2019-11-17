require 'httparty'
require 'nokogiri'
require 'pry'

class Main

def initialize # initialize, ask user for subreddit name, display info
  @page
  set_subreddit
  display_authors_current_page
end

def get_authors_from_page # returns array of authors on @page
  authors = @page.body.split("author\":\"")
  authors = authors.map{ |a|
    a[0..a.index(",") - 2]
  }
  authors.shift
  authors
end

def set_subreddit #### DOESN'T ALWAYS GET PAGE - INVESTIGATE
  puts "Enter subreddit name:"
  subreddit = gets.strip
  @page = HTTParty.get("http://reddit.com/r/#{subreddit}")
end

def display_authors_current_page # prints all authors on @page
  authors = get_authors_from_page
  authors.each{|author|
    p "#{author}"
  }
end

end
