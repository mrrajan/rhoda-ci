*** Settings ***
Resource    ../keywords/operators.resource
Resource    ../object_repo/create_dbaasinventory_obj.resource
Resource    ../object_repo/database_access_obj.resource
Resource    ../object_repo/installed_operators_obj.resource
Library     ../../utils/scripts/util.py
Library     ../../utils/scripts/dbaas_connection.py



*** Variables ***
${provaccname}      ${EMPTY}
${INV_ORG_ID}       invalid_org_id
${INV_PUB_KEY}      invalid_pub_key
${INV_PRI_KEY}      invalid_private_key

*** Keywords ***
User Selects Invalid Namespace For Provider Account Creation And Navigates To Database Access Page
    User Navigates To Installed Operators Under Operators
    User Filters dedicated-admin Namespace On Project Dropdown
    User Navigates To Database Access Page

User Navigates To Create Provider Account Screen From Database Access Page
    ${status}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${tblDBProviderAcc}    timeout=10s
    Run Keyword If    ${status}
    ...    Select Database Provider Account From Create Button DropDown
    ...    ELSE
    ...    Click Element    ${btnCreateProviderAcc}

Select ${option} From ${menu} Button DropDown
    ${btnMenuDropDownUpd}=    Replace String    ${btnMenuDropDown}    <<menu>>    ${menu}
    Element Should Be Visible    ${btnMenuDropDownUpd}
    Click Element    ${btnMenuDropDownUpd}
    ${btnMenuOptDropDownUpd}=    Replace String    ${btnMenuOptDropDown}    <<menuopt>>    ${option}
    Element Should Be Visible    ${btnMenuOptDropDownUpd}
    Click Element    ${btnMenuOptDropDownUpd}

Application Navigate To Create Provider Account Page And Error Message Displayed For Invalid Namespace
    Wait Until Page Contains Element    ${titleCreateProviderAcc}    timeout=15s
    Wait Until Page Contains Element    ${txtInvalidNamespace}    timeout=15s
    Element Should Be Visible    ${btnCreateDisabled}
    Element Should Be Visible    ${btnCancelEnabled}

User Filters Project ${PROJECT} On Project DropDown And Navigates To Database Access Page
    User Navigates To Installed Operators Under Operators
    User Filters ${PROJECT} Namespace On Project Dropdown
    User Navigates To Database Access Page

User Enters Provider Account Name And Selects Database Provider
    [Arguments]    ${invalid}=${False}
    ${dbprovider}=    Set Variable    ${isv}
    Wait Until Page Contains Element    ${drpDwnDBProvider}    timeout=20s
    ${paname}=    Get Provider Account Name    ${dbprovider}    ${invalid}
    Set Test Variable    ${provaccname}    ${paname}
    Input Text    ${txtBxName}    ${provaccname}
    Select From List By Label    ${drpDwnDBProvider}    ${dbprovider}

User Enters Data To Create MongoDB Provider Account
    [Arguments]    ${isv}=MongoDB Atlas Cloud Database Service
    Set Suite Variable    ${isv}
    User Enters Provider Account Name And Selects Database Provider
    Wait Until Page Contains Element    ${txtBxMongoDBOrgID}    timeout=10s
    Input Text    ${txtBxMongoDBOrgID}    ${MONGO.ORG_ID}
    Input Text    ${txtBxMongoDBPubAPI}    ${MONGO.PUB_KEY}
    Input Text    ${txtBxMongoDBPrivAPI}    ${MONGO.PRI_KEY}
    Element Should Be Visible    ${btnCreateEnabled}
    Click Element    ${btnCreateEnabled}

User Enters Invalid Data To Create MongoDB Provider Account
    [Arguments]    ${isv}=MongoDB Atlas Cloud Database Service
    Set Suite Variable    ${isv}
    User Enters Provider Account Name And Selects Database Provider    True
    Wait Until Page Contains Element    ${txtBxMongoDBOrgID}    timeout=10s
    Input Text    ${txtBxMongoDBOrgID}    ${INV_ORG_ID}
    Input Text    ${txtBxMongoDBPubAPI}    ${INV_PUB_KEY}
    Input Text    ${txtBxMongoDBPrivAPI}    ${INV_PRI_KEY}
    Element Should Be Visible    ${btnCreateEnabled}
    Click Element    ${btnCreateEnabled}

User Enters Data To Create CrunchyDB Provider Account
    [Arguments]    ${isv}=Crunchy Bridge managed PostgreSQL
    Set Suite Variable    ${isv}
    User Enters Provider Account Name And Selects Database Provider
    Wait Until Page Contains Element    ${txtBxCrunchyPubAPI}    timeout=10s
    Input Text    ${txtBxCrunchyPubAPI}    ${CRUNCHY.PUB_KEY}
    Input Text    ${txtBxCrunchyPrivAPI}    ${CRUNCHY.PRI_KEY}
    Element Should Be Visible    ${btnCreateEnabled}
    Click Element    ${btnCreateEnabled}

User Enters Invalid Data To Create CrunchyDB Provider Account
    [Arguments]    ${isv}=Crunchy Bridge managed PostgreSQL
    Set Suite Variable    ${isv}
    User Enters Provider Account Name And Selects Database Provider    True
    Wait Until Page Contains Element    ${txtBxCrunchyPubAPI}    timeout=10s
    Input Text    ${txtBxCrunchyPubAPI}    ${INV_PUB_KEY}
    Input Text    ${txtBxCrunchyPrivAPI}    ${INV_PRI_KEY}
    Element Should Be Visible    ${btnCreateEnabled}
    Click Element    ${btnCreateEnabled}

Provider Account Creation Success
    Application Navigates To Provider Account Creation Success Screen
    Provider Account Creation Success Page
    Provider Account Available on Database Access Screen

Application Navigates To Provider Account Creation Success Screen
    Wait Until Keyword Succeeds     5x     2s      Wait Until Page Contains Element    ${lblDBInstSuccess}
    Element Should Be Visible    ${btnViewProviderAcc}

Provider Account Creation Success Page
    Click Element    ${btnViewProviderAcc}
    Wait Until Page Contains Element    ${titleDbaasInventories}    timeout=10s
    Filter ${provaccname} On DBaaS Inventory
    ${elemDbaasInvStatusUpd}=    Replace String    ${elemDbaasInvStatus}    <<paname>>    ${provaccname}
    Wait Until Keyword Succeeds     10x     2s      Wait Until Page Contains Element    ${elemDbaasInvStatusUpd}
    Set Suite Variable    ${provaccname}

Provider Account Available on Database Access Screen
    User Navigates To Database Access Under Data Services
    Wait Until Page Contains Element    ${titleDatabaseAccess}
    ${elemProvAccUpd}=    Replace String    ${elemProvAcc}    <<paname>>    ${provaccname}
    ${updProvAcc}=    Replace String    ${elemDBProvider}    <<paname>>    ${provaccname}
    ${isvName}=    Fetch From Left    ${isv}    ${SPACE}
    Log To Console    ${isvName}
    ${elemDBProviderUpd}=    Replace String    ${updProvAcc}    <<isvname>>    ${isvName}
    Element Should Be Visible    ${elemProvAccUpd}
    Element Should Be Visible    ${elemDBProviderUpd}

Provider Account Creation Failure
    Provider Account Creation Failure Screen
    User Navigates To DBaaS Inventories Screen
    Check Status Of Invalid Provider Account

Provider Account Creation Failure Screen
    Wait Until Page Contains Element    ${titleCreateProviderAcc}    timeout=15s
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

User Creates ${databaseProvider} Provider Account
    Run Keyword If    "${provaccname}" == "${EMPTY}"
    ...    Create ${databaseProvider} Provider Account
    ...  ELSE
    ...    Log To Console    Provider Account ${provaccname} Exists

Create ${databaseProvider} Provider Account
    User Filters Project redhat-dbaas-operator On Project DropDown And Navigates To Database Access Page
    User Navigates To Create Provider Account Screen From Database Access Page
    Run Keyword If    "Mongo" in """${databaseProvider}"""
    ...    User Enters Data To Create MongoDB Provider Account
    ...  ELSE IF    "Crunchy" in """${databaseProvider}"""
    ...    User Enters Data To Create CrunchyDB Provider Account
    ...  ELSE IF    "Cockroach" in """${databaseProvider}"""
    ...    User Enters Data To Create CrunchyDB Provider Account
    Provider Account Creation Success




