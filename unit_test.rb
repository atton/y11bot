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
  
  # cut_msg
  
  def test_cut_msg_true_string
    assert_equal(cut_msg("020120101x"),"20120101")
  end
  
  def test_cut_msg_long_string
    assert_equal(cut_msg("01234567890abcdefg"),"12345678")
  end
  
  def test_cut_msg_short_string
    assert_equal(cut_msg("00"),"0")
  end
  
  def test_cut_msg_empty_string
    assert_equal(cut_msg(""),nil)
  end
  
  def test_cut_msg_include_multibyte_char
    assert_equal(cut_msg("あiうeおkaきkuけko"),"iうeおkaきk")
  end
  
  def test_cut_msg_all_multibyte_char
    assert_equal(cut_msg("あいうえおかきくけこ"),"いうえおかきくけ")
  end

end
