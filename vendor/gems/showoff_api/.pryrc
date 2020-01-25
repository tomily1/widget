# frozen_string_literal: true

require './lib/showoff_api.rb'

RestClient.log = 'stdout'

ShowoffApi.configure do |c|
  c.client_id = '277ef29692f9a70d511415dc60592daf4cf2c6f6552d3e1b769924b2f2e2e6fe'
  c.client_secret = 'd6106f26e8ff5b749a606a1fba557f44eb3dca8f48596847770beb9b643ea352'

  c.endpoint = 'https://showoff-rails-react-production.herokuapp.com'
  c.logger = Logger.new(STDOUT).tap { |l| l.level = :debug }
end
