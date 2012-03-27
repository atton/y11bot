# -*- coding: utf-8 -*-

require 'date'
require 'pp'

def is_enable? date
  if date.class != Time
    return false
  end
  date > Time.now
end

def get_time msg
  begin
    Date.strptime(msg,"%Y%m%d").to_time
  rescue 
    nil
  end
end
pp is_enable?(get_time("20120309"))
pp is_enable?(get_time("29120309"))
pp is_enable?(get_time("291203iiiii09"))
