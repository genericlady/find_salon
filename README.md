# Steps to Complete a CLI Gem
* stub out the interface (use a heredoc and make things easy)
* remove whitespace from here doc with `.gsub /^\s*/,''`


# A command line tool that finds salons near your location

* https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=500&type=beauty_salonkey=YOUR_API_KEY
* user types `find-salon` shows a list of salons nearby with services, price range, address and ratings.
* list results

1. Tease Hair Group - 4.6 - reviews: 10
   199 2nd Ave - (212) 725-7088

"Welcome to FindSalon"
"Your current location is Astoria, NY"
"Salons near you:"
"Would you like to change your location?"


```ruby
public_ip = `curl https://api.ipify.org`
```
uri = URI.parse("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=500&type=beauty_salon&key=ENV[GOOGLE_PLACES_KEY]

response = Net::HTTP.get_response(uri)
response.readbody
