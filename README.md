# Cucumber::The

Adds quick access to instances to help you write more fluid steps.

```ruby
Given 'a published post' do
  The[:post] = FactoryGirl.create :post, :published
end

Given 'I publish a post' do
  The[:post] = FactoryGirl.create :post, :published, user: The(:logged_in_user)
end

When 'I go to the post' do
  visit post_path The[:post]
end

Then 'I should see the post title' do
  page.should have_content The[:post].title
end
```

Note that this gem does not generate anything for you, it's up to you to use this to write your own steps in your own style.

## Why?

It's an eyesore to see scenarios like this:

```gherkin
Scenario: Displaying post tags
  Given a post titled "10 things you can do with a broken dishwasher"
  And that the post "10 things you can do with a broken dishwasher" has the tags "topten" and "hackery"
  When I go to the post "10 things you can do with a broken dishwasher"
  Then I should see "topten" and "hackery"
```

It reads a lot better like this:

```gherkin
Scenario: Displaying post tags
  Given a post titled "10 things you can do with a broken dishwasher"
  And that the post has the tags "topten" and "hackery"
  When I go to the post
  Then I should see the tags
```

Note how we can say "the post" and "the tag" instead of referring to the raw data in them. Also note how the second scenario is easier to extend with additional logic, for example:

```ruby
Then 'I should see the tags' do
  The[:tags].each do |tag|
    page.should have_css('.tag', text: tag.name)
  end
end
```

## Why not just variables?

You can implement this yourself by using instance variables, but it has one major drawback:

Every time you want to read the variable, you'll need to check that it is set and fail otherwise. If you don't you'll get `NoMethodError on NilClass` further down the stack, making for a very bad experience for the user.

At that point, you start wrapping these up inside a method and bam, you've implemented this gem. If you don't want the extra dependencies, skip this gem and implement it yourself. If you want to save some time, just use this gem instead of reinventing the wheel.

## Installation

Add this line to your application's Gemfile:

    gem 'cucumber-the', require: false, group: :test

And then execute:

    $ bundle

Then, `require 'cucumber/the'` inside `features/support/env.rb` (or a similar one that you control).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Write tests
4. Implement feature
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
