Feature: Configure/build freestyle jobs
  In order to get some basic usage out of freestyle jobs
  As a user
  I want to configure and run a series of different freestyle-based jobs

  Scenario: Create a simple job
    When I create a job named "MAGICJOB"
    And I visit the home page
    Then the page should say "MAGICJOB"

  Scenario: Run a simple job
    Given a job
    When I configure the job
    And I add a script build step to run "ls"
    And I save the job
    And I run the job
    Then I should see console output matching "+ ls"

  Scenario: Disable a job
    Given a job
    When I configure the job
    And I click the "disable" checkbox
    And I save the job
    And I visit the job page
    Then the page should say "This project is currently disabled"

  Scenario: Enable concurrent builds
    Given a job
    When I configure the job
    And I enable concurrent builds
    And I add a script build step to run "sleep 20"
    And I save the job
    And I build 2 jobs
    Then the 2 jobs should run concurrently

  Scenario: Create a parameterized job
    Given a job
    When I configure the job
    And I add a string parameter "Foo"
    And I run the job
    Then I should be prompted to enter the "Foo" parameter

  Scenario: Configure a job with Ant build steps
    Given a job
    When I configure the job
    And I add an Ant build step for:
      """
        <project default="hello">
          <target name="hello">
            <echo message="Hello World"/>
          </target>
        </project>
      """
    When I run the job
    Then the build should succeed

  Scenario: Disable a job
    Given a job
    When I disable the job
    Then it should be disabled
    And it should have an "Enable" button on the job page

# vim: tabstop=2 expandtab shiftwidth=2
