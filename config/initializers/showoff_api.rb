ShowoffApi.configure do |c|
  c.client_id = ENV["CLIENT_ID"]
  c.client_secret = ENV["CLIENT_SECRET"]

  c.endpoint = ENV["ENDPOINT"]
  c.logger = Logger.new(STDOUT).tap { |l| l.level = :debug }
end
