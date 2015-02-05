[![Build Status](https://travis-ci.org/winnab/celebrity.svg?branch=master)](https://travis-ci.org/winnab/celebrity)

# Celebrity
> Work in Progress [Modular-style](http://www.sinatrarb.com/intro.html#Modular%20vs.%20Classic%20Style) Sinatra app 

### Local
* Be sure you have a `.env` file. Follow the `.env.example` file for guidance.

#### Develop

```bash

$ source .env 

# Rerun watches files for changes
$ rerun foreman start

```

#### Test

##### Feature tests

* `/features` contains Cucumber tests and step definitions

```bash

# run Cucumber tests
$ bundle exec cucumber

```

##### Unit tests

* `/spec` contains RSpec tests

```bash

# run rspec tests
$ bundle exec rspec

```

### Heroku

*Note:* be sure you have Heroku Toolbelt

* Deploy: `git push heroku [local-name]:master`
* Log: `heroku logs`
* Get console: `heroku run`
