*** Settings ***
Documentation       To verify DBaaSPolicy
Metadata            Version    0.0.1

Library             SeleniumLibrary
Resource            ../resources/keywords/dbaas_policy.resource

Suite Setup         Configure DBaaS Policy Namespaces
Suite Teardown      Tear Down The Test Suite
Test Teardown       Tear Down DBaaSPolicy Test Case

Force Tags          UI    DBaaS-error


*** Test Cases ***
Scenario: Verify Invalid Namespace Error Message For Project Admin To Create DBaaS Policy on Admin View
    [Tags]    dbaas-test-01    smoke
    Given The User Logs In To Openshift As OCP_LDAP_PROJECT_ADM
    When User Filters Project ${DBaaSTestNS} On Project DropDown And Navigates To Database Access Page
    And User Navigates To Import Database Provider Account Screen From Database Access Page
    Then Import Provider Account Failure For DBaaS Policy

Scenario: Verify Invalid Namespace Error Message For Service Admin To Create DBaaS Policy on Admin View
    [Tags]    dbaas-test-02    smoke
    Given The User Logs In To Openshift As OCP_LDAP_SERVICE_ADM
    When User Filters Project ${DBaaSTestNS} On Project DropDown And Navigates To Database Access Page
    And User Navigates To Import Database Provider Account Screen From Database Access Page
    Then Import Provider Account Failure For DBaaS Policy

Scenario: Verify Invalid Namespace Error Message For Developer To Create DBaaS Policy on Admin View
    [Tags]    dbaas-test-03    smoke
    Given The User Logs In To Openshift As OCP_LDAP_DEV
    When User Filters Project ${DBaaSTestNS} On Project DropDown And Navigates To Database Access Page
    And User Navigates To Import Database Provider Account Screen From Database Access Page
    Then Import Provider Account Failure For DBaaS Policy

Scenario: Verify Invalid Namespace Error Message For Project Admin To Create DBaaS Policy on Dev View
    [Tags]    dbaas-test-04    smoke
    Given The User Logs In To Openshift As OCP_LDAP_PROJECT_ADM
    When User Navigates To Import MongoDB Provider Account On Developer View
    Then Import Provider Account Failure For DBaaS Policy

Scenario: Verify Invalid Namespace Error Message For Service Admin To Create DBaaS Policy on Dev View
    [Tags]    dbaas-test-05    smoke
    Given The User Logs In To Openshift As OCP_LDAP_SERVICE_ADM
    When User Navigates To Import MongoDB Provider Account On Developer View
    Then Import Provider Account Failure For DBaaS Policy

Scenario: Verify Invalid Namespace Error Message For Developer To Create DBaaS Policy on Dev View
    [Tags]    dbaas-test-06    smoke
    Given The User Logs In To Openshift As OCP_LDAP_DEV
    When User Navigates To Add Topology Screen From Developer View    MongoDB    ${DBaaSTestNS}    True
    Then Cloud Hosted Database Tile Not Loaded Under Add Topology Screen

Scenario: Verify The Maximum DBaaSPolicy Quota Error Message
    [Tags]    dbaas-test-33     smoke
    Given The User Logs In To Openshift As OCP_LDAP_PROJECT_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Admin View As OCP_LDAP_PROJECT_ADM
    And User Creates DBaaSPolicy For OCP_LDAP_PROJECT_ADM
    Then The Maximum Quota Exceeded Error Message Occurs
