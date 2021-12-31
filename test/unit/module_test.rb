require "test_helper"

class ModuleTest < ActiveSupport::TestCase

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

end
