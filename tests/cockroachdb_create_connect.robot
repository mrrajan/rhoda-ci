*** Settings ***
Documentation       To Verify Provisioning of CockroachDB Provider Account and deployment of Database Instance
Metadata            Version    0.0.1

Library             SeleniumLibrary
Resource            ../resources/keywords/create_provider_account.resource

Suite Setup         Set Library Search Order    SeleniumLibrary
Suite Teardown      Tear Down The Test Suite
Test Setup          Given The Browser Is On Openshift Home Screen
Test Teardown       Close Browser


*** Test Cases ***
Scenario: Verify error message for invalid credentials on CockroachDB
    [Tags]    smoke
    When User Filters Project redhat-dbaas-operator On Project DropDown And Navigates To Database Access Page
    And User Navigates To Create Provider Account Screen From Database Access Page
    And User Enters Invalid Data To Create CockroachDB Provider Account
    Then Provider Account Creation Failure

Scenario: Create Cockroach Provider Account From Administrator View
    [Tags]    smoke
    When User Filters Project redhat-dbaas-operator On Project DropDown And Navigates To Database Access Page
    And User Navigates To Create Provider Account Screen From Database Access Page
    And User Enters Data To Create CockroachDB Provider Account
    Then Provider Account Creation Success
