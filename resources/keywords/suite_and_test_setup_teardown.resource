*** Settings ***
Resource    ../keywords/login.resource
Resource    ../keywords/dbaas_policy.resource


*** Keywords ***
Remove Provisioned DBaaSInstances
    IF    "${instanceName}" != "${EMPTY}"
        ${cmd_instances} =    Catenate    oc delete DBaaSInstance/${instanceName}
        ...    --wait=true --timeout=10s --ignore-not-found
        IF    """dev""" in """${instanceName}""" and "${newProject}" != "${EMPTY}"
             ${cmd_instances} =    Catenate    ${cmd_instances}    -n ${newProject}
        END
        ${stdout} =   Execute Command    ${cmd_instances}    True
        Set Suite Variable    ${instanceName}    ${EMPTY}
    END

    Sleep    7s
    Comment    Blind Sleep provided to let DB Cluster get deleted on the ISV Side
    ...        before the associated DBaaSInventory is deleted from RHODA
    ...        If the associated DBaaSInventory(Provider Account) is deleted from RHODA
    ...        before the database cluster gets deleted from ISV side, the concerned
    ...        DBaaSInstance CRD will eventually get deleted but the DB Cluster will not
    ...        get removed on ISV side

Remove Created Namespaces
    [Arguments]     ${ns}=${newProject}
    IF    "${ns}" != "${EMPTY}"
        ${cmd_namespaces} =    Catenate    oc delete ns/${ns} --wait=True --timeout=10s --ignore-not-found
        ...    && echo "Namespace deleted within timeout" || echo "Could not delete Namespace, will be force deleted"
        ${stdout} =    Execute Command    ${cmd_namespaces}    True
        Set Suite Variable    ${newProject}    ${EMPTY}
        Set Suite Variable    ${ns}    ${EMPTY}
    END

Remove DBaaSPolicy
     IF    "${policyName}" != "${EMPTY}"
         ${cmd_policy} =    Catenate    oc delete DBaaSPolicy/${policyName} --wait=True --timeout=10s --ignore-not-found
         ...    && echo "DBaaSPolicy deleted within timeout" || echo "Could not delete Namespace, will be force deleted"
         ${stdout} =    Execute Command    ${cmd_policy}    True
         Set Test Variable    ${policyName}    ${EMPTY}
     END

Remove Imported Provider Accounts
    IF    "${provaccname}" != "${EMPTY}"
        ${cmd_provider_account} =   Set Variable    oc delete DBaaSInventory/${provaccname} -n ${operatorNamespace} --wait=true
        ${stdout} =    Execute Command    ${cmd_provider_account}    True
        Set Suite Variable      ${provaccname}    ${EMPTY}
    END

Force Delete Terminating Namespaces
    ${cmd_oc_proxy} =    Set Variable    oc proxy &> /dev/null &
    ${stdout} =    Execute Command    ${cmd_oc_proxy}     True
    ${cmd_force_ns} =    Catenate    oc get namespace | awk '/Term/{print $1}' |
    ...    xargs -I{} echo "oc get ns {} -o json | jq '.spec.finalizers=[]' |
    ...    curl -H "Content-Type: application/json" -X PUT
    ...    http://127.0.0.1:8001/api/v1/namespaces/{}/finalize --data-binary @-" | xargs -I{} bash -c "{}"
    Log     ${cmd_force_ns}
    ${stdout} =    Execute Command    ${cmd_force_ns}    True
    ${kill_oc_proxy} =      Set Variable    pkill -f "oc proxy"
    Execute Command    ${kill_oc_proxy}    True

Tear Down The Test Case
    Log    Test Case Tear Down
    Close Browser
    Run Keyword If    "${instanceName}" == "${EMPTY}"
    ...    Remove Created Namespaces
    Run Keyword If    """inv""" in """${provaccname}""" or """False""" in """${VALID_SECRET}"""
    ...    Remove Imported Provider Accounts

Tear Down The RDS Test Case
    Log    RDS Test Case Tear Down
    Close Browser
    Run Keyword If    "${instanceName}" == "${EMPTY}"
    ...    Remove Created Namespaces
    Run Keyword If    """inv""" in """${provaccname}"""
    ...    Remove Imported Provider Accounts
    IF    "${newProject}" != "${EMPTY}"
           Set Suite Variable    ${newProject}   ${EMPTY}
    END

Tear Down DBaaSPolicy Test Case
    Log    DBaaSPolicy Test Case Tear Down
    Close Browser
    Remove Imported Provider Accounts
    Remove DBaaSPolicy
    IF    "${user}" != "${EMPTY}" and "${access}" != "${EMPTY}"
        Remove RoleBinding For The ${user} With ${access} To ${connectionNS}
    END
    IF    "@{addNS}" != "@{EMPTY}"
        Login To OpenShift CLI As Cluster Admin
        Remove Created Namespaces   ${connectionNS}
        Force Delete Terminating Namespaces
        Set Suite Variable    ${newProject}  ${DBaaSTestNS}
    END

Tear Down The Test Suite
    Log    Test Suite Tear Down
    Login To OpenShift CLI As Cluster Admin
    Remove Provisioned DBaaSInstances
    Remove Imported Provider Accounts
    Remove Created Namespaces
    Force Delete Terminating Namespaces

Setup The Test Case
    [Arguments]     ${DBaaSPersona}=${DBAASPOLICY.PERSONA}
    The Browser Is On Openshift Home Screen
    IF    not ${DBaaSPolicyConfigured} and ${DBaaSPolicyEnabled}    Run Keywords
    ...    Set Suite Variable   ${operatorNamespace}    ${DBAASPOLICY.NAMESPACE}
    ...    AND    Setup RHODA Persona Namespace
    ...    AND    Align RBAC For ${OCP_LDAP_USER.USERNAME}
    ...    AND    Setup DBaaSPolicy For ${operatorNamespace} as ${DBaaSPersona}
    ...    AND    User Creates DBaaSPolicy For ${operatorNamespace} From Admin View As ${DBaaSPersona}
    ...    AND    Set Global Variable    ${DBaaSPolicyConfigured}    ${True}

Configure DBaaS Policy Namespaces
    [Arguments]     ${ns}=${DBaaSTestNS}
    Login To OpenShift CLI As Cluster Admin
    Check LDAP Configuration For The Cluster
    Add DBaaS Namespace     ${ns}
    Add RBAC Policies For The Namespace ${ns}

Add DBaaS Namespace
    [Arguments]     ${ns}
    ${cmd} =    Set Variable    oc new-project ${ns}
    Execute ${cmd} And Raise Exception For Error
    Set Suite Variable    ${newProject}     ${ns}
    ${cmd} =    Set Variable    oc get project ${ns}
    Execute ${cmd} And Raise Exception For Error

Add RBAC Policies For The Namespace ${ns}
    ${cmd} =    Set Variable    oc adm policy add-role-to-user admin ${OCP_LDAP_PROJECT_ADM.USERNAME} -n ${ns}
    Execute ${cmd} And Raise Exception For Error
    ${cmd} =    Set Variable    oc adm policy add-role-to-user edit ${OCP_LDAP_SERVICE_ADM.USERNAME} -n ${ns}
    Execute ${cmd} And Raise Exception For Error
    ${cmd} =    Set Variable    oc adm policy add-role-to-user view ${OCP_LDAP_DEV.USERNAME} -n ${ns}
    Execute ${cmd} And Raise Exception For Error

Check LDAP Configuration For The Cluster
    ${cmd} =    Set Variable    oc get ns/openldap
    Execute ${cmd} And Raise Exception For Error

Execute ${cmd} And Raise Exception For Error
    ${stdout} =    Execute Command    ${cmd}    True
    ${stdout_str} =    Convert To String    ${stdout}
    ${stdout_str} =    Convert To Lower Case    ${stdout_str}
    Should Not Contain Any    ${stdout_str}     error   none    msg=Command Executed With Error ${stdout_str}

Remove RoleBinding For The ${user} With ${access} To ${ns}
    ${cmd} =    Set Variable    oc adm policy remove-role-from-user ${access} ${${user}.USERNAME} -n ${ns}
    Execute ${cmd} And Raise Exception For Error
