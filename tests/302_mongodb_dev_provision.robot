*** Settings ***
Documentation       Provision and Deploy MongoDB Database Instance from Developer View
Metadata            Version    0.0.1

Resource            ../resources/keywords/provision_dbinstance.resource

Suite Setup         Set Library Search Order    SeleniumLibrary
Suite Teardown      Tear Down The Test Suite
Test Setup          Given Setup The Test Case
Test Teardown       Tear Down The Test Case

Force Tags          UI    mongo


*** Test Cases ***
Scenario: Provision MongoDB Database Instance for Invalid Provider Account from Developers View
    [Tags]    RHODA-013    smoke
    When User Imports Invalid MongoDB Provider Account
    And User Navigates To Create Database Instance Screen On Developer View
    Then DBSC Instance Retrieval Failed On Dev View

Scenario: Provision MongoDB Database Instance from Developers View
    [Tags]    RHODA-014    smoke
    When User Imports Valid MongoDB Provider Account
    And User Navigates To Create Database Instance Screen On Developer View
    And User Enters Data To Create Instance On Dev View
    Then MongoDB DBSC Instance Provisioned And Deployed On Developer Topology Graph View
