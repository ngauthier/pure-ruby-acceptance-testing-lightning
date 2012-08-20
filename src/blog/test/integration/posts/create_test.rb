require 'test_helper'

class PostsCreateTest < ActionDispatch::IntegrationTest
  setup do
    @post = Dom::Post.create(
      title: "My post",
      body:  "This is my first post"
    )
  end

  test "it should set the title" do
    assert_equal "My post", @post.title
  end

  test "it should set the body" do
    assert_equal "This is my first post", @post.body
  end

  test "it should show up in the index" do
    assert_equal "My post", Dom::Post.first.title
  end
end
