# -*- coding: utf-8 -*-

require 'twitter'
require "#{File.dirname(File.expand_path __FILE__)}/dm.rb"

DEBUG_FLG = true


def tweet dm,debug
  # tweet する
  text = get_body(dm.text) + get_footer(dm.text)

  if debug
    puts "*POSTします*"
    puts "------ dm text start ------"
    puts dm.text
    puts "------- dm text end -------"
    puts "----- post text start -----"
    puts text
    puts "------ post text end ------"
    puts
  else
    Twitter.update text
  end
end

def delete_dm dm,debug
  # DM を削除する

  if debug
    puts "*このDMを削除します*"
    puts "id : #{dm.id}"
    puts "----- dm text start -----"
    puts dm.text
    puts "------ dm text end ------"
    puts
    puts
  else
    Twitter.direct_message_destroy dm.id
  end
end

# main

Twitter.configure do |config|
  config.consumer_key = gets.chomp
  config.consumer_secret = gets.chomp
  config.oauth_token = gets.chomp
  config.oauth_token_secret = gets.chomp
end

Twitter.direct_messages.each do |dm|
  # DMが有効ならばtweet,無効ならばDMを削除する
  if is_enable? dm.text
    tweet dm,DEBUG_FLG
  else
    delete_dm dm,DEBUG_FLG
  end
end
