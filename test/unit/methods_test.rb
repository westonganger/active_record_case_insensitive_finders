require "test_helper"

class MethodsTest < ActiveSupport::TestCase

  setup do
  end

  teardown do
    Post.destroy_all
    Comment.destroy_all
  end
  
  def test_ci_find_by
    actual_name = "FOO"

    Post.create!(name: actual_name)

    record = Post.ci_find_by(name: actual_name.downcase)

    assert record

    assert record.is_a?(Post)

    assert_equal record.name, actual_name

    assert_nil Post.ci_find_by(name: SecureRandom.hex(6))
  end

  def test_ci_find_by!
    actual_name = "FOO"

    Post.create!(name: actual_name)

    record = Post.ci_find_by(name: actual_name.downcase)

    assert record

    assert record.is_a?(Post)

    assert_equal record.name, actual_name

    assert_raises ActiveRecord::RecordNotFound do
      Post.ci_find_by!(name: SecureRandom.hex(6))
    end
  end

  def test_ci_where_matches
    Post.create!(name: "FOO")
    Post.create!(name: "foo")

    Post.create!(name: "FOOBAR")
    Post.create!(name: "foobar")

    relation = Post.ci_where_matches(name: :foo)
    assert_equal relation.size, 2

    relation = Post.ci_where_matches(name: :FOO)
    assert_equal relation.size, 2

    relation = Post.ci_where_matches(name: "%foo%")
    assert_equal relation.size, 4

    relation = Post.ci_where_matches(name: "%FOO%")
    assert_equal relation.size, 4

    post_id = Post.first.id

    Comment.create!(post_id: post_id, content: "foo")
    Comment.create!(post_id: post_id, content: "FOO")
    Comment.create!(post_id: post_id, content: "foobar")
    Comment.create!(post_id: post_id, content: "FOOBAR")

    relation = Post.joins(:comments).ci_where_matches(comments: {content: :foo})
    assert_equal relation.size, 2

    relation = Post.joins(:comments).ci_where_matches(comments: {content: :FOO})
    assert_equal relation.size, 2

    relation = Post.joins(:comments).ci_where_matches(comments: {content: "%foo%"})
    assert_equal relation.size, 4

    relation = Post.joins(:comments).ci_where_matches(comments: {content: "%FOO%"})
    assert_equal relation.size, 4

    ### Test dot-notation syntax
    relation = Post.joins(:comments).ci_where_matches("comments.content" => "%FOO%")
    assert_equal relation.size, 4

    ### Test full-string syntax
    assert_raises ArgumentError do
      Post.joins(:comments).ci_where_matches("comments.content = 'FOO'")
    end
  end

  def test_ci_order
    ### Seed, out of order on purpose so that default ID ordering doesnt occur here
    f2_upcase = Post.create!(name: "F2")
    f2_downcase = Post.create!(name: "f2")

    f3_upcase = Post.create!(name: "F3")
    f3_downcase = Post.create!(name: "f3")

    f1_upcase = Post.create!(name: "F1")
    f1_downcase = Post.create!(name: "f1")

    expected_order = [
      f1_upcase.id,
      f1_downcase.id,
      f2_upcase.id,
      f2_downcase.id,
      f3_upcase.id,
      f3_downcase.id,
    ]

    assert_equal expected_order, Post.ci_order(name: :asc).pluck(:id)

    expected_order = [
      f3_upcase.id,
      f3_downcase.id,
      f2_upcase.id,
      f2_downcase.id,
      f1_upcase.id,
      f1_downcase.id,
    ]

    assert_equal expected_order, Post.ci_order(name: :desc).pluck(:id)

    Post.ci_order(comments: {content: :desc})

    foo_downcase = Comment.create!(post_id: f3_upcase.id, content: "foo")
    foo_upcase = Comment.create!(post_id: f2_upcase.id, content: "FOO")
    foobar_downcase = Comment.create!(post_id: f1_upcase.id, content: "foobar")
    foobar_upcase = Comment.create!(post_id: f3_downcase.id, content: "FOOBAR")
    bar_downcase = Comment.create!(post_id: f2_downcase.id, content: "bar")
    bar_upcase = Comment.create!(post_id: f1_downcase.id, content: "BAR")

    expected_order = [
      foobar_downcase.post_id,
      foobar_upcase.post_id,
      foo_downcase.post_id,
      foo_upcase.post_id,
      bar_downcase.post_id,
      bar_upcase.post_id,
    ]

    ### Test hash syntax
    assert_equal expected_order, Post.joins(:comments).ci_order(comments: {content: :desc}).pluck(:id)

    ### Test dot-notation syntax
    assert_equal expected_order, Post.joins(:comments).ci_order("comments.content" => :desc).pluck(:id)

    ### Test full-string syntax
    assert_raises ArgumentError do
      Post.joins(:comments).ci_order("comments.content desc").pluck(:id)
    end
  end

end
