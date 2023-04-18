require 'faraday'

RakutenWebService.configure do |c|
  c.application_id = ENV['RWS_APPLICATION_ID']
  c.affiliate_id = ENV['RWS_AFFILIATION_ID']
  c.max_retries = 3
  c.debug = true
end
