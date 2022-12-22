*** Settings ***
Documentation       To verify DBaaSPolicy
Metadata            Version    0.0.1

Library             SeleniumLibrary
Resource            ../resources/keywords/dbaas_policy.resource

Suite Setup         Configure DBaaS Policy Namespaces
Suite Teardown      Tear Down The Test Suite
Test Teardown       Tear Down DBaaSPolicy Test Case

Force Tags          UI    DBaaS


*** Test Cases ***
Scenario: Create DBaaSPolicy As Project Admin From Error screen on Admin View And Import MongoDB Provider Account
    [Tags]    dbaas-test-07
    Given The User Logs In To Openshift As OCP_LDAP_PROJECT_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Admin View As OCP_LDAP_PROJECT_ADM
    Then User Is Able To Import MongoDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Service Admin From Error screen on Admin View And Import MongoDB Provider Account
    [Tags]    dbaas-test-08
    Given The User Logs In To Openshift As OCP_LDAP_SERVICE_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Admin View As OCP_SERVICE_PROJECT_ADM
    Then User Is Able To Import MongoDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Developer From Error screen on Admin View
    [Tags]    dbaas-test-09
    Given The User Logs In To Openshift As OCP_LDAP_DEV
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Admin View As OCP_LDAP_DEV
    Then DBaaSPolicy Creation Forbidden

Scenario: Create DBaaSPolicy As Project Admin From Error screen on Admin View And Import CrunchyDB Provider Account
    [Tags]    dbaas-test-10
    Given The User Logs In To Openshift As OCP_LDAP_PROJECT_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Admin View As OCP_LDAP_PROJECT_ADM
    Then User Is Able To Import CrunchyDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Service Admin From Error screen on Admin View And Import CrunchyDB Provider Account
    [Tags]    dbaas-test-11
    Given The User Logs In To Openshift As OCP_LDAP_SERVICE_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Admin View As OCP_SERVICE_PROJECT_ADM
    Then User Is Able To Import CrunchyDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Project Admin From Error screen on Admin View And Import CockroachDB Provider Account
    [Tags]    dbaas-test-12
    Given The User Logs In To Openshift As OCP_LDAP_PROJECT_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Admin View As OCP_LDAP_PROJECT_ADM
    Then User Is Able To Import CockroachDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Service Admin From Error screen on Admin View And Import CockroachDB Provider Account
    [Tags]    dbaas-test-13
    Given The User Logs In To Openshift As OCP_LDAP_SERVICE_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Admin View As OCP_SERVICE_PROJECT_ADM
    Then User Is Able To Import CockroachDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Project Admin From Error screen on Admin View And Import RDS Provider Account
    [Tags]    dbaas-test-14
    Given The User Logs In To Openshift As OCP_LDAP_PROJECT_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Admin View As OCP_LDAP_PROJECT_ADM
    Then User Is Able To Import RDS Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Service Admin From Error screen on Admin View And Import RDS Provider Account
    [Tags]    dbaas-test-15
    Given The User Logs In To Openshift As OCP_LDAP_SERVICE_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Admin View As OCP_SERVICE_PROJECT_ADM
    Then User Is Able To Import RDS Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Project Admin From Admin view And Import MongoDB Provider Account
    [Tags]    dbaas-test-16    smoke
    Given The User Logs In To Openshift As OCP_LDAP_PROJECT_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Admin View As OCP_LDAP_PROJECT_ADM
    Then User Is Able To Import MongoDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Service Admin From Admin View And Import MongoDB Provider Account
    [Tags]    dbaas-test-17    smoke
    Given The User Logs In To Openshift As OCP_LDAP_SERVICE_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Admin View As OCP_SERVICE_PROJECT_ADM
    Then User Is Able To Import MongoDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Developer From Admin View
    [Tags]    dbaas-test-18    smoke
    Given The User Logs In To Openshift As OCP_LDAP_DEV
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Admin View As OCP_LDAP_DEV
    Then DBaaSPolicy Creation Forbidden

Scenario: Create DBaaSPolicy As Project Admin From Admin View And Import CrunchyDB Provider Account
    [Tags]    dbaas-test-19    smoke
    Given The User Logs In To Openshift As OCP_LDAP_PROJECT_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Admin View As OCP_LDAP_PROJECT_ADM
    Then User Is Able To Import CrunchyDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Service Admin From Admin View And Import CrunchyDB Provider Account
    [Tags]    dbaas-test-20    smoke
    Given The User Logs In To Openshift As OCP_LDAP_SERVICE_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Admin View As OCP_SERVICE_PROJECT_ADM
    Then User Is Able To Import CrunchyDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Project Admin From Admin View And Import CockroachDB Provider Account
    [Tags]    dbaas-test-21    smoke
    Given The User Logs In To Openshift As OCP_LDAP_PROJECT_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Admin View As OCP_LDAP_PROJECT_ADM
    Then User Is Able To Import CockroachDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Service Admin From Admin View And Import CockroachDB Provider Account
    [Tags]    dbaas-test-22    smoke
    Given The User Logs In To Openshift As OCP_LDAP_SERVICE_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Admin View As OCP_SERVICE_PROJECT_ADM
    Then User Is Able To Import CockroachDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Project Admin From Admin View And Import RDS Provider Account
    [Tags]    dbaas-test-23    smoke
    Given The User Logs In To Openshift As OCP_LDAP_PROJECT_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Admin View As OCP_LDAP_PROJECT_ADM
    Then User Is Able To Import RDS Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Service Admin From Admin View And Import RDS Provider Account
    [Tags]    dbaas-test-24    smoke
    Given The User Logs In To Openshift As OCP_LDAP_SERVICE_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Admin View As OCP_SERVICE_PROJECT_ADM
    Then User Is Able To Import RDS Provider Account For ${DBaaSTestNS}
