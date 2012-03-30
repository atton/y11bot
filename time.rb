# -*- coding: utf-8 -*-

require 'date'
require 'pp'

def is_enable? date
  # date が Time かつ 今より後の日付かどうか確認
  if date.class != Time
    return false
  end
  date > Time.now
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
