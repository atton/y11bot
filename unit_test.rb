# -*- coding: utf-8 -*-

require 'test/unit'
require './time.rb'

class Test_time < Test::Unit::TestCase

  # get_time

  def test_get_time_true_format
    assert_equal(get_time("0201204011230").class,Time)
  end

  def test_get_time_true_long_format
    assert_equal(get_time("0201204011833jifemeofmai;ofd").class,Time)
  end
  
  def test_get_time_false_status
    assert_equal(get_time("0201114010000hoge"),nil)
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
    assert_equal(get_time("b2012m0308"),nil)
  end
  
  def test_get_time_include_CR
    assert_equal(get_time("02012\n03040000hoge"),nil)
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
  
  # get_diff
  
  def test_get_diff_plus_one_hour
    assert_equal(get_diff(Time.now + 3601),
                 {"day"=>0,"hour"=>1})
  end
  
  def test_get_diff_plus_one_day
    assert_equal(get_diff(Time.now + 1 + (24 * 60 * 60)),
                 {"day"=>1,"hour"=>0})
  end
  
  def test_get_diff_just_time
    assert_equal(get_diff(Time.now + 1),
                 {"day"=>0,"hour"=>0})
  end
  
end
