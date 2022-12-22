*** Settings ***
Documentation       To Verify Provisioning of CockroachDB Provider Account and deployment of Database Instance
Metadata            Version    0.0.1

Library             SeleniumLibrary
Resource            ../resources/keywords/deploy_application.resource

Suite Setup         Set Library Search Order    SeleniumLibrary
Suite Teardown      Tear Down The Test Suite
Test Setup          Given Setup The Test Case
Test Teardown       Tear Down The Test Case

Force Tags          UI    cockroach


*** Test Cases ***
Scenario: Import CockroachDB Provider Account From Developer View
    [Tags]    RHODA-034    smoke
    When User Navigates To Add Topology Screen From Developer View    CockroachDB
    And User Navigates To Import Provider Account Screen From Developer View
    And User Enters Data To Import CockroachDB Provider Account
    Then Provider Account Import Success

Scenario: Verify error message for invalid credentials on CockroachDB
    [Tags]    RHODA-035    smoke
    When User Filters Project ${operatorNamespace} On Project DropDown And Navigates To Database Access Page
    And User Navigates To Import Database Provider Account Screen From Database Access Page
    And User Enters Invalid Data To Import CockroachDB Provider Account
    Then Provider Account Import Failure

Scenario: Import Cockroach Provider Account From Administrator View
    [Tags]    RHODA-036
    When User Filters Project ${operatorNamespace} On Project DropDown And Navigates To Database Access Page
    And User Navigates To Import Database Provider Account Screen From Database Access Page
    And User Enters Data To Import CockroachDB Provider Account
    Then Provider Account Import Success

Scenario: Deploy CockroachDB Database Instance
    [Tags]    RHODA-037
    Skip If    "${PREV_TEST_STATUS}" == "FAIL"
    When User Imports Valid CockroachDB Provider Account
    And User Navigates To Add CockroachDB To Topology Screen
    And User Selects Database Instance For The Provider Account
    Then DBSC Instance Deployed On Developer Topology Graph View

Scenario: Connect CockroachDB DBSC With An Openshift Application
    [Tags]    RHODA-038    smoke
    Skip If    "${PREV_TEST_STATUS}" == "FAIL"
    When User Deploys CockroachDB Database Instance On Developer Topology Screen
    And User Imports Openshift cockroach Application From YAML
    And User Creates Service Binding Between cockroach DBSC Instance And Imported Openshift Application
    Then The Application Accesses The Connected cockroach Database Instance
