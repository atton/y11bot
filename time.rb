# -*- coding: utf-8 -*-

require 'date'

def is_enable? date
  # date が Time かつ 今より後の日付かどうか確認
  if date.class != Time
    return false
  end
  date > Time.now
end

def get_time str
  # 最初の文字は抜かして12文字取得
  str = str[1,12]
  # string から Time へ
  begin
    Date.strptime(str,"%Y%m%d%H%M").to_time
  rescue 
    nil
  end
end

