*** Settings ***
Resource    ../keywords/deploy_application.resource
Resource    ../object_repo/create_dbaaspolicy_obj.resource
Resource    ../object_repo/operatorhub_obj.resource
Resource    ../object_repo/developer_catalog_obj.resource
Resource    ../object_repo/import_dbaasinventory_obj.resource

*** Variables ***
${policyName}       ${EMPTY}
${nsAndLabel}       ${EMPTY}
@{addNS}            ${EMPTY}
@{addLabel}        ${EMPTY}


*** Keywords ***
Align RBAC For ${user}
    IF    not ${rbacAligned} and """service""" in """${user}""" or """service""" in """${DBAASPOLICY.PERSONA}"""
        Login To OpenShift CLI As Cluster Admin
        ${cmd} =    Set Variable    oc adm policy add-role-to-user edit ${user} -n ${operatorNamespace}
        ${stdout} =    Execute Command    ${cmd}    True
        ${cmd} =    Set Variable    oc adm policy remove-role-from-user admin ${user} -n ${operatorNamespace}
        ${stdout} =    Execute Command    ${cmd}    True
        Login To OpenShift CLI As LDAP User
        Set Global Variable    ${rbacAligned}    ${True}
    END

Setup RHODA Persona Namespace
    User Navigates To Projects Under Home
    ${status} =    Run Keyword And Return Status    User Filters ${operatorNamespace} Namespace On Projects Screen
    Run Keyword If    not ${status}
    ...    Create Custom Namespace    ${operatorNamespace}
    ${cmd}    Set Variable    oc project ${operatorNamespace}
    ${stdout} =    Execute Command    ${cmd}    True

Create Custom Namespace
    [Arguments]    ${custom_ns}
    User Navigates To Installed Operators Under Operators
    Wait Until Page Contains Element    ${drpDwnProjectSelect}    timeout=15s
    Click Element    ${drpDwnProjectSelect}
    Wait Until Page Contains Element    ${btnCreateProject}
    Click Element    ${btnCreateProject}
    Wait Until Page Contains Element    ${hdrCreateProject}
    Input Text    ${txtBxProjectName}    ${custom_ns}
    Click Element    ${btnConfirmCreate}
    ${lblProjectSelectUpd}=     Replace String    ${lblProjectSelect}    <<project>>    ${custom_ns}
    Wait Until Page Contains Element    ${lblProjectSelectUpd}

Setup DBaaSPolicy for ${namespace} as ${DBaaSPersona}
    User Navigates To DBaaSPolicy Screen
    Run Keyword If    """.11""" in """${CLUSTER_VERSION}"""
    ...    Click Element    ${lblOperand}
    Comment    The above step Click Element ${lblOperand} should be enabled
    ...        only for Openshift Version >= 4.11
    ...        IF statement can be removed once support for 4.10 is dropped
    ${status} =    Run Keyword And Return Status    Wait Until Page Contains Element    ${txtNoDbaaSPolicy}    timeout=7s
    IF    ${status}
        Create Custom DBaaSPolicy as ${DBaaSPersona}
        DBaaSPolicy Creation Success
    END
    Set Global Variable    ${DBaaSPolicyChecked}    ${True}

DBaaSPolicy Creation Success
    Click If Element Present    ${lblOperand}
    ${lnkDBaaSPolicyUpd} =    Replace String    ${lnkDBaaSPolicyName}    <<policyname>>   ${policyName}
    Wait Until Page Contains Element    ${lnkDBaaSPolicyUpd}    timeout=10s

Create Custom DBaaSPolicy as ${DBaaSPersona}
    Wait Until Element Is Visible    ${titleCreateDBaaSPolicy}    timeout=10s
    Click Element    ${radFormView}
    Element Should Be Visible    ${txtBxDBaaSPolicyName}
    ${persona}=     Remove String    ${DBaaSPersona}     _
    ${persona}=     Convert To Lower Case    ${persona}
    Set Test Variable  ${policyName}   ${persona}-policy
    Input Text    ${txtBxDBaaSPolicyName}    ${policyName}
    Specify Connection Namespaces And Labels
    Scroll Element Into View    ${btnCreateEnabled}
    Click Element    ${btnCreateEnabled}

User Creates DBaaSPolicy For ${namespace} From Invalid Namespace Alert on Admin View As ${DBaaSPersona}
    User Filters Project ${namespace} On Project DropDown And Navigates To Database Access Page
    User Navigates To Import Database Provider Account Screen From Database Access Page
    Wait Until Page Contains Element    ${errCreateDBaaSPolicy}     timeout=20s
    Click Element    ${errCreateDBaaSPolicy}
    Create Custom DBaaSPolicy as ${DBaaSPersona}

User Is Able To Import ${databaseProvider} Provider Account For ${namespace}
    User Filters Project ${namespace} On Project DropDown And Navigates To Database Access Page
    User Navigates To Import Database Provider Account Screen From Database Access Page
    Import ${databaseProvider} Provider Account

DBaaSPolicy Creation Forbidden
    Element Should Be Visible    ${errDBaaSPolicyForbid}

Click If Element Present
    [Arguments]     ${element}
    ${status}=  Run Keyword And Return Status    Element Should Be Visible    ${element}
    IF    ${status}
        Click Element    ${element}
    END

User Creates DBaaSPolicy For ${namespace} From Admin View As ${DBaaSPersona}
    User Navigates To DBaaSPolicy Screen    ${namespace}
    User Creates DBaaSPolicy For ${DBaaSPersona}

User Creates DBaaSPolicy For ${namespace} From Invalid Namespace Alert on Dev View As ${DBaaSPersona}
    User Navigates To Import MongoDB Provider Account On Developer View
    Wait Until Page Contains Element    ${errCreateDBaaSPolicy}          timeout=20s
    Click Element    ${errCreateDBaaSPolicy}
    Create Custom DBaaSPolicy as ${DBaaSPersona}
    User Selects Administrator View

User Creates DBaaSPolicy For ${DBaaSPersona}
    Click If Element Present    ${lblOperand}
    Wait Until Page Contains Element    ${btnCreateDBaaSPolicy}
    Click Element    ${btnCreateDBaaSPolicy}
    Create Custom DBaaSPolicy as ${DBaaSPersona}

Max Quota Exceeded Error Displays
    Scroll Element Into View    ${txtQuotaError}
    Element Should Be Visible   ${txtQuotaError}

Specify Connection Namespaces And Labels
    ${ns}=  Run Keyword And Return Status   Should Contain    ${nsAndLabel}    namespaces
    ${label}=  Run Keyword And Return Status   Should Contain    ${nsAndLabel}    label
    IF      ${ns}
        Click Element    ${btnToggleConnNS}
        Add Policy Connection Namespaces    ${addNS}
    END
    IF    ${label}
        Click Element    ${btnToggleConnNSSelect}
        Element Should Be Visible    ${btnToggleMatchExp}
        Click Element    ${btnToggleMatchExp}
        Element Should Be Visible    ${btnAddMatchExp}
        Add Policy Connection Nsselector    ${addLabel}
    END
