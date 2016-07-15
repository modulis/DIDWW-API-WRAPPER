# DIDWW

A simple Rails friendly API wrapper for DIDWW's SOAP based API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'DIDWW', git: 'https://github.com/modulis/DIDWW-API-WRAPPER.git'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install DIDWW

## Usage
### Configuration
First you must configure DIDWW or you won't be able to make requests.
```ruby
DIDWW.configure do |config|
  config.api_username = 'user@user.ca' # Your api username given to you by didww
  config.api_key = 'example_key_u90sd8f7sd9' # Your secret api key given to you by didww
  config.sandbox = false # Optional. True by default, you must set it to live manually.
end
```

For secret information like your `api_key` it's recommended that you use something like environment variables. For example:
```ruby
DIDWW.configure do |config|
  config.api_key = ENV['DIDWW_API_KEY']
end
```

### Building the client
You can create a client which will inheret DIDWW configuration automatically using
```ruby
client = DIDWW::Client.new
```

If you would like to change the configuration for a specific client you'll have to do so manually:
```ruby
client.configuration.sandbox = false # sets this client to live mode
```

### Making calls
A list of methods can be seen in `METHOD_TRANSLATIONS` in the client class in the source code. Making a call is as easy as:
```ruby
client = DIDWW::Client.new
client.check_pstn_number(pstn_number: 1111111)
```

### Convenience methods
DIDWW has a few convenience methods to use in your code:
```ruby
DIDWW.configure do |config|
  config.sandbox = true
end
DIDWW.sandbox? #=> true
DIDWW.live? #=> false
DIDWW.mode #=> :sandbox (alternatively :live)
```

## Development

You have access to a developer console to use the gem interactively by running `bin/console` from the project directory.
Please write specs for any additions, and use shared examples when possible.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/DIDWW.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

