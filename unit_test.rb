# -*- coding: utf-8 -*-

require 'test/unit'
require './dm.rb'

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

  def tset_get_diff_plus_one_day_and_hour
    assert_equal(get_diff(Time.now + (60 * 60) + (24 * 60 * 60) + 1),
                 {"day"=>1,"hour"=>1})
  end


  # get_footer_head

  def test_get_footer_head_0
    assert_equal(get_footer_head("0hoge"),"")
  end

  def test_get_footer_head_1
    assert_equal(get_footer_head("1hoge"),"期限")
  end

  def test_get_footer_head_2
    assert_equal(get_footer_head("2hoge"),"試験")
  end

  def test_get_footer_head_3
    assert_equal(get_footer_head("3hoge"),"補講")
  end

  def test_get_footer_head_nil
    assert_equal(get_footer_head("hoge"),nil)
  end

  # get_footer_foot

  def test_get_footer_foot_one_day_one_hour
    assert_equal(get_footer_foot({"day"=>1,"hour"=>1}),
                 "までおよそ1日と1時間です")
  end

  def test_get_footer_foot_one_day_zero_hour
    assert_equal(get_footer_foot({"day"=>1,"hour"=>0}),
                 "までおよそ1日です")
  end

  def test_get_footer_foot_zero_day_one_hour
    assert_equal(get_footer_foot({"day"=>0,"hour"=>1}),
                 "までおよそ1時間です")
  end

  def test_get_footer_foot_zero_day_zero_hour
    assert_equal(get_footer_foot({"day"=>0,"hour"=>0}),
                 "まで1時間を切っています")
  end

  # get_body

  def test_get_body_one_line
    assert_equal(get_body("100\n"),"")
  end

  def test_get_body_two_line
    assert_equal(get_body("100\n2\n"),"2\n")
  end

  def test_get_body_three_line
    assert_equal(get_body("100\n200\n3\n"),"200\n3\n")
  end

  def test_get_body_no_line
    assert_equal(get_body("hoge"),"hoge")
  end

  # is_enable? and get_footer

  def test_is_enable_and_get_footer_many_date
    # 負荷テスト。いろいろ試しても例外で落ちないか
    # is_enable? が通るものはget_footerできるかどうか
    0.upto(5) do |head|
      2011.upto(2013) do |year|
        0.upto(13) do |month|
          0.upto(32) do |day|
            0.upto(25) do |hour|
              0.step(60,10) do |min|
                str = format("%d%04d%02d%02d%02d%02d",head,year,month,day,hour,min)
                if is_enable? str
                  assert_equal((get_footer str).class,String)
                end
              end
            end
          end
        end
      end
    end
  end
end
