#!/usr/bin/env ruby
require "rubygems"
require "bundler/setup"
require "any_sms-backend-smsru"

# Initializer code
AnySMS.configure do |c|
  c.register_backend :my_main_backend,
                     AnySMS::Backend::Smsru,
                     api_id: ENV["SMSRU_TOKEN"]

  c.default_backend = :my_main_backend
end

# Anywhere in your app
text = "some sms text"
resp = AnySMS.send_sms(ENV["MY_PHONE_NUMBER"], text)

# immediate response check
if resp.success?
  puts "Sms should be sent to #{ENV['MY_PHONE_NUMBER']} with text: #{text.inspect}"
else
  puts "There was error sending sms (#{resp.status}): "
  raise resp.meta[:error]
end
