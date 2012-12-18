@announce
Feature: Bulk Rename Command Line Utility
  In order to perform bulk renames of files
  As a newcomer to Cucumber
  I want to be able to rename multiple files in a folder by file extension

  Scenario:
    Given an empty file named "photos/a.jpeg"
    And an empty file named "photos/b.jpeg"
    And an empty file named "photos/c.jpeg"
    When I run `bulkrename photos jpeg jpg`
    Then the following files should exist:
		| photos/a.jpg |
		| photos/b.jpg |
		| photos/c.jpg |