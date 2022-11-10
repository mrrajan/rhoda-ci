*** Settings ***
Library     SeleniumLibrary
Library     BuiltIn
Library     String
Library     Collections
Resource    login.resource
Resource    ../object_repo/grafana_or.resource
Variables   ../../utils/data/oc_cli_commands.yaml


*** Keywords ***
Login To Grafana
    Set Selenium Implicit Wait    5s
    Open Browser    ${GRAFANA_URL}    browser=${BROWSER.NAME}    options=${BROWSER.OPTIONS}
    Wait Until Page Contains Element    ${txtWelcomeMsg}    timeout=10s
    Element Should Be Visible    ${btnOauthSignin}
    Click Element    ${btnOauthSignin}
    Select Login Authentication Type    ${GRAFANA_USER.AUTH_TYPE}
    Wait Until Page Contains Element    ${titleLoginPage}    timeout=10s
    Element Should Be Visible    ${titleLoginPage}
    Element Should Be Visible    ${txtBxUserName}
    Element Should Be Visible    ${txtBxPassword}
    Element Should Be Visible    ${btnLogin}
    Input Text    ${txtBxUserName}    ${GRAFANA_USER.USERNAME}
    Input Password    ${txtBxPassword}    ${GRAFANA_USER.PASSWORD}
    Click Element    ${btnLogin}
    Element Should Be Visible    ${hdrDashboard}

Select RHODA Dashboard
    ${lnkDashboardUpd}=    Replace String    ${lnkDashboard}    <dashboard>    ${GRAFANA_USER.DASHBOARD_NAME}
    Element Should Be Visible    ${lnkDashboardUpd}
    Click Element    ${lnkDashboardUpd}
    ${btnDashboardUpd}=     Replace String    ${btnDashboard}    <dashboard>    ${GRAFANA_USER.DASHBOARD_NAME}
    Element Should Be Visible    ${btnDashboardUpd}

The User Is On Grafana RHODA Dashboard
    Login To Grafana
    Select RHODA Dashboard

Retrieve Cluster Information From Grafana
    ${c_id}=    Execute Command    ${cluster_id}    True
    &{grafana_cluster_info}=    Get Row Matching Target    ${tblClusterInfo}    Cluster Id    ${c_id}
    Set Test Variable    ${grafana_cluster_info}

Retrieve Cluster Infromation From Openshift
    ${version}=    Execute Command    ${cluster_version}    True
    ${ID}=   Execute Command    ${cluster_id}    True
    ${dbaas}=   Execute Command    ${installed_dbaas_version}   True
    &{oc_cluster_info}=     Create Dictionary   Cluster Id=${ID}   Cluster Version=${version}   Operator Version=${dbaas}
    &{oc_cluster_info}=     Create Dictionary   OpenShift Console URL=${OCP_CONSOLE_URL}    &{oc_cluster_info}
    Set Test Variable    ${oc_cluster_info}

 The Cluster Information On Grafana Matches With Openshift
    Retrieve Cluster Information From Grafana
    Retrieve Cluster Infromation From Openshift
    Compare Dict Values On Another Dict    ${oc_cluster_info}    ${grafana_cluster_info}

