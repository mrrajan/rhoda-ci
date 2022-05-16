*** Settings ***
Documentation       To Verify Provisioning of MongoDB Provider Account and deployment of Database Instance
Metadata            Version    0.0.1

Resource            ../resources/keywords/deploy_instance_dev.resource

Suite Setup         Set Library Search Order    SeleniumLibrary
Suite Teardown      Tear Down The Test Suite
Test Setup          Given The Browser Is On Openshift Home Screen
Test Teardown       Close Browser


*** Test Cases ***
Scenario: Verify error message for invalid credentials on MongoDB
    [Tags]    smoke    RHOD-49-1
    When User Filters Project redhat-dbaas-operator On Project DropDown And Navigates To Database Access Page
    And User Navigates To Create Provider Account Screen From Database Access Page
    And User Enters Invalid Data To Create MongoDB Provider Account
    Then Provider Account Creation Failure

Scenario: Create MongoDB Provider Account From Administrator View
    [Tags]    smoke    RHOD-46
    When User Filters Project redhat-dbaas-operator On Project DropDown And Navigates To Database Access Page
    And User Navigates To Create Provider Account Screen From Database Access Page
    And User Enters Data To Create MongoDB Provider Account
    Then Provider Account Creation Success

Scenario: Deploy MongoDB DBSC For MongoDB Provider Account
    [Tags]    smoke    RHOD-50
    Skip If    "${PREV_TEST_STATUS}" == "FAIL"
    When User Creates Valid MongoDB Provider Account
    And User Navigates To Connect MongoDB Atlas Cloud Database Service Screen On Developers View
    And User Selects Database Instance For The Provider Account
    Then DBSC Instance Deployed On Developer Topology Graph View
