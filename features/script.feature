Feature: Developing script using Thor
  In order to develop some kind of command line script using Thor
  As a newcomer to Aruba
  I want to have the command line script handle arguments correctly

  Scenario: Provide basic help information
    When I run `script --help`
    Then STDERR should be empty
