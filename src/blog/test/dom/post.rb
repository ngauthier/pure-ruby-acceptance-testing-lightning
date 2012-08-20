module Dom
  class Post < Domino
    selector '.post'
    attribute :title, 'h2'
    attribute :body

    def self.create(opts = {})
      click_link "New Post"
      fill_in 'Title', with: opts[:title]
      fill_in 'Body',  with: opts[:body]
      click_button "Create Post"
      click_link 'Back'
      self.all.last
    end

    def delete
      node.click_link 'Destroy'
    end
  end
end
