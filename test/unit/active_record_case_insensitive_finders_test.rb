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
    # TODO test direct match queries

    # TODO test like queries
  end

  def test_ci_find_by!
    # TODO test direct match queries

    # TODO test like queries
  end

  def test_ci_where_matches
    # TODO test direct match queries

    # TODO test like queries
  end

  def test_ci_order
    # TODO
  end

end
