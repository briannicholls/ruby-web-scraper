require 'httparty'
require 'nokogiri'
require 'pry'

class Main

#URL = "http://reddit.com/r/joerogan.json"
def initialize
  puts "Enter subreddit name: "
  @subreddit = gets.strip
  @page
  @authors = []
end

def set_page(suffix = "")
  @page = HTTParty.get("http://reddit.com/r/#{@subreddit}/.json#{suffix}")
  if !@page.success?
    set_page
  else
    puts "response code: #{@page.code}"
  end
end

def add_authors_current_page
  posts = @page["data"]["children"] # Array of Hashes with each post's data
  posts.each{ |post|
    @authors.push(post['data']['author'])
  }
end

def get_id_last_post
  posts = @page['data']['children']
  last_id = posts.last['data']['id'] # append to URL suffix to get next batch
  last_id
end

def increment_page
  last_id = get_id_last_post
  set_page("?limit=100&after=t3_#{last_id}")
end

def print_authors
  @authors.each{ |a|
    puts "#{a}"
  }
end

def start
  set_page
  add_authors_current_page
  increment_page
  add_authors_current_page

  print_authors
end

end
