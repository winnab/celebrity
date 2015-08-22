[![Build Status](https://travis-ci.org/winnab/celebrity.svg?branch=master)](https://travis-ci.org/winnab/celebrity)

# Celebrity
> Work in Progress: [Modular-style](http://www.sinatrarb.com/intro.html#Modular%20vs.%20Classic%20Style) game app

### Test
* Running the cucumber or unit tests will also run the coverage tool SimpleCov. Report details are in the `Coverage` folder.

#### Feature tests
```bash

# run Cucumber tests
$ bundle exec cucumber

```

#### Unit tests
```bash

# run rspec tests
$ bundle exec rspec

```

### Develop
* Be sure you have a `.env` file. Follow the `.env.example` file for guidance.

```bash
$ source .env 

# Rerun watches files for changes
$ rerun foreman start

# Watches scss files and compiles css on change
# TODO implement better compiler for scss files
$ sass --watch app/lib/styles/main.scss:app/public/styles/main.css
```

### Travis CI and Heroku
* Evey branch that gets pushed to Github (e.g. `git push -u origin master`) is tested with TravisCI
* Cucumber and RSpec tests run for each build
* The `master` branch is tested with TravisCI _then_ TravisCI automatically pushes to Heroku if the build passed

####  Heroku Debugging
* Log: `heroku logs`
* Get console: `heroku run`
