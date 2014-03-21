Feature: has_key?
  It could sometimes be useful to see if a value is set without having to play
  around with exceptions. A user might, for example, have a step that
  conditionally re-uses values from other steps depending on certain contexts.

  Scenario: Checking is a key is set
    Given a feature "user_listing.feature" with the following scenario:
      """
      Scenario: Admin users first
        Given I have 12 users
        And I have an additional admin user
        When I open the user list
        Then I should see 10 users
        And I should see a pagination link
        And the admin user should be first
      """
    And step definitions:
      """
      User = Struct.new(:name, :admin)

      Given 'I have 12 users' do
        The.users = (1..12).map { |n| User.new("User #{n}", false) }
      end

      Given 'I have an additional admin user' do
        user = User.new("Da boss", true)
        The.admin_user = user
        The.users << user
      end

      When 'I open the user list' do
        The.user_list = The.users.sort { |a, b| (b.admin && 1 || 0) <=> (a.admin && 1 || 0) }[0..9]
      end

      Then 'I should see 10 users' do
        The.user_list.size.should == 10
      end

      Then 'I should see a pagination link' do
        The.users.size.should be > The.user_list.size
      end

      Then 'the admin user should be first' do
        if The.has_key?(:admin_user)
          The.user_list[0].should == The.admin_user
        else
          The.user_list[0].should be_admin
        end
      end
      """
    And the gem is loaded
    When I run the features
    Then all scenarios should pass
