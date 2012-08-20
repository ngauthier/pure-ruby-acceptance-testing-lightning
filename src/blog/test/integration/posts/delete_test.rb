require 'test_helper'

class PostsDeleteTest < ActionDispatch::IntegrationTest
  test "delete a post" do
    @post = Dom::Post.create
    assert_equal 1, Dom::Post.count
    @post.delete
    assert_equal 0, Dom::Post.count
  end
end
