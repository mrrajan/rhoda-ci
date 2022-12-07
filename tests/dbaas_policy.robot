*** Settings ***
Documentation       To verify DBaaSPolicy
Metadata            Version    0.0.1

Library             SeleniumLibrary
Resource            ../resources/keywords/dbaas_policy.resource

Suite Setup         Configure DBaaS Policy Namespaces
Suite Teardown      Tear Down The Test Suite
Test Teardown       Tear Down DBaaSPolicy Test Case
Force Tags          UI  DBaaS

*** Test Cases ***
Scenario: Verify Invalid Namespace Error Message For Project Admin To Create DBaaS Policy on Admin View
    [Tags]  dbaas-test-01
    Given The User Logs In To Openshift As OCP_LDAP_PROJECT_ADM
    When User Filters Project ${DBaaSTestNS} On Project DropDown And Navigates To Database Access Page
    And User Navigates To Import Database Provider Account Screen From Database Access Page
    Then Import Provider Account Failure For DBaaS Policy

Scenario: Verify Invalid Namespace Error Message For Service Admin To Create DBaaS Policy on Admin View
    [Tags]  dbaas-test-02
    Given The User Logs In To Openshift As OCP_LDAP_SERVICE_ADM
    When User Filters Project ${DBaaSTestNS} On Project DropDown And Navigates To Database Access Page
    And User Navigates To Import Database Provider Account Screen From Database Access Page
    Then Import Provider Account Failure For DBaaS Policy

Scenario: Verify Invalid Namespace Error Message For Developer To Create DBaaS Policy on Admin View
    [Tags]  dbaas-test-03
    Given The User Logs In To Openshift As OCP_LDAP_DEV
    When User Filters Project ${DBaaSTestNS} On Project DropDown And Navigates To Database Access Page
    And User Navigates To Import Database Provider Account Screen From Database Access Page
    Then Import Provider Account Failure For DBaaS Policy

Scenario: Verify Invalid Namespace Error Message For Project Admin To Create DBaaS Policy on Dev View
    [Tags]  dbaas-test-04
    Given The User Logs In To Openshift As OCP_LDAP_PROJECT_ADM
    When User Navigates To Import MongoDB Provider Account On Developer View
    Then Import Provider Account Failure For DBaaS Policy

Scenario: Verify Invalid Namespace Error Message For Service Admin To Create DBaaS Policy on Dev View
    [Tags]  dbaas-test-05
    Given The User Logs In To Openshift As OCP_LDAP_SERVICE_ADM
    When User Navigates To Import MongoDB Provider Account On Developer View
    Then Import Provider Account Failure For DBaaS Policy

Scenario: Verify Invalid Namespace Error Message For Developer To Create DBaaS Policy on Dev View
    [Tags]  dbaas-test-06
    Given The User Logs In To Openshift As OCP_LDAP_DEV
    When User Navigates To Add Topology Screen From Developer View      MongoDB     ${DBaaSTestNS}     True
    Then Cloud Hosted Database Tile Not Loaded Under Add Topology Screen

Scenario: Create DBaaSPolicy As Project Admin From Error screen on Admin View And Import MongoDB
    [Tags]  dbaas-test-07
    Given The User Logs In To Openshift As OCP_LDAP_PROJECT_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Admin View As OCP_LDAP_PROJECT_ADM
    Then User Is Able To Import MongoDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Service Admin From Error screen on Admin View And Import MongoDB
    [Tags]  dbaas-test-08
    Given The User Logs In To Openshift As OCP_LDAP_SERVICE_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Admin View As OCP_SERVICE_PROJECT_ADM
    Then User Is Able To Import MongoDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Developer From Error screen on Admin View
    [Tags]  dbaas-test-09
    Given The User Logs In To Openshift As OCP_LDAP_DEV
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Admin View As OCP_LDAP_DEV
    Then DBaaSPolicy Creation Forbidden

Scenario: Create DBaaSPolicy As Project Admin From Error screen on Admin View And Import CrunchyDB
    [Tags]  dbaas-test-10
    Given The User Logs In To Openshift As OCP_LDAP_PROJECT_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Admin View As OCP_LDAP_PROJECT_ADM
    Then User Is Able To Import CrunchyDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Service Admin From Error screen on Admin View And Import CrunchyDB
    [Tags]  dbaas-test-11
    Given The User Logs In To Openshift As OCP_LDAP_SERVICE_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Admin View As OCP_SERVICE_PROJECT_ADM
    Then User Is Able To Import CrunchyDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Project Admin From Error screen on Admin View And Import CockroachDB
    [Tags]  dbaas-test-12
    Given The User Logs In To Openshift As OCP_LDAP_PROJECT_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Admin View As OCP_LDAP_PROJECT_ADM
    Then User Is Able To Import CockroachDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Service Admin From Error screen on Admin View And Import CockroachDB
    [Tags]  dbaas-test-13
    Given The User Logs In To Openshift As OCP_LDAP_SERVICE_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Admin View As OCP_SERVICE_PROJECT_ADM
    Then User Is Able To Import CockroachDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Project Admin From Error screen on Admin View And Import RDS
    [Tags]  dbaas-test-14
    Given The User Logs In To Openshift As OCP_LDAP_PROJECT_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Admin View As OCP_LDAP_PROJECT_ADM
    Then User Is Able To Import RDS Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Service Admin From Error screen on Admin View And Import RDS
    [Tags]  dbaas-test-15
    Given The User Logs In To Openshift As OCP_LDAP_SERVICE_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Admin View As OCP_SERVICE_PROJECT_ADM
    Then User Is Able To Import RDS Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Project Admin From Admin view And Import MongoDB
    [Tags]  dbaas-test-16
    Given The User Logs In To Openshift As OCP_LDAP_PROJECT_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Admin View As OCP_LDAP_PROJECT_ADM
    Then User Is Able To Import MongoDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Service Admin From Admin View And Import MongoDB
    [Tags]  dbaas-test-17
    Given The User Logs In To Openshift As OCP_LDAP_SERVICE_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Admin View As OCP_SERVICE_PROJECT_ADM
    Then User Is Able To Import MongoDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Developer From Admin View
    [Tags]  dbaas-test-18
    Given The User Logs In To Openshift As OCP_LDAP_DEV
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Admin View As OCP_LDAP_DEV
    Then DBaaSPolicy Creation Forbidden

Scenario: Create DBaaSPolicy As Project Admin From Admin View And Import CrunchyDB
    [Tags]  dbaas-test-19
    Given The User Logs In To Openshift As OCP_LDAP_PROJECT_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Admin View As OCP_LDAP_PROJECT_ADM
    Then User Is Able To Import CrunchyDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Service Admin From Admin View And Import CrunchyDB
    [Tags]  dbaas-test-20
    Given The User Logs In To Openshift As OCP_LDAP_SERVICE_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Admin View As OCP_SERVICE_PROJECT_ADM
    Then User Is Able To Import CrunchyDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Project Admin From Admin View And Import CockroachDB
    [Tags]  dbaas-test-21
    Given The User Logs In To Openshift As OCP_LDAP_PROJECT_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Admin View As OCP_LDAP_PROJECT_ADM
    Then User Is Able To Import CockroachDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Service Admin From Admin View And Import CockroachDB
    [Tags]  dbaas-test-22
    Given The User Logs In To Openshift As OCP_LDAP_SERVICE_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Admin View As OCP_SERVICE_PROJECT_ADM
    Then User Is Able To Import CockroachDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Project Admin From Admin View And Import RDS
    [Tags]  dbaas-test-23
    Given The User Logs In To Openshift As OCP_LDAP_PROJECT_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Admin View As OCP_LDAP_PROJECT_ADM
    Then User Is Able To Import RDS Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Service Admin From Admin View And Import RDS
    [Tags]  dbaas-test-24
    Given The User Logs In To Openshift As OCP_LDAP_SERVICE_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Admin View As OCP_SERVICE_PROJECT_ADM
    Then User Is Able To Import RDS Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Project Admin From Error screen on Dev View And Import MongoDB
    [Tags]  dbaas-test-25
    Given The User Logs In To Openshift As OCP_LDAP_PROJECT_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Dev View As OCP_LDAP_PROJECT_ADM
    Then User Is Able To Import MongoDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Service Admin From Error screen on Dev View And Import MongoDB
    [Tags]  dbaas-test-26
    Given The User Logs In To Openshift As OCP_LDAP_SERVICE_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Dev View As OCP_SERVICE_PROJECT_ADM
    Then User Is Able To Import MongoDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Project Admin From Error screen on Dev View And Import CrunchyDB
    [Tags]  dbaas-test-27
    Given The User Logs In To Openshift As OCP_LDAP_PROJECT_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Dev View As OCP_LDAP_PROJECT_ADM
    Then User Is Able To Import CrunchyDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Service Admin From Error screen on Dev View And Import CrunchyDB
    [Tags]  dbaas-test-28
    Given The User Logs In To Openshift As OCP_LDAP_SERVICE_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Dev View As OCP_SERVICE_PROJECT_ADM
    Then User Is Able To Import CrunchyDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Project Admin From Error screen on Dev View And Import CockroachDB
    [Tags]  dbaas-test-29
    Given The User Logs In To Openshift As OCP_LDAP_PROJECT_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Dev View As OCP_LDAP_PROJECT_ADM
    Then User Is Able To Import CockroachDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Service Admin From Error screen on Dev View And Import CockroachDB
    [Tags]  dbaas-test-30
    Given The User Logs In To Openshift As OCP_LDAP_SERVICE_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Dev View As OCP_SERVICE_PROJECT_ADM
    Then User Is Able To Import CockroachDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Project Admin From Error screen on Dev View And Import RDS
    [Tags]  dbaas-test-31
    Given The User Logs In To Openshift As OCP_LDAP_PROJECT_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Dev View As OCP_LDAP_PROJECT_ADM
    Then User Is Able To Import RDS Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Service Admin From Error screen on Dev View And Import RDS
    [Tags]  dbaas-test-32
    Given The User Logs In To Openshift As OCP_LDAP_SERVICE_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Dev View As OCP_SERVICE_PROJECT_ADM
    Then User Is Able To Import RDS Provider Account For ${DBaaSTestNS}
