*** Settings ***
Documentation       To verify DBaaSPolicy ConncetionNamespaces
Metadata            Version    0.0.1

Library             SeleniumLibrary
Resource            ../resources/keywords/dbaas_policy.resource

Suite Setup         Configure DBaaS Policy Namespaces

Suite Teardown      Tear Down The Test Suite
Test Teardown       Tear Down DBaaSPolicy Test Case

Force Tags          UI    DBaaS


*** Test Cases ***
Scenario: DBaaSInventories On Source Namespace Is Not Available Without ConnectionNamespace And With Role Permission
    [Tags]    dbaas-test-34    smoke
    Given User Creates DBaaSPolicy As OCP_LDAP_PROJECT_ADM Without ConnectionNamespace And Imports MongoDB Provider Account
    When User Creates ${connectionNs} And Aligns admin Role To The OCP_DBAAS_USER
    And User Aligns admin Role To ${DBaaSTestNS} For OCP_DBAAS_USER
    Then DBaaSInventory Is Not Available For ${connectionNs}

Scenario: DBaaSInventories On Source Namespace Is Not Available To ConnectionNamespace And Without RBAC Permission
    [Tags]    dbaas-test-35    smoke
    Given User Creates DBaaSPolicy As OCP_LDAP_PROJECT_ADM With ConnectionNamespace And Imports MongoDB Provider Account
    When User Creates ${connectionNs} And Aligns admin Role To The OCP_DBAAS_USER
    Then The Namespace ${DBaaSTestNS} Is Not Available On The Project Dropdown

Scenario: DBaaSInventories On Source Namespace Available To ConnectionNamespaces Accessed By Same User As Project Admin
    [Tags]    dbaas-test-36    smoke
    Given User Creates DBaaSPolicy As OCP_LDAP_PROJECT_ADM With ConnectionNamespace And Imports MongoDB Provider Account
    When User Creates ${connectionNs} And Aligns admin Role To The OCP_LDAP_PROJECT_ADM
    Then DBaaSInventory Is Available For ${connectionNS}

Scenario: DBaaSInventories On Source Namespace Available To ConnectionNamespaces Accessed By Same User As Service Admin
    [Tags]    dbaas-test-37    smoke
    Given User Creates DBaaSPolicy As OCP_LDAP_PROJECT_ADM With ConnectionNamespace And Imports MongoDB Provider Account
    When User Creates ${connectionNs} And Aligns edit Role To The OCP_LDAP_PROJECT_ADM
    Then DBaaSInventory Is Available For ${connectionNS}

Scenario: DBaaSInventories On Source Namespace Available To ConnectionNamespaces Accessed By Another User As Project Admin For Both Namespaces
    [Tags]    dbaas-test-38    smoke
    Given User Creates DBaaSPolicy As OCP_LDAP_PROJECT_ADM With ConnectionNamespace And Imports MongoDB Provider Account
    When User Creates ${connectionNs} And Aligns admin Role To The OCP_DBAAS_USER
    And User Aligns admin Role To ${DBaaSTestNS} For OCP_DBAAS_USER
    Then DBaaSInventory Is Available For ${connectionNS}

Scenario: DBaaSInventories Available To ConnectionNamespaces Accessed By Another User Being Service Admin For Source and Project Admin For Target Namespace
    [Tags]    dbaas-test-39    smoke
    Given User Creates DBaaSPolicy As OCP_LDAP_PROJECT_ADM With ConnectionNamespace And Imports MongoDB Provider Account
    When User Creates ${connectionNs} And Aligns admin Role To The OCP_DBAAS_USER
    And User Aligns edit Role To ${DBaaSTestNS} For OCP_DBAAS_USER
    Then DBaaSInventory Is Available For ${connectionNS}

Scenario: DBaaSInventories Available To ConnectionNamespaces Accessed By Another User Being Project Admin For Source and Service Admin For Target Namespace
    [Tags]    dbaas-test-40    smoke
    Given User Creates DBaaSPolicy As OCP_LDAP_PROJECT_ADM With ConnectionNamespace And Imports MongoDB Provider Account
    When User Creates ${connectionNs} And Aligns edit Role To The OCP_DBAAS_USER
    And User Aligns admin Role To ${DBaaSTestNS} For OCP_DBAAS_USER
    Then DBaaSInventory Is Available For ${connectionNS}

Scenario: DBaaSInventories On Source Namespace Available To ConnectionNamespaces Accessed By Another User As Service Admin For Both Namespaces
    [Tags]    dbaas-test-41    smoke
    Given User Creates DBaaSPolicy As OCP_LDAP_PROJECT_ADM With ConnectionNamespace And Imports MongoDB Provider Account
    When User Creates ${connectionNs} And Aligns edit Role To The OCP_DBAAS_USER
    And User Aligns edit Role To ${DBaaSTestNS} For OCP_DBAAS_USER
    Then DBaaSInventory Is Available For ${connectionNS}
