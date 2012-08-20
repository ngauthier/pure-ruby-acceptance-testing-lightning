class Post < ActiveRecord::Base
  attr_accessible :body, :title
  scope :alphabetical, order: 'title ASC'
end
