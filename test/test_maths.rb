# frozen_string_literal: true

require "test_helper"

class TestMaths < Minitest::Test
  def test_add
    assert_equal 4, Magick::Maths::add.(2).(2)
  end
end
