require 'httparty'
require 'nokogiri'
require 'pry'

class Main
def initialize
  puts "Enter subreddit name: "
  @subreddit = gets.strip
  @page
  @authors = []
end

def set_page(suffix = "") # gets page, tries again if error
  @page = HTTParty.get("http://reddit.com/r/#{@subreddit}/.json#{suffix}")
  if !@page.success?
    set_page
  else
    puts "response code: #{@page.code} (success!)"
  end
end

def add_authors_current_page # pushes authors of posts on this page to @authors
  posts = @page["data"]["children"] # Array of Hashes with each post's data
  posts.each{ |post|
    @authors.push(post['data']['author'])
  }
end

def get_id_last_post # gets id of last post on front page
  posts = @page['data']['children']
  last_id = posts.last['data']['id']
  last_id
end

def increment_page # adds suffix with arguments to URL to get next 100 posts
  last_id = get_id_last_post
  set_page("?limit=100&after=t3_#{last_id}")
end

def print_authors # puts @authors
  @authors.each{ |a|
    puts "#{a}"
  }
end

def start # main method
  set_page
  add_authors_current_page # (first 27, on front page)
  increment_page
  add_authors_current_page # (next 100 posts after the last on page 1)
  print_authors
  save_to_file
end

def save_to_file # adds timestamp and saves @authors to file
  open("./bin/logs/author_record.txt", "a") do |f|
    f.puts Time.now
    f.puts "SUBREDDIT: /r/#{@page["data"]["children"][0]["data"]["subreddit"]}"
    f.puts @authors
  end
end

end
