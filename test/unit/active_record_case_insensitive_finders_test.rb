require "test_helper"

class ActiveRecordCaseInsensitiveFindersTest < ActiveSupport::TestCase

  setup do
  end

  teardown do
  end

  def test_exposes_main_module
    assert ActiveRecordCaseInsensitiveFinders.is_a?(Module)
  end

  def test_exposes_version
    assert ActiveRecordCaseInsensitiveFinders::VERSION
  end

  def test_ci_find_by
    # TODO
  end

  def test_ci_find_by!
    # TODO
  end

  def test_ci_where_matches
    # TODO
  end

  def test_ci_where_like
    # TODO
  end

  def test_ci_order
    # TODO
  end

end
