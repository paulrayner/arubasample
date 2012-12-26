Feature: Bulk Rename Command Line Utility
  In order to perform bulk renames of files
  As a newcomer to Cucumber
  I want to be able to rename multiple files in a folder by file extension

  Scenario: Rename files in specified folder by extension
    Given an empty file named "photos/a.jpeg"
    And an empty file named "photos/b.jpeg"
    And an empty file named "photos/c.jpeg"
    When I run `bulkrename photos jpeg jpg`
    Then the following files should exist:
		| photos/a.jpg |
		| photos/b.jpg |
		| photos/c.jpg |

  Scenario: Rename files in specified folder with extension to completely new file type
    Given an empty file named "textfiles/doc1.txt"
    And an empty file named "textfiles/doc2.txt"
    And an empty file named "textfiles/doc3.txt"
    When I run `bulkrename textfiles txt md`
    Then the following files should exist:
    | textfiles/doc1.md |
    | textfiles/doc2.md |
    | textfiles/doc3.md |

  Scenario: Rename files in specified folder by extension ignoring case
    Given an empty file named "textfiles/May-financials.txt"
    And an empty file named "textfiles/June-financials.TXT"
    And an empty file named "textfiles/July-financials.TXT"
    When I run `bulkrename textfiles txt csv`
    Then the following files should exist:
    | textfiles/May-financials.csv |
    | textfiles/June-financials.csv |
    | textfiles/July-financials.csv |

  @wip
  Scenario: Default script output is correct
    When I run `bulkrename`
    Then the exit status should be 0
    And the correct usage message should be displayed:
    """
    USAGE: bulkrename <folder name> <find extension> <replace extension>
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
