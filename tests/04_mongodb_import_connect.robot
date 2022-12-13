*** Settings ***
Documentation       To Verify Importing of MongoDB Provider Account and deployment of Database Instance
Metadata            Version    0.0.1

Resource            ../resources/keywords/deploy_application.resource

Suite Setup         Set Library Search Order    SeleniumLibrary
Suite Teardown      Tear Down The Test Suite
Test Setup          Given Setup The Test Case
Test Teardown       Tear Down The Test Case

Force Tags          UI    mongo


*** Test Cases ***
Scenario: Import MongoDB Provider Account From Developer View
    [Tags]    RHODA-006    smoke
    When User Navigates To Add Topology Screen From Developer View    MongoDB
    And User Navigates To Import Provider Account Screen From Developer View
    And User Enters Data To Import MongoDB Provider Account
    Then Provider Account Import Success

Scenario: Verify error message for invalid credentials on MongoDB
    [Tags]    RHODA-007    smoke
    When User Filters Project ${operatorNamespace} On Project DropDown And Navigates To Database Access Page
    And User Navigates To Import Database Provider Account Screen From Database Access Page
    And User Enters Invalid Data To Import MongoDB Database Provider Account
    Then Provider Account Import Failure

Scenario: Import MongoDB Provider Account From Administrator View
    [Tags]    RHODA-008
    When User Filters Project ${operatorNamespace} On Project DropDown And Navigates To Database Access Page
    And User Navigates To Import Database Provider Account Screen From Database Access Page
    And User Enters Data To Import MongoDB Provider Account
    Then Provider Account Import Success

Scenario: Deploy MongoDB DBSC For MongoDB Provider Account
    [Tags]    RHODA-009
    Skip If    "${PREV_TEST_STATUS}" == "FAIL"
    When User Imports Valid MongoDB Provider Account
    And User Navigates To Add MongoDB To Topology Screen
    And User Selects Database Instance For The Provider Account
    Then DBSC Instance Deployed On Developer Topology Graph View

Scenario: Connect MongoDB DBSC With An Openshift Application
    [Tags]    RHODA-0010    smoke
    Skip If    "${PREV_TEST_STATUS}" == "FAIL"
    When User Deploys MongoDB Database Instance On Developer Topology Screen
    And User Imports Openshift mongo Application From YAML
    And User Creates Service Binding Between mongo DBSC Instance And Imported Openshift Application
    Then The Application Accesses The Connected Mongo Database Instance
