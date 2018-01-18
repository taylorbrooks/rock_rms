### A Ruby wrapper for the Rock RMS API

To get a general overview of Rock RMS: https://www.rockrms.com

To stay up-to-date with the code changes of Rock RMS: https://github.com/SparkDevNetwork/Rock

I'm a big fan of Rock so if you have problems using the gem or would like to see support for new endpoints, please open a GitHub issue -- I'll get it resolved as quick as I can.

### Installation
Add this line to your application's Gemfile:
````ruby
  # in your Gemfile
  gem 'rock_rms', '~> 1.1'

  # then...
  bundle install
````

### Usage
````ruby
  client = RockRMS::Client.new(
    url: ...,
    username: ...,
    password: ...,
  )

  # Find a specific person
  client.find_person_by_email('gob@bluthco.com')
  client.find_person_by_name('Tobias Funke')
````

### History

View the [changelog](https://github.com/taylorbrooks/rock_rms/blob/master/CHANGELOG.md)
This gem follows [Semantic Versioning](http://semver.org/)

### Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/taylorbrooks/rock_rms/issues)
- Fix bugs and [submit pull requests](https://github.com/taylorbrooks/rock_rms/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features

### Copyright
Copyright (c) 2018 Taylor Brooks. See LICENSE for details.
