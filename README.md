# Command Line Interface Tool
- Clone repo and change directory to project root `cd find_salon` and run `bundle install`

# Install gem
You do not need to install gem to use the command line tool just clone repo.
If you do want to install the gem then clone repo and cd into project root.
```
gem build find_salon.gemspec
gem install find_salon-0.1.0.gem
```

## The executable `bin/find_salon`
FindSalon will lookup your ip for geographic data and print your city and state.
```
$ bin/find_salon

Welcome to FindSalon.

You are in: Astoria

Type a command and hit enter
q=quit, l=list_salons, c=change_location, f=find
```

To change enter `c` and follow the instructions. It will automatically print results for you.

```
Type a command and hit enter
q=quit, l=list_salons, c=change_location, f=find
c
Please enter address city and state, e.g.
140 Market St, San Francisco, CA
140 Market St, San Fran, CA     
San Francisco, CA
0 Spa Vitale | Rating:  | Address: 8 Mission Street, San Francisco
1 Supercuts | Rating: 3.6 | Address: 18 Battery Street, San Francisco
2 One Twenty For Hair | Rating:  | Address: 155 Main Street, San Francisco
3 Nails For You | Rating:  | Address: 17 Drumm Street # 2, San Francisco
4 Salon.Com | Rating:  | Address: 101 Spear Street # 203, San Francisco
...
```

Hit `f` and an id to find one of the cached results

```
Type a command and hit enter
q=quit, l=list_salons, c=change_location, f=find
f
Please enter the id number of salon:
0
name: Spa Vitale
rating: not available
vicinity: 8 Mission Street, San Francisco

```

# Requirements
- Requires google maps api key with google places enabled

# `API`
## `FindSalon::UserLocation`
GeoIp lookup based off of ip or address with city and state.

```ruby
FindSalon::UserLocation.new_for_ip("12.12.12.12")
FindSalon::UserLocation.new_for_address('140 Market St, San Francisco, CA')
```

# Tests with RSpec
- comes with stubbed out http requests with `vcr` for easy local testing
