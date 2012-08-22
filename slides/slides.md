!SLIDE
# Pure Ruby<br>Acceptance Testing
## Nick Gauthier | [@ngauthier](http://twitter.com/ngauthier)

!SLIDE
# Your application has a domain language

!SLIDE
# What about your tests?

!SLIDE
# Zero Abstraction

    @@@ ruby
    test 'can make a blog post' do
      visit '/'
      fill_in 'Title', with: 'My post'
      fill_in 'Body', with: 'Cool content'
      click_button 'Create post'
      assert page.has_content?('Cool content')
    end

!SLIDE
# Leads to duplication

!SLIDE
# English Abstraction

    @@@ cucumber
    When I visit the home page
    And  I fill in 'Title' with 'My post'
    And  I fill in 'Body' with 'Cool content'
    And  I press 'Create post'
    Then I should see 'Cool content'

## But the code is still
    @@@ text
    When I visit   =>  visit ...
    When I fill in => fill_in ...
    When I press   => click_button ...
    Then I should see => page.has_content? ...

!SLIDE
# And compound steps

    @@@ cucumber
    When I make a post with title 'My post' and body 'Cool content'

## Are just more verbose

!SLIDE
# Our tests are in ruby

!SLIDE
# So let's write better ruby!

!SLIDE
    @@@ ruby
    setup do
      @post = Dom::Post.create(
        title: "My post",
        body:  "This is my first post"
      )
    end


!SLIDE
    @@@ ruby
    test "set the title" do
      assert_equal(
        "My post",
        @post.title
      )
    end

!SLIDE
    @@@ ruby
    test "show up in the index" do
      refute_nil(
        Dom::Post.find_by_title 'My post'
      )
    end

!SLIDE
    @@@ ruby
    test 'alphabetical listing' do
      titles = %w(alpha gamma beta)
      
      titles.each do |title|
        Dom::Post.create(
          title: title
        )
      end
      
      assert_equal(
        titles.sort,
        Dom::Post.map(&:title)
      )
    end

!SLIDE
# Where's the ...
* HTML & CSS?
* Field names?
* Button names?

!SLIDE
# Abstracted in a Domino
    @@@ ruby 
    class Dom::Post < Domino
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
    end

!SLIDE
# Domino
## abstraction over the DOM
### HTML => Enumerable
    @@@ ruby
    Dom::Post.map {...}.reduce {...}
    Dom::Post.select {...}.each(&:delete)

!SLIDE
# Gotcha!
## It's a gem I wrote a year ago
### [http://github.com/ngauthier/domino](http://github.com/ngauthier/domino)

!SLIDE
# Thanks!
![thanks.gif](thanks.gif)
