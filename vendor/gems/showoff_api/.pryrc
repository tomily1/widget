# frozen_string_literal: true

require './lib/showoff_api.rb'

RestClient.log = 'stdout'

ShowoffApi.configure do |c|
  c.client_id = '1234'
  c.client_secret = '1234'

  c.host = 'https://showoff-rails-react-production.herokuapp.com'
  c.logger = Logger.new(STDOUT).tap { |l| l.level = :debug }
end
