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
Scenario: Create DBaaSPolicy As Project Admin From Error screen on Dev View And Import MongoDB Provider Account
    [Tags]    dbaas-test-25
    Given The User Logs In To Openshift As OCP_LDAP_PROJECT_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Dev View As OCP_LDAP_PROJECT_ADM
    Then User Is Able To Import MongoDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Service Admin From Error screen on Dev View And Import MongoDB Provider Account
    [Tags]    dbaas-test-26
    Given The User Logs In To Openshift As OCP_LDAP_SERVICE_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Dev View As OCP_SERVICE_PROJECT_ADM
    Then User Is Able To Import MongoDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Project Admin From Error screen on Dev View And Import CrunchyDB Provider Account
    [Tags]    dbaas-test-27
    Given The User Logs In To Openshift As OCP_LDAP_PROJECT_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Dev View As OCP_LDAP_PROJECT_ADM
    Then User Is Able To Import CrunchyDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Service Admin From Error screen on Dev View And Import CrunchyDB Provider Account
    [Tags]    dbaas-test-28
    Given The User Logs In To Openshift As OCP_LDAP_SERVICE_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Dev View As OCP_SERVICE_PROJECT_ADM
    Then User Is Able To Import CrunchyDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Project Admin From Error screen on Dev View And Import CockroachDB Provider Account
    [Tags]    dbaas-test-29
    Given The User Logs In To Openshift As OCP_LDAP_PROJECT_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Dev View As OCP_LDAP_PROJECT_ADM
    Then User Is Able To Import CockroachDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Service Admin From Error screen on Dev View And Import CockroachDB Provider Account
    [Tags]    dbaas-test-30
    Given The User Logs In To Openshift As OCP_LDAP_SERVICE_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Dev View As OCP_SERVICE_PROJECT_ADM
    Then User Is Able To Import CockroachDB Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Project Admin From Error screen on Dev View And Import RDS Provider Account
    [Tags]    dbaas-test-31
    Given The User Logs In To Openshift As OCP_LDAP_PROJECT_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Dev View As OCP_LDAP_PROJECT_ADM
    Then User Is Able To Import RDS Provider Account For ${DBaaSTestNS}

Scenario: Create DBaaSPolicy As Service Admin From Error screen on Dev View And Import RDS Provider Account
    [Tags]    dbaas-test-32
    Given The User Logs In To Openshift As OCP_LDAP_SERVICE_ADM
    When User Creates DBaaSPolicy For ${DBaaSTestNS} From Invalid Namespace Alert on Dev View As OCP_SERVICE_PROJECT_ADM
    Then User Is Able To Import RDS Provider Account For ${DBaaSTestNS}
