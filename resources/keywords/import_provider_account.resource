*** Settings ***
Resource    ../keywords/operators.resource
Resource    ../object_repo/import_dbaasinventory_obj.resource
Resource    ../object_repo/database_access_obj.resource
Resource    ../object_repo/installed_operators_obj.resource
Library     ../../utils/scripts/util.py
Library     ../../utils/scripts/dbaas_utils.py


*** Variables ***
${provaccname}        ${EMPTY}
${INV_ORG_ID}         invalid_org_id
${INV_PUB_KEY}        invalid_pub_key
${INV_PRI_KEY}        invalid_private_key

*** Keywords ***
User Selects Invalid Namespace To Import Database Provider Account And Navigates To Database Access Page
    User Navigates To Installed Operators Under Operators
    User Filters dedicated-admin Namespace On Project Dropdown
    User Navigates To Database Access Page

User Navigates To Import Database Provider Account Screen From Database Access Page
    ${status}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${tblDBProviderAcc}    timeout=10s
    Run Keyword If    ${status}
    ...    Log To Console    No Database Provider Accounts Already Imported
    Select Import Database Provider Account From Configuration Button DropDown
    Sleep    8s
    Comment    [known issue] Auto Page Refresh - Blind Sleep provided for mitigation
    ...        Will be replaced with intelligent wait if issue persists in near future
    ...        Will be removed once issue is fixed

Select ${option} From ${menu} Button DropDown
    ${btnMenuDropDownUpd}=    Replace String    ${btnMenuDropDown}    <<menu>>    ${menu}
    Wait Until Keyword Succeeds    10s    1s    Wait Until Element Is Visible    ${btnMenuDropDownUpd}
    Click Element    ${btnMenuDropDownUpd}
    ${btnMenuOptDropDownUpd}=    Replace String    ${btnMenuOptDropDown}    <<menuopt>>    ${option}
    Element Should Be Visible    ${btnMenuOptDropDownUpd}
    Click Element    ${btnMenuOptDropDownUpd}

Application Navigate To Create Provider Account Page And Error Message Displayed For Invalid Namespace
    Wait Until Page Contains Element    ${titleImportProviderAcc}    timeout=15s
    Wait Until Page Contains Element    ${txtInvalidNamespace}    timeout=15s
    Element Should Be Visible    ${btnImportDisabled}
    Element Should Be Visible    ${btnCancelEnabled}

User Filters Project ${PROJECT} On Project DropDown And Navigates To Database Access Page
    User Navigates To Installed Operators Under Operators
    User Filters ${PROJECT} Namespace On Project Dropdown
    User Navigates To Database Access Page

User Enters Provider Account Name And Selects Database Provider
    [Arguments]    ${invalid}=${False}
    ${dbprovider}=    Set Variable    ${isv}
    Wait Until Keyword Succeeds     5x     2s      Wait Until Page Contains Element    ${drpDwnDBProvider}
    ${paname}=    Get Provider Account Name    ${dbprovider}    ${invalid}
    Set Test Variable    ${provaccname}    ${paname}
    Input Text    ${txtBxName}    ${provaccname}
    Select From List By Label    ${drpDwnDBProvider}    ${dbprovider}

User Enters Data To Import MongoDB Provider Account
    [Arguments]    ${isv}=MongoDB Atlas Cloud Database Service
    Set Suite Variable    ${isv}
    User Enters Provider Account Name And Selects Database Provider
    Wait Until Page Contains Element    ${txtBxMongoDBOrgID}    timeout=10s
    Input Text    ${txtBxMongoDBOrgID}    ${MONGO.ORG_ID}
    Input Text    ${txtBxMongoDBPubAPI}    ${MONGO.PUB_KEY}
    Input Text    ${txtBxMongoDBPrivAPI}    ${MONGO.PRI_KEY}
    Element Should Be Visible    ${btnImportEnabled}
    Click Element    ${btnImportEnabled}

User Enters Invalid Data To Import MongoDB Database Provider Account
    [Arguments]    ${isv}=MongoDB Atlas Cloud Database Service
    Set Suite Variable    ${isv}
    User Enters Provider Account Name And Selects Database Provider    True
    Wait Until Page Contains Element    ${txtBxMongoDBOrgID}    timeout=10s
    Input Text    ${txtBxMongoDBOrgID}    ${INV_ORG_ID}
    Input Text    ${txtBxMongoDBPubAPI}    ${INV_PUB_KEY}
    Input Text    ${txtBxMongoDBPrivAPI}    ${INV_PRI_KEY}
    Element Should Be Visible    ${btnImportEnabled}
    Click Element    ${btnImportEnabled}

User Enters Data To Import CrunchyDB Provider Account
    [Arguments]    ${isv}=Crunchy Bridge managed PostgreSQL
    Set Suite Variable    ${isv}
    User Enters Provider Account Name And Selects Database Provider
    Wait Until Page Contains Element    ${txtBxCrunchyPubAPI}    timeout=10s
    Input Text    ${txtBxCrunchyPubAPI}    ${CRUNCHY.PUB_KEY}
    Input Text    ${txtBxCrunchyPrivAPI}    ${CRUNCHY.PRI_KEY}
    Element Should Be Visible    ${btnImportEnabled}
    Click Element    ${btnImportEnabled}

User Enters Invalid Data To Import CrunchyDB Provider Account
    [Arguments]    ${isv}=Crunchy Bridge managed PostgreSQL
    Set Suite Variable    ${isv}
    User Enters Provider Account Name And Selects Database Provider    True
    Wait Until Page Contains Element    ${txtBxCrunchyPubAPI}    timeout=10s
    Input Text    ${txtBxCrunchyPubAPI}    ${INV_PUB_KEY}
    Input Text    ${txtBxCrunchyPrivAPI}    ${INV_PRI_KEY}
    Element Should Be Visible    ${btnImportEnabled}
    Click Element    ${btnImportEnabled}

User Enters Data To Import CockroachDB Provider Account
    [Arguments]    ${isv}=CockroachDB Cloud
    set Suite Variable    ${isv}
    User Enters Provider Account Name And Selects Database Provider
    Wait Until Page Contains Element    ${txtBxCockroachAPI}    timeout=10s
    Input Text    ${txtBxCockroachAPI}    ${COCKROACH.API_KEY}
    Element Should Be Visible    ${btnImportEnabled}
    Click Element    ${btnImportEnabled}

User Enters Invalid Data To Import CockroachDB Provider Account
    [Arguments]    ${isv}=CockroachDB Cloud
    Set Suite Variable    ${isv}
    User Enters Provider Account Name And Selects Database Provider    True
    Wait Until Page Contains Element    ${txtBxCockroachAPI}    timeout=10s
    Input Text    ${txtBxCockroachAPI}    ${INV_PRI_KEY}
    Element Should Be Visible    ${btnImportEnabled}
    Click Element    ${btnImportEnabled}

Provider Account Import Success
    Application Navigates To Provider Account Import Success Screen
    Imported Provider Account Avaialble On DBaaS Inventory Screen
    Imported Provider Account Available on Database Access Screen

Application Navigates To Provider Account Import Success Screen
    Wait Until Keyword Succeeds     5x     2s      Wait Until Page Contains Element    ${lblDBInstSuccess}
    Element Should Be Visible    ${btnViewProviderAcc}
    Click Element    ${btnViewProviderAcc}

Imported Provider Account Avaialble On DBaaS Inventory Screen
    Wait Until Keyword Succeeds     10x     2s      Wait Until Page Contains Element        ${titleDbaasInventories}
    Filter ${provaccname} On DBaaS Inventory
    ${elemDbaasInvStatusUpd}=    Replace String    ${elemDbaasInvStatus}    <<paname>>    ${provaccname}
    Wait Until Keyword Succeeds     10x     2s      Wait Until Page Contains Element    ${elemDbaasInvStatusUpd}
    Set Suite Variable    ${provaccname}

Imported Provider Account Available on Database Access Screen
    User Navigates To Database Access Under Data Services
    Wait Until Page Contains Element    ${titleDatabaseAccess}
    ${elemProvAccUpd}=    Replace String    ${elemProvAcc}    <<paname>>    ${provaccname}
    ${updProvAcc}=    Replace String    ${elemDBProvider}    <<paname>>    ${provaccname}
    ${isvName}=    Fetch From Left    ${isv}    ${SPACE}
    ${elemDBProviderUpd}=    Replace String    ${updProvAcc}    <<isvname>>    ${isvName}
    Element Should Be Visible    ${elemProvAccUpd}
    Element Should Be Visible    ${elemDBProviderUpd}

Provider Account Import Failure
    Provider Account Import Failure Screen
    User Navigates To DBaaS Inventories Screen
    Check Status Of Invalid Provider Account

Provider Account Import Failure Screen
    Wait Until Page Contains Element    ${titleImportProviderAcc}    timeout=15s
    Wait Until Page Contains Element     ${lblDBInstFailure}    timeout=20s
    Page Should Contain Button    ${btnEditProvAcc}

User Navigates To DBaaS Inventories Screen
    [Arguments]    ${PROJECT}=redhat-dbaas-operator
    User Navigates To Installed Operators Under Operators
    User Filters ${PROJECT} Namespace On Project Dropdown
    Wait Until Page Contains Element    ${elemDbaasStatus}    timeout=15s
    Page Should Contain Element    ${lnkProvAcc}
    Click Element    ${lnkProvAcc}
    Wait Until Page Contains Element    ${titleDbaasInventories}    timeout=10s

Check Status Of Invalid Provider Account
    Wait Until Page Contains Element    ${titleDbaasInventories}    timeout=10s
    Filter ${provaccname} On DBaaS Inventory
    ${elemDbaasInvStatusUpd}=    Replace String    ${elemDbaasInvStatus}    <<paname>>    ${provaccname}
    Page Should Not Contain Element    ${elemDbaasInvStatusUpd}

User Imports Invalid ${databaseProvider} Provider Account
    User Filters Project redhat-dbaas-operator On Project DropDown And Navigates To Database Access Page
    User Navigates To Import Database Provider Account Screen From Database Access Page
    Run Keyword If    "Mongo" in """${databaseProvider}"""
    ...    User Enters Invalid Data To Import MongoDB Database Provider Account
    ...  ELSE IF    "Crunchy" in """${databaseProvider}"""
    ...    User Enters Invalid Data To Import CrunchyDB Provider Account
    ...  ELSE IF    "Cockroach" in """${databaseProvider}"""
    ...    User Enters Invalid Data To Import CockroachDB Provider Account
    Provider Account Import Failure

User Imports Valid ${databaseProvider} Provider Account
    Run Keyword If    "${provaccname}" == "${EMPTY}"
    ...    Import ${databaseProvider} Provider Account
    ...  ELSE
    ...    Log     Provider Account ${provaccname} Exists    console=yes

Import ${databaseProvider} Provider Account
    User Filters Project redhat-dbaas-operator On Project DropDown And Navigates To Database Access Page
    User Navigates To Import Database Provider Account Screen From Database Access Page
    Run Keyword If    "Mongo" in """${databaseProvider}"""
    ...    User Enters Data To Import MongoDB Provider Account
    ...  ELSE IF    "Crunchy" in """${databaseProvider}"""
    ...    User Enters Data To Import CrunchyDB Provider Account
    ...  ELSE IF    "Cockroach" in """${databaseProvider}"""
    ...    User Enters Data To Import CockroachDB Provider Account
    Provider Account Import Success
