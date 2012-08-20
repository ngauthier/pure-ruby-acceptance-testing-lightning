require 'test_helper'

class PostsDeleteTest < ActionDispatch::IntegrationTest
  test "delete a post" do
    Dom::Post.create(
      title: "I am awesome"
    )
    @post = Dom::Post.create(
      title: "I am lame"
    )
    assert_equal 2, Dom::Post.count
    @post.delete
    assert_equal 1, Dom::Post.count
    assert_nil Dom::Post.find_by_title "I am lame"
    refute_nil Dom::Post.find_by_title "I am awesome"
    assert_equal ["I am awesome"], Dom::Post.map(&:title)
  end
end
