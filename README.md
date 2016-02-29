# Steps to Complete a CLI Gem

~* Plan your gem, imagine users interacting with it~
* Start with the project structure - google how to build gem
** bootstrap your gem `bundle gem project_name`
** modify .gemspec
** run tests

* Start with the entry point - bin/file.rb
** make a file in bin executable `cmhod +x filename`
** there is no need to use the ruby extension
** just be sure to place at the top of your file `#!/usr/bin/env ruby`

* use the CLI as it's own namespace and represent it as controller
* The CLI namespace should be a child of your application `MyApp::CLI`
* MyApp::CLI.new.start
* force that to build the CLI interface

* stub out the interface (use a heredoc and make things easy)
* remove whitespace from here doc with `.gsub /^\s*/,''`
* useful methods for interface `list_salons`, `menu` and `goodbye`

* start making things real
* Start to get real data
* https://maps.googleapis.com/maps/api/place/nearbysearch/output?parameters
* output can be json / xml
* separate each parameter with `&`
* required parameters key/location/radius/rankby=distance
* https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=500&type=restaurant&name=cruise&key=YOUR_API_KEY
* type=beauty_salon
* key=PLACES_KEY
* discover objects

* program

# A command line tool that finds salons near your location

* a user types find-salon and shows a list of salons with services, price range, address and ratings.

1. Tease Hair Group - 4.6 - reviews: 10
   199 2nd Ave - (212) 725-7088

* a user selects a number and can read the reviews if there are any
* a user can add a salon to their bookmarks

# Notes

get json object from google places api

testing expected input and output for cli with stdin and stdout

```ruby
it "takes user's name and returns it" do
  expect(STDOUT).to receive(:puts).with("What shall I call you today?")
  allow(STDIN).to receive(:gets) { 'joe' }
  expect(game.ask_for_name).to eq 'Joe'
end
```

# Resources

[Gems for interface](http://www.sitepoint.com/ruby-command-line-interface-gems/)
[RSpec Mocks](https://github.com/rspec/rspec-mocks)
[CLI Gem Steps](http://blog.excelwithcode.com/option-parser-in-cli-apps.html)
