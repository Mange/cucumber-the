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

  Scenario: Failing on missing values
    Given a feature "dog.feature" with the following scenario:
      """
      Scenario: Humping
        When I hump the leg
        Then I should be happy
      """
    And step definitions:
      """
      class Dog
        def happy?
          @humped
        end

        def hump(item)
          @humped = true
        end
      end

      When 'I hump the leg' do
        @dog = Dog.new
        @dog.hump The[:leg]
      end

      Then 'I should be happy' do
        @dog.happy?
      end
      """
    And the gem is loaded
    When I run the features
    Then a scenario should fail with:
      """
      Don't know what "the leg" is. Did you forget to assign it and/or run a prerequisite step before this step?
      """
