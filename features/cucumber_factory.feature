Feature: Cucumber factory
  In order to test cucumber-the in an easy way
  As a developer
  I want to dynamically generate cucumber features and run them

  Scenario: Creating passing feature
    Given a feature "tautology.feature" with the following scenario:
      """
      Scenario: 1 is 1
        Then 1 should equal 1
      """
    And step definitions:
      """
      Then /^(\d+) should equal (\d+)$/ do |a, b|
        fail unless a == b
      end
      """
    When I run the features
    Then all scenarios should pass

  Scenario: Creating failing feature
    Given a feature "lies.feature" with the following scenario:
      """
      Scenario: Big brother
        Given slavery
        Then that is freedom
      """
    And step definitions:
      """
      Given 'slavery' do
        @slavery = true
      end

      Then 'that is freedom' do
        fail if @slavery
      end
      """
    When I run the features
    Then a scenario should fail

