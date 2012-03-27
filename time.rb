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
  # string から Time へ
  begin
    Date.strptime(str,"%Y%m%d").to_time
  rescue 
    nil
  end
end

def cut_msg msg
  # 最初の文字は抜かして8文字取得
  msg[1,8]
end
