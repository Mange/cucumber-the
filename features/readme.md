# Cucumber::The

`Cucumber::The` adds quick access to instances to help you write more fluid steps.

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
  The.tags.each do |tag|
    page.should have_css('.tag', text: tag.name)
  end
end
```

## How?

Take a peek at the features to see how to use this project.

## Ruby versions

This gem supports the following versions of Ruby:

  * Ruby 1.8.7
  * Ruby 1.9.3
  * JRuby (1.8 mode)
  * JRuby (1.9 mode)
  * Rubinius (1.8 mode)
  * Rubinius (1.9 mode)
