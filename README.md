# Widget App
[![Build Status](https://travis-ci.com/tomily1/widget.svg?branch=master)](https://travis-ci.com/tomily1/widget)

Rails application which wraps ShowOff's API and allows users to manage and view widgets.

### Requirements
1. Ruby version 2.6.0
2. Rails 5.2
3. Bundler version 1.17.2


### Technology used
* Language
  1. Ruby
* Framework used
  1. Ruby on Rails
* Development and testing
  1. RSpec Rails
  2. Rubocop

### Setting up
1. clone this respository `git clone git@github.com:tomily1/widget.git`.
2. Open the cloned directory with `cd widget`.
3. Run `bundle install` to install dependencies
4. set the showoff_api configuration in `config/initializers/showoff_api.rb`
N.B. 4 has already been set in the `credentials.yml.enc`. the `master.key` will be sent to you separately
5. run the app with `rails server`
6. the app will be available on `localhost:3000`


### Live Demonstration

This app is available and hosted on Heroku and it is available here https://showoff-widget.herokuapp.com.

## Approach

After reading the requirements carefully, I created a api wrapper in form of a gem in `vendor/gems` folder which contains all the hosts in the api documentation. To get in first hand how this API works, follow the steps:

1. cd into `vendor/gems/showoff_api`.
2. copy the `client_id` and `client_secret` in the config in `.pryrc` file.
3. In your console at the root of the gem, run command `pry`.

## Showoff_Api GEM
 This provides a wrapper for the ShowOff API. The response class provides three attributes `code`, `message` and `data` 

* Configuration
```ruby
  config = ShowoffApi.configure do |c|
    c.client_id = '<client_id>'
    c.client_secret = '<client_secret>'

    c.host = 'host'
    c.logger = Logger.new(STDOUT).tap { |l| l.level = :debug }
  end
```

* Authentication
```ruby
  # Login user and get back token
  response = ShowoffApi::Auth.new.login(user_name: '<username>', password: '<password>')

  # Register a new user
  response = ShowoffApi::Auth.new.register(
    first_name: '<first_name>',
    last_name: '<last_name>',
    user_name: '<username>',
    password: '<password>',
    image_url: '<url>'
  )

  # Revoke access token
  response = ShowoffApi::Auth.new.revoke('<user token>')

  # Refresh access token
  response = ShowoffApi::Auth.new.refresh('<user token>')

```

* User
```ruby
  # Fetch my widgets
  response = ShowoffApi::User.new.my_widgets('<token>', 'term (optional)')

  # Fetch widgets belonging to a particular user
  response = ShowoffApi::User.new.widgets('<token>', 'user_id', 'term (optional)')

  # update user data
  response = ShowoffApi::User.new.update('<token>', 'user object = {}')

  # show a user or Me
  response = ShowoffApi::User.new.show('<token>', 'id (optional)')

  # Change user password
  response = ShowoffApi::User.new.change_password('<token>', 'new & old password payload')

  # check email
  response = ShowoffApi::User.new.check_email('<token>', 'email')

  # reset password
  response = ShowoffApi::User.new.reset_password('<token>', '{ email: t@t.co }')
```

* Widget
```ruby
  # fetch widgets (visible as well)
  response = ShowoffApi::Widget.new.fetch('<token>', 'term (optional)', 'visible/not (boolean and optional)')

  # create widget
  response = ShowoffApi::Widget.new.create('<token>', 'widget payload (hash)')

  # update widget
  response = ShowoffApi::Widget.new.update('<token>', 'id', 'widget payload (hash)')

  # destroy/delete widget
  response = ShowoffApi::Widget.new.destroy('<token>', 'id')
```

* Response

To log response from the api wrapper gem you can do the following

```ruby
  p response.code
  p response.message
  p response.data
```
