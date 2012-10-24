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

  Scenario: No pollution between scenarios
    Given a feature "cat.feature" with the following scenarios:
      """
      Background:
        Given I am a cat

      Scenario: Sleeping
        When I sleep on a blanket
        Then I should be as warm as the blanket

      Scenario: 
        When I pee on the blanket
        Then I should be smug about it
      """
    And step definitions:
      """
      class Cat
        def sleep_on(item)
          @sleeping_on = item
        end

        def temperature
          @sleeping_on.temperature
        end

        def pee_on(item)
          item.ruin
        end
      end

      class Blanket
        def temperature() 22 end # Celcius, because standards are nice
        def ruin() @ruined = true end
        def ruined?() @ruined end
      end

      Given 'I am a cat' do
        @cat = Cat.new
      end

      When 'I sleep on a blanket' do
        The[:blanket] = Blanket.new
        @cat.sleep_on The[:blanket]
      end

      When 'I pee on the blanket' do
        @cat.pee_on The[:blanket]
      end

      Then 'I should be smug about it' do
        @cat.instance_of?(Cat) # Cats are always smug
      end

      Then 'I should be as warm as the blanket' do
        @cat.temperature.should == The[:blanket].temperature
      end
      """
    And the gem is loaded
    When I run the features
    Then a scenario should fail with:
      """
      Don't know what "the blanket" is.
      """
