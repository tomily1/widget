# frozen_string_literal: true

ShowoffApi.configure do |c|
  c.client_id = Rails.application.credentials.showoff[:client_id]
  c.client_secret = Rails.application.credentials.showoff[:client_secret]
  c.host = Rails.application.credentials.showoff[:host]
  c.logger = Logger.new(STDOUT).tap { |l| l.level = :debug }
end
