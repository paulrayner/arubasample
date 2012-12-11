Feature: Developing script using Thor
  In order to develop some kind of command line script using Thor
  As a newcomer to Aruba
  I want to have the command line script handle arguments correctly

  Background:
  	Given a directory named "foo/bar"
  	And I cd to "foo/bar"

  Scenario: Test changing into a directory
  	When I run `pwd`
    Then the output should match /\057foo\057bar$/
  	And the exit status should be 0

  Scenario: Provide basic help information
#   When I run `script --help`
#   Then the stdout should contain "foo/bar: directory"
#
    Given a file named "foo/bar/example.txt" with:
      """
      hello world
      """
    When I run `cat foo/bar/example.txt`
    Then the output should contain exactly "hello world"


  Scenario: create a dir
    Given a directory named "foo/bar"
    When I run `file foo/bar`
    Then the stdout should contain "foo/bar: directory"
  
  Scenario: create a file
    Given a file named "foo/bar/example.txt" with:
      """
      hello world
      """
    When I run `cat foo/bar/example.txt`
    Then the output should contain exactly "hello world"

  Scenario: create a fixed sized file
    Given a 1048576 byte file named "test.txt"
    Then a 1048576 byte file named "test.txt" should exist

  Scenario: Append to a file
    \### We like appending to files:
    1. Disk space is cheap
    1. It's completely safe

    \### Here is a list:
    - One
    - Two

    Given a file named "foo/bar/example.txt" with:
      """
      hello world
      
      """
    When I append to "foo/bar/example.txt" with:
      """
      this was appended
      
      """
    When I run `cat foo/bar/example.txt`
    Then the stdout should contain "hello world"
    And the stdout should contain "this was appended"

  Scenario: Append to a new file
    When I append to "thedir/thefile" with "x"
    And I append to "thedir/thefile" with "y"
    Then the file "thedir/thefile" should contain "xy"

  Scenario: clean up files generated in previous scenario
    Then the file "foo/bar/example.txt" should not exist
  
  Scenario: change to a subdir
    Given a file named "foo/bar/example.txt" with:
      """
      hello world
      
      """
    When I cd to "foo/bar"
    And I run `cat example.txt`
    Then the output should contain "hello world"

  Scenario: Reset current directory from previous scenario
    When I run `pwd`
    Then the output should match /\057tmp\057aruba$/

  Scenario: Holler if cd to bad dir
    When I do aruba I cd to "foo/nonexistant"
    Then aruba should fail with "tmp/aruba/foo/nonexistant is not a directory"

  Scenario: Check for presence of a subset of files
    Given an empty file named "lorem/ipsum/dolor"
    Given an empty file named "lorem/ipsum/sit"
    Given an empty file named "lorem/ipsum/amet"
    Then the following files should exist:
      | lorem/ipsum/dolor |
      | lorem/ipsum/amet  |

  Scenario: Check for absence of files
    Then the following files should not exist:
      | lorem/ipsum/dolor |

  Scenario: Check for presence of a single file
    Given an empty file named "lorem/ipsum/dolor"
    Then a file named "lorem/ipsum/dolor" should exist

  Scenario: Check for absence of a single file
    Then a file named "lorem/ipsum/dolor" should not exist

  Scenario: Check for presence of a subset of directories
    Given a directory named "foo/bar"
    Given a directory named "foo/bla"
    Then the following directories should exist:
      | foo/bar |
      | foo/bla |

  Scenario: check for absence of directories
    Given a directory named "foo/bar"
    Given a directory named "foo/bla"
    Then the following step should fail with Spec::Expectations::ExpectationNotMetError:
    """
    Then the following directories should not exist:
      | foo/bar/ |
      | foo/bla/ |
    """

  Scenario: Check for presence of a single directory
    Given a directory named "foo/bar"
    Then a directory named "foo/bar" should exist

  Scenario: Check for absence of a single directory
    Given a directory named "foo/bar"
    Then the following step should fail with Spec::Expectations::ExpectationNotMetError:
      """
      Then a directory named "foo/bar" should not exist
      """

  Scenario: Check file contents
    Given a file named "foo" with:
      """
      hello world
      """
    Then the file "foo" should contain "hello world"
    And the file "foo" should not contain "HELLO WORLD"

  Scenario: Check file contents with regexp
    Given a file named "foo" with:
      """
      hello world
      """
    Then the file "foo" should match /hel.o world/
    And the file "foo" should not match /HELLO WORLD/

  Scenario: Check file contents with docstring
    Given a file named "foo" with:
      """
      foo
      bar
      baz
      foobar
      """
    Then the file "foo" should contain:
      """
      bar
      baz
      """

  Scenario: Remove file
    Given a file named "foo" with:
      """
      hello world
      """
    When I remove the file "foo"
    Then the file "foo" should not exist

  Scenario: exit status of 0
    When I run `true`
    Then the exit status should be 0

  Scenario: non-zero exit status
    When I run `false`
    Then the exit status should be 1
    And the exit status should not be 0

  Scenario: Successfully run something
    When I successfully run `true`

  Scenario: Successfully run something for a long time
    Given The default aruba timeout is 0 seconds
    When I successfully run `sleep 1` for up to 2 seconds

  Scenario: Unsuccessfully run something that takes too long
    Given The default aruba timeout is 0 seconds
    When I do aruba I successfully run `sleep 1`
    Then aruba should fail with "process still alive after 0 seconds"

  Scenario: Unsuccessfully run something
    When I do aruba I successfully run `false`
    Then aruba should fail with ""
