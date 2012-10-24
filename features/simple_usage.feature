Feature: Simple usage
  In the most simple case, just use `The` as a getter and setter inside the tests.

  Scenario: Referring to previously set value
    Given a feature "calculator.feature" with the following scenario:
      """
      Scenario: Addition
        When I add 2 and 2
        Then the sum should be 4
      """
    And step definitions:
      """
      When 'I add 2 and 2' do
        The[:sum] = 2 + 2
      end

      Then 'the sum should be 4' do
        fail if The[:sum] != 4
      end
      """
    And the gem is loaded
    When I run the features
    Then all scenarios should pass
