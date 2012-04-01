# -*- coding: utf-8 -*-

require 'date'
require 'pp'
require 'Twitter'


# methods

def is_enable? str
  # 文字列strが有効かどうか確認する
  # get_time で時間を取得できるか get_footer_head で単語を取得できるか確認
  # 両方取得できたら、今より先のデータか確認する
  if get_time(str).nil? || get_footer_head(str).nil?
    return false
  end
  get_time(str) > Time.now
end

def get_time str
  # 最初の文字は抜かして12文字取得
  # YYYYmmddHHMM のフォーマット
  str = str[1,12]
  # string から Time へ
  begin
    DateTime.strptime(str + "JST","%Y%m%d%H%M%Z").to_time
  rescue 
    nil
  end
end

def get_diff time
  # 時刻差分を取得。
  diff = (time - Time.now).to_i
  day  = (diff / (60 * 60)) / 24
  hour = (diff / (60 * 60)) % 24

  return { "day"=>day , "hour"=>hour }
end

def get_footer_head str
  # 先頭の数字からフッタの先頭を取得する
  str = str[0,1]

  # 0 = 無し
  # 1 = 期限
  # 2 = 試験
  # 3 = 補講
  # default nil

  case str
  when "0"
    ""
  when "1" 
    "期限"
  when "2"
    "試験"
  when "3"
    "補講"
  else 
    nil 
  end
end

def get_footer_foot diff
  # フッタの後半を取得する。時刻の部分。

  day = diff["day"]
  hour = diff["hour"]

  if day >= 30
    "まで30日以上あります"
  elsif day >= 1 && hour == 0
    "までおよそ#{day}日です"
  elsif day == 0 && hour >= 1
    "までおよそ#{hour}時間です"
  elsif day >= 1 && hour >= 1
    "までおよそ#{day}日と#{hour}時間です"
  else
    "まで1時間を切っています"
  end
end

def get_footer str
  # フッタを取得する。
  # nil確認はしないので呼び出し前にis_enable?で要確認
  # strの先頭が0のときだけ空の文字列

  diff = get_diff(get_time str)

  if get_footer_head(str).empty?
    ""
  else
    "\n#{get_footer_head str}#{get_footer_foot diff}"
  end
end

def get_body str
  # str の2行目以降を返す
  str.sub /^.*\n/,""
end

# 改善:debug時に各種テキストを改行コード付きで出力した方が分かりやすそう。putsの前後の--start--とかもいらなくなるし。

def tweet dm,debug
  # tweet する
  text = get_body(dm.text) + get_footer(dm.text)

  if debug
    puts "POSTします"
    puts "------ dm text start ------"
    puts dm.text
    puts "------- dm text end -------"
    puts "----- post text start -----"
    puts text
    puts "------ post text end ------"
    puts
    puts
  else
  end
end

def delete_dm dm,debug
  # DM を削除する

  if debug
    puts "このDMを削除します"
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

DEBUG_FLG = true

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
