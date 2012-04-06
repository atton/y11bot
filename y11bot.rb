# -*- coding: utf-8 -*-

require 'twitter'
require "#{File.dirname(File.expand_path __FILE__)}/dm.rb"

DEBUG_FLG = true


# 改善:debug時に各種テキストを改行コード付きで出力した方が分かりやすそう。putsの前後の--start--とかもいらなくなるし。

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
# TODO:fileにmethosを分割する。cronを使うので絶対パスの必要アリ

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
