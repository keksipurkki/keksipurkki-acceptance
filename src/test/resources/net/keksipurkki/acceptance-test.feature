Feature: Some feature

    Scenario: A failing scenario
        Given an integer
        When divided by zero
        Then result is not a number

    Scenario: A succeeding scenario
        Given an integer
        When multiplied by one
        Then expected result