# -*- coding: utf-8 -*-
# 手動での告知用。

require 'twitter'

DEBUG = true

msg = ""

Twitter.configure do |config|
  config.consumer_key = gets.chomp
  config.consumer_secret = gets.chomp
  config.oauth_token = gets.chomp
  config.oauth_token_secret = gets.chomp
end

if DEBUG
  puts "-----以下の内容をポストします-----"
  puts msg
else
  Twitter.update msg
end
