*** Settings ***
Documentation       Test suite used with generic test cases
Metadata            Version    0.0.1

Library             SeleniumLibrary
Resource            ../resources/keywords/deploy_application.resource

Suite Setup         Set Library Search Order    SeleniumLibrary
Suite Teardown      Tear Down The Test Suite
Test Setup          Given The Browser Is On Openshift Home Screen
Test Teardown       Close Browser


*** Test Cases ***
Scenario: Verify Error Message For Duplicate Provider Account Friendly Name
    [Tags]    smoke   RHOD-84-1
    When User Imports Valid CockroachDB Provider Account
    And User Navigates To Import Database Provider Account Screen From Database Access Page
    And User Enters Data To Import Duplicate CockroachDB Provider Account
    Then Duplicate Provider Account Name Error Message Appears
