# Installation
- Clone repo and change directory to project root `cd find_salon` and run `bundle install`
- Requires google maps api key with google places enabled

# `FindSalon::UserLocation`
GeoIp lookup based off of ip or address with city and state.

```ruby
FindSalon::UserLocation.new_for_ip("12.12.12.12")
FindSalon::UserLocation.new_for_address('140 Market St, San Francisco, CA')
```

# Tests with RSpec
- comes with stubbed out http requests for easy local testing
