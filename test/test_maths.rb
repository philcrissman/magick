# frozen_string_literal: true

require "test_helper"

class TestMaths < Minitest::Test
  def test_add
    assert_equal 4, Magick::Maths::add.(2).(2)
  end

  def test_negate
    assert_equal (-2), Magick::Maths::negate.(2)
    assert_equal 2, Magick::Maths::negate.(-2)
  end

  def test_subtract
    assert_equal 2, Magick::Maths::subtract.(4).(2)
  end

  def test_multiply
    assert_equal 12, Magick::Maths::multiply.(4).(3)
  end

  def test_mult
    assert_equal 12, Magick::Maths::mult.(4).(3)
  end

  def test_divide
    assert_equal 3, Magick::Maths::divide.(12).(4)
  end

  def test_mod
    assert_equal 0, Magick::Maths::mod.(12).(3)
    assert_equal 1, Magick::Maths::mod.(11).(2)
  end

  def test_exp
    assert_equal 16, Magick::Maths::exp.(2).(4)
    assert_equal 32, Magick::Maths::exp.(2).(5)
  end

  def test_power
    assert_equal 9, Magick::Maths::power.(3).(3).(Magick::Maths::add)
    assert_equal 27, Magick::Maths::power.(3).(3).(Magick::Maths::multiply)
  end
end
