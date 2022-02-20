@report @report_advancedgrading @report_advancedgrading_guide   @javascript
Feature: Confirm advancedgrading report displays grading for multiple submissions
    In order to view view advanced grades with marking guide
    Set blind marking, make an attempt and view report, make second submission and view report
    Reveal student names and view report

  Scenario: Convert rubric scores to grades.
    Given the following "users" exist:
        | username | firstname | lastname | email                |
        | teacher1 | Teacher   | 1        | teacher1@example.com |
        | student1 | Student   | 1        | student1@example.com |
    And the following "courses" exist:
        | fullname | shortname | format |
        | Course 1 | C1        | topics |
    And the following "course enrolments" exist:
        | user     | course | role           |
        | teacher1 | C1     | editingteacher |
        | student1 | C1     | student        |
    When I log in as "teacher1"
    And I am on "Course 1" course homepage with editing mode on

    And I add a "Assignment" to section "1" and I fill the form with:
        | Assignment name                     | Test assignment 1 name      |
        | Description                         | Test assignment description |
        | Grading method                      | Marking guide               |
        | assignsubmission_onlinetext_enabled | 1                           |
        | assignsubmission_file_enabled       | 0                           |
        | id_attemptreopenmethod              | Manual                      |
        | id_blindmarking                     | Yes                         |
    And I am on "Course 1" course homepage with editing mode on
    # Defining a marking guide
    When I go to "Test assignment 1 name" advanced grading definition page
    And I set the following fields to these values:
        | Name        | Assignment 1 marking guide     |
        | Description | Marking guide test description |
    And I define the following marking guide:
        | Criterion name    | Description for students         | Description for markers         | Maximum score |
        | Guide criterion A | Guide A description for students | Guide A description for markers | 30            |
        | Guide criterion B | Guide B description for students | Guide B description for markers | 30            |
        | Guide criterion C | Guide C description for students | Guide C description for markers | 40            |
    And I press "Save marking guide and make it ready"
    And I am on "Course 1" course homepage
    And I click on "Test assignment 1" "link"
    And I navigate to "Marking guide breakdown report" in current page administration

    And I should see "No marked submissions found"
    And I log out
    And I log in as "student1"
    And I am on "Course 1" course homepage
    And I click on "Test assignment 1 name" "link"
    And I click on "Add submission" "button"
    And I set the field "Online text" to "First response"
    And I click on "Save changes" "button"
    And I log out

    And I log in as "admin"
    And I am on "Course 1" course homepage with editing mode on
    And I go to "Student 1" "Test assignment 1" activity advanced grading page
    And I grade by filling the marking guide with:
        | Guide criterion A | 25 | Very good |
        | Guide criterion B | 20 |           |
        | Guide criterion C | 35 | Nice!     |
    And I press "Save changes"
    And I complete the advanced grading form with these values:
        | Feedback comments | In general... work harder... |
    And I am on "Course 1" course homepage
    And I click on "Test assignment 1" "link"
    And I navigate to "Marking guide breakdown report" in current page administration
    And I should not see "student1"
    And I should see "80.00"
    And I should see "35.00"

    And I go to "Student 1" "Test assignment 1" activity advanced grading page
    And I set the following fields to these values:
        | Allow another attempt | 1 |
    And I save the advanced grading form
    And I am on "Course 1" course homepage
    And I click on "Test assignment 1" "link"
    And I navigate to "Marking guide breakdown report" in current page administration
    And I should see "No marked submissions found"

    And I log out
    And I log in as "student1"
    And I am on "Course 1" course homepage
    And I click on "Test assignment 1 name" "link"

    And I click on "Add a new attempt" "button"
    And I set the field "Online text" to "Second response"
    And I click on "Save changes" "button"
    And I log out

    And I log in as "admin"
    And I am on "Course 1" course homepage with editing mode on

    And I go to "Student 1" "Test assignment 1" activity advanced grading page
    And I grade by filling the marking guide with:
        | Guide criterion A | 30 | Excellent    |
        | Guide criterion B | 30 | Awesome      |
        | Guide criterion C | 39 | Outstanding! |
    And I press "Save changes"
    And I complete the advanced grading form with these values:
        | Feedback comments | A great improvement on the first submission |

    And I am on "Course 1" course homepage
    And I click on "Test assignment 1" "link"
    And I navigate to "Marking guide breakdown report" in current page administration
    And I should see "99.00"
    And I should see "Awesome"
    And I am on "Course 1" course homepage
    And I follow "Test assignment 1"
    And I navigate to "View all submissions" in current page administration
    And I set the field "Grading action" to "Reveal student identities"
    And I press "Continue"
    And I am on "Course 1" course homepage
    And I click on "Test assignment 1" "link"
    And I navigate to "Marking guide breakdown report" in current page administration
    And I should see "student1"
    And I should see "Awesome"
