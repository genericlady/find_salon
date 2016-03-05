# Steps to Complete a CLI Gem
* stub out the interface (use a heredoc and make things easy)

# A command line tool that finds salons near your location
* https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=500&type=beauty_salonkey=YOUR_API_KEY

# List Search Results. Choose place from list. Search for place by place_id
## List results, type `find-salon` for a list of salons nearby

### Expected Output

```
Welcome to FindSalon
Your current location is Astoria, NY
Would you like to change your location?

First 5 Salons near you
For more details select 1-5 or type exit
#get real Data
1. Tease Hair Group - 4.6
   199 2nd Ave

2. Foo Cutters - 3.6
   199 2nd Ave

3. Electric Clippers - 4.2
   199 2nd Ave
```

### Nearby Search to get results

```ruby
"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=40.7732,-73.926&radius=500&type=beauty_salon&key=#{ENV['GOOGLE_PLACES_KEY']}"

uri = URI.parse(url)

response = Net::HTTP.get_response(uri)

json = JSON.parse(response.body)

result = json['results'].first
result['name'] result['vicinity'] result['rating']
result['place_id']

json['next_page_token']
json['status']
```

## User Output for Place Search

```
Finick Hair Studio - rating: 4.7 of 5
phone: (02) 9571 5898
address: 8/1-9 Pyrmont Bridge Rd, Pyrmont NSW 2009, Australia

Total Reviews: 10

First few reviews:

1. author: Sally Hershey - rating: 3
So glad I found this place. Since moving to Pyrmont I've struggled to find a good hair studio.

Then I found Ben at Finick Hair Studio. Straight up he is a highly skilled hairdresser and I appreciate the time he takes to find out exactly what you're after as well as understanding, especially as I have always had difficulties communicating what I'm after lol.

Definitely recommend this place

```

## Place Search Data Structure

```ruby
uri = URI.parse("https://maps.googleapis.com/maps/api/place/details/json?placeid=ChIJ_w1ZRjeuEmsRSjN83DAtkSw&key=#{ENV['GOOGLE_PLACES_KEY']}")
response = Net::HTTP.get_response(uri)
body = response.body
json = JSON.parse(body)
json['result']
json['result']['name']
json['result']['rating']
json['result']['formatted_phone_number']
json['result']['formatted_address']
json['result']['reviews'].count

review = json['result']['reviews'].first
review['author_name'] review['rating']
review['text']

# Raise an error for bad status
json['status']
```
building wrapper yay
