*** Settings ***
Documentation       Provision and Deploy CockroachDB Instance from Developer View
Metadata            Version    0.0.1

Library             SeleniumLibrary
Resource            ../resources/keywords/provision_dbinstance.resource

Suite Setup         Set Library Search Order    SeleniumLibrary
Suite Teardown      Tear Down The Test Suite
Test Setup          Given Setup The Test Case
Test Teardown       Tear Down The Test Case

Force Tags          UI    cockroach


*** Test Cases ***
Scenario: Provision CockroachDB Database Instance for Invalid Provider Account from Developers View
    [Tags]    RHODA-041    smoke
    When User Imports Invalid Cockroach Provider Account
    And User Navigates To Create Database Instance Screen On Developer View
    Then DBSC Instance Retrieval Failed On Dev View

Scenario: Provision CockroachDB Database Instance from Developers View
    [Tags]    RHODA-042    smoke
    When User Imports Valid Cockroach Provider Account
    And User Navigates To Create Database Instance Screen On Developer View
    And User Enters Data To Create Instance On Dev View
    Then Cockroach DBSC Instance Provisioned And Deployed On Developer Topology Graph View
