Feature: Smart error messages
  Error messages should be clear and easy to understand.

  Background:
    Given there is a The registry

  Scenario Outline: A simple name
    Given I try to access <Key> from the registry
    Then I should get an error containing "<Text>"

  Examples:
    | Key                | Text                  |
    | :bar               | the bar               |
    | :smart_creationist | the smart creationist |
    | :10_goons          | the 10 goons          |
