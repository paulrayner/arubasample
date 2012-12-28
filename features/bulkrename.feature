@announce
Feature: Bulk Rename Command Line Utility
  In order to perform bulk renames of files
  As a newcomer to Cucumber
  I want to be able to rename multiple files in a folder by file extension

  Scenario: Rename files in specified folder by extension
    Given the following files in the "photos" folder:
    | a.jpeg |  
    | b.jpeg |  
    | c.jpeg |  
    When I run `bulkrename photos jpeg jpg`
    Then the following files should exist in the "photos" folder:
		| a.jpg |
		| b.jpg |
		| c.jpg |

  Scenario: Rename files in specified folder with extension to completely new file type
    Given the following files in the "textfiles" folder:
    | doc1.txt |  
    | doc2.txt |  
    | doc3.txt |  
    When I run `bulkrename textfiles txt md`
    Then the following files should exist in the "textfiles" folder:
    | doc1.md |
    | doc2.md |
    | doc3.md |

  Scenario: Rename files in specified folder by extension ignoring case
    Given the following files in the "textfiles" folder:
    | May-financials.txt  |  
    | June-financials.TXT |  
    | July-financials.TXT |  
    When I run `bulkrename textfiles txt csv`
    Then the following files should exist in the "textfiles" folder:
    | May-financials.csv  |  
    | June-financials.csv |  
    | July-financials.csv |  

  Scenario Outline: Parameters should be present and valid
    Given an empty file named "photos/doc1.txt"
    When I run `bulkrename <arguments>`
    Then the program should exit by displaying the error:
    """
    Error: <message>
    """

  Examples:
    | arguments                            | message                           |  
    | photos jpeg jpg --askoverwrite extra | Too many arguments                |  
    | documents txt md                     | Folder 'documents' does not exist |  
    | photos                               | <find extension> is required      |  
    | photos txt                           | <replace extension> is required   |  
    | photos txt md extra                  | Invalid option format 'extra'     |  
    | photos jpeg jpg --verbose            | Invalid option name '--verbose'   |  

  Scenario: Default script output is correct
    When I run `bulkrename`
    Then the correct usage message should be displayed:
    """
    USAGE: bulkrename <folder name> <find extension> <replace extension> [--askoverwrite]
    """

  Scenario: Do not overwrite existing file(s)
    Given the following files in the "photos" folder:
    | d.jpeg |  
    | d.jpg  |  
    When I run `bulkrename photos jpeg jpg`
    Then the following files should exist in the "photos" folder:
    | d.jpeg |  
    | d.jpg  |  

  Scenario: Choose to overwrite an existing file
    Given the following files in the "photos" folder:
    | d.jpeg |  
    | d.jpg  |  
    When I run `bulkrename photos jpeg jpg --askoverwrite` interactively
    And I type "yes"
    Then the following files should exist in the "photos" folder:
    | d.jpg |
    And the output should contain:
    """
    File 'photos/d.jpg' already exists, do you want to overwrite it (y/n)?
    """
    And the output should contain:
    """
    Overwriting file 'photos/d.jpg'
    """

  Scenario: Choose not to overwrite an existing file
    Given the following files in the "photos" folder:
    | d.jpeg |  
    | d.jpg  | 
    When I run `bulkrename photos jpeg jpg --askoverwrite` interactively
    And I type "no"
    Then the following files should exist in the "photos" folder:
    | d.jpeg |
    | d.jpg  |
    And the output should contain:
    """
    File 'photos/d.jpg' already exists, do you want to overwrite it (y/n)?
    """
    But the output should not contain:
    """
    Overwriting file 'photos/d.jpg'
    """

