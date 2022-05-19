*** Settings ***
Documentation       To Verify Database Instance Provisioning From Administrator View
Metadata            Version    0.0.1

Library             SeleniumLibrary
Resource            ../resources/keywords/provision_dbinstance.resource

Suite Setup         Set Library Search Order    SeleniumLibrary
Suite Teardown      Tear Down The Test Suite
Test Setup          Given The Browser Is On Openshift Home Screen
Test Teardown       Close Browser


*** Test Cases ***
Scenario: Provision CrunchyDB Database Instance for Invalid Provider Account
    [Tags]    smoke    RHOD-57-1
    When User Imports Invalid CrunchyDB Provider Account
    And User Navigates To Create Database Instance Screen From Database Access Page
    And User Selects DBProvider And Provider Account
    Then DBSC Instance Retrieval Failed

Scenario: Provision CrunchyDB Database Instance from Administrator View
    [Tags]    smoke    RHOD-57
    When User Imports Valid CrunchyDB Provider Account
    And User Navigates To Create Database Instance Screen From Database Access Page
    And User Enters Data To Create CrunchyDB Database Instance On Admin View
    Then DBSC Instance Provisioned And Deployed On Developer Topology Graph View
