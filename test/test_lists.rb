# frozen_string_literal: true

require 'test_helper'

class TestLists < Minitest::Test
  def test_car
    assert_equal 1, Magick::Lists::car.([1,2,3])
  end

  def test_cdr
    assert_equal [2,3], Magick::Lists::cdr.([1,2,3])
  end

  def test_cons
    assert_equal [1, 2, 3], Magick::Lists::cons.(1).([2, 3])
  end

  def test_is_empty
    assert Magick::Lists::is_empty.([])
    refute Magick::Lists::is_empty.([1,2,3])
  end
end
