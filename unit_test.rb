# -*- coding: utf-8 -*-

require 'test/unit'
require './time.rb'

class Test_time < Test::Unit::TestCase

  # get_time
  def test_get_time_true_format
    assert_equal(get_time("20120401").class,Time)
  end

  def test_get_time_false_format
    assert_equal(get_time("100099988"),nil)
  end

  def test_get_time_long_format
    assert_equal(get_time("1234567890"),nil)
  end

  def test_get_time_short_format
    assert_equal(get_time("333"),nil)
  end
  
  def test_get_time_illegal_format
    assert_equal(get_time("2012m0308"),nil)
  end
  

  # is_enable?
  
  def test_is_enable_future_date
    assert_equal(is_enable?(Time.now + 1),true)
  end
  
  def test_is_enable_past_date
    assert_equal(is_enable?(Time.now - 1),false)
  end
  
  def test_is_enable_just_date
    assert_equal(is_enable?(Time.now),false)
  end
  
  def test_is_enable_nil
    assert_equal(is_enable?(nil),false)
  end

end
