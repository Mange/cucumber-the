Feature: Message access
  Some people prefer `The.post` over `The[:post]` and we want to support this.

  Scenario: Referrings to items using messages
    Given a feature "calculator.feature" with the following scenario:
      """
      Scenario: Addition
        When I add 2 and 2
        Then the sum should be 4
      """
    And step definitions:
      """
      When 'I add 2 and 2' do
        The.sum = 2 + 2
      end

      Then 'the sum should be 4' do
        fail if The.sum != 4
      end
      """
    And the gem is loaded
    When I run the features
    Then all scenarios should pass
