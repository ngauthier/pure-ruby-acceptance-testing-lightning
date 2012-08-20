require 'test_helper'

class PostsAlphabeticalTest < ActionDispatch::IntegrationTest
  test 'alphabetical listing' do
    %w(alpha gamma beta).each do |title|
      Dom::Post.create(
        title: title
      )
    end

    assert_equal %w(alpha beta gamma), Dom::Post.map(&:title)
  end
end
