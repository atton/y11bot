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
  diff = (time - Time.now).to_i
  day  = (diff / (60 * 60)) / 24
  hour = (diff / (60 * 60)) % 24
 
  return { "day"=>day , "hour"=>hour }
end
