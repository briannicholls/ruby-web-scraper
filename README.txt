Run: bin/ruby-web-scraper

Will ask the user for a subreddit name, then print usernames of authors of the
first 127 posts on that subreddit (as long as the posts are not quarantined or
otherwise made unavailable somehow... seems to not get all posts on more
controversial subreddits)

Appends a timestamp with the author list to /bin/logs/author_record.txt
