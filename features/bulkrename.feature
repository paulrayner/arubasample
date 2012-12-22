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

  @wip
  Scenario: Default script output is correct
    When I run `bulkrename`
    Then the exit status should be 0
    And the correct usage message should be displayed:
    """
    USAGE: bulkrename <folder name> <find_extension> <replace_extension>
    """


  Scenario: Do not overwrite existing file(s)
    Given an empty file named "photos/d.jpeg"
    And an empty file named "photos/d.jpg"
    When I run `bulkrename photos jpeg jpg`
    Then the following files should exist:
      | photos/d.jpeg |
      | photos/d.jpg  |

  Scenario: Choose to overwrite an existing file
    Given an empty file named "photos/d.jpeg"
      And an empty file named "photos/d.jpg"
      When I run `bulkrename photos jpeg jpg --askoverwrite` interactively
      And I type "yes"
      Then the following files should exist:
        | photos/d.jpg |
      And the output should contain:
      """
      File 'photos/d.jpg' already exists, do you want to overwrite it (y/n)?
      """
      And the output should contain:
      """
      Overwriting file 'photos/d.jpg'
      """

  Scenario: Choose not to overwrite an existing file
    Given an empty file named "photos/d.jpeg"
    And an empty file named "photos/d.jpg"
    When I run `bulkrename photos jpeg jpg --askoverwrite` interactively
    And I type "no"
    Then the following files should exist:
      | photos/d.jpeg |
      | photos/d.jpg  |
    And the output should contain:
    """
    File 'photos/d.jpg' already exists, do you want to overwrite it (y/n)?
    """
    But the output should not contain:
    """
    Overwriting file 'photos/d.jpg'
    """
