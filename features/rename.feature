Feature: Bulk Rename Command Line Utility
  In order to perform bulk renames of files
  As a newcomer to Cucumber
  I want to be able to rename multiple files in a folder by file extension

  Background:
    Given an empty file named "photos/a.jpeg"
    And an empty file named "photos/b.jpeg"
    And an empty file named "photos/c.jpeg"
    And an empty file named "photos/d.jpg"

# Refactor usage step definition
  Scenario: Default script output is correct
    When I run `bulkrename`
    Then the exit status should be 0
    And the output should contain:
    """
    USAGE: bulkrename <folder name> <find_extension> <replace_extension> [--overwrite|askoverwrite]
    """

  Scenario: Must include extension to find
    When I run `bulkrename photos`
    Then the exit status should be 1
    And the output should contain:
    """
    Error: <find_extension> is required
    """

  Scenario: Must include new replacement extension
    When I run `bulkrename photos jpeg`
    Then the exit status should be 1
    And the output should contain:
    """
    Error: <replace_extension> is required
    """
    
  Scenario: Invalid option syntax
    When I run `bulkrename photos jpeg jpg extra`
    Then the exit status should be 1
    And the output should contain:
    """
    Error: Invalid option 'extra'
    """

  Scenario: Invalid option name
    When I run `bulkrename photos jpeg jpg --option`
    Then the exit status should be 1
    And the output should contain:
    """
    Error: Invalid option name '--option'
    """

  Scenario: Must not allow too many arguments
    When I run `bulkrename photos jpeg jpg --option extra`
    Then the exit status should be 1
    And the output should contain:
    """
    Error: Too many arguments
    """
    
  Scenario: Renaming works correctly
    When I run `bulkrename photos jpeg jpg`
    Then the output should contain:
    """
    Loading file names from folder: photos
    Replacing file type jpeg with jpg
    Renaming photos/a.jpeg to photos/a.jpg
    Renaming photos/b.jpeg to photos/b.jpg
    Renaming photos/c.jpeg to photos/c.jpg
    """
    And the following files should exist:
      | photos/a.jpg |
      | photos/b.jpg |
      | photos/c.jpg |
      | photos/d.jpg |

  Scenario: Missing folder
    When I run `bulkrename missingfolder jpeg jpg`
    Then the exit status should be 1
    And the output should contain:
    """
    Error: Folder 'missingfolder' does not exist
    """

  Scenario: Do not overwrite existing file
    Given an empty file named "photos/d.jpeg"
    When I run `bulkrename photos jpeg jpg`
    Then the exit status should be 0
    And the following files should exist:
      | photos/d.jpeg |
    And the output should not contain:
    """
    Renaming photos/d.jpeg to photos/d.jpg
    Overwriting file 'photos/d.jpg'
    """

  Scenario: Provide option to overwrite existing file(s)
    Given an empty file named "photos/d.jpeg"
    When I run `bulkrename photos jpeg jpg --overwrite`
    Then the following files should exist:
      | photos/a.jpg |
      | photos/b.jpg |
      | photos/c.jpg |
      | photos/d.jpg |
    And the output should contain:
    """
    Overwriting file 'photos/d.jpg'
    """
    And the output should not contain:
    """
    Error: Cannot overwrite file 'photos/d.jpg'
    """


  # Need to change this to interactive mode when it finds the file
  Scenario: Provide option to decide whether to overwrite existing file(s)
    Given an empty file named "photos/d.jpeg"
    When I run `bulkrename photos jpeg jpg --askoverwrite` interactively
    And I type "yes"
    Then the following files should exist:
      | photos/a.jpg |
      | photos/b.jpg |
      | photos/c.jpg |
      | photos/d.jpg |
    And the output should contain:
    """
    Overwriting file 'photos/d.jpg'
    """
    And the output should not contain:
    """
    Error: Cannot overwrite file 'photos/d.jpg'
    """
