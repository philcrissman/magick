# frozen_string_literal: true

require 'test_helper'

class TestLoops < Minitest::Test
  def test_map
    a = [1,2,3,4,5]
    double = ->(a){ Magick::Maths::mult.(a).(2) }
    assert_equal [2,4,6,8,10], Magick::Loops.map.(double).(a)
  end

  def test_fold
    a = [1,2,3,4,5]
    sum = Magick::Loops::fold.(Magick::Maths::add).(0)
    assert_equal 15, sum.(a)
  end

  def test_sum
    assert_equal 6, Magick::Loops::sum.([1,2,3])
  end

  def test_length
    assert_equal 3, Magick::Loops::length.([1,2,3])
  end
end
