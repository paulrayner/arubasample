@announce
Feature: Test script using Aruba
  In order to develop some kind of command line script using Aruba
  As a newcomer to Aruba
  I want to confirm that the script does the right thing

  Background:
    Given an empty file named "photos/a.jpeg"
    And an empty file named "photos/b.jpeg"
    And an empty file named "photos/c.jpeg"
    And an empty file named "photos/d.jpg"

  Scenario: Default script output is correct
    When I run `bulkrename`
    Then the exit status should be 0
    And the output should contain "Tasks"
    And the output should contain:
    """
    Tasks:
  	   bulkrename help [TASK]    # Describe available tasks or one specific task
  	   bulkrename rename FOLDER  # Rename file extensions in designated folder
"""
    And the banner should be present
    And the banner should document that this app takes no options
    And the banner should document that this app's arguments are:
    	| folder | which is required |
    	| extn   | which is required |
     	| new    | which is required |
    And there should be a one line summary of what the app does
    
  Scenario: Renaming works correctly
    When I run `bulkrename photos jpeg jpg`
    Then the following files should exist:
      | photos/a.jpg |
      | photos/b.jpg |
      | photos/c.jpg |
      | photos/d.jpg |