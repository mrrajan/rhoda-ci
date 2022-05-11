*** Settings ***
Resource    ../keywords/operators.resource
Resource    ../object_repo/database_access_obj.resource
Resource    ../object_repo/installed_operators_obj.resource
Library     ../../utils/scripts/util.py
Library     ../../utils/scripts/dbaas_connection.py


*** Variables ***
${provaccname}      ${EMPTY}

*** Keywords ***
User Filters Project Other Than redhat-dbaas-operator And Navigates To Database Access Page
    User Navigates To Installed Operators Under Operators
    User Filters dedicated-admin Namespace On Project Dropdown
    User Navigates To Database Access Page

User Navigates To Create Provider Account Screen From Database Access Page
    ${status}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${tblDBProviderAcc}    timeout=10s
    Run Keyword If    '${status}' == 'True'
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

User Filters Project redhat-dbaas-operator On Project DropDown And Navigates To Database Access Page
    User Navigates To Installed Operators Under Operators
    User Filters redhat-dbaas-operator Namespace On Project Dropdown
    User Navigates To Database Access Page

User Enters Provider Account Name And Selects Database Provider ${dbprovider}
    Wait Until Page Contains Element    ${drpDwnDBProvider}    timeout=20s
    ${paname}=    Get Provider Account Name    ${dbprovider}
    Set Test Variable    ${provaccname}    ${paname}
    Input Text    ${txtBxName}    ${provaccname}
    Select From List By Label    ${drpDwnDBProvider}    ${dbprovider}

User Enters Data To Create MongoDB Provider Account
    [Arguments]    ${mongoDB}=MongoDB Atlas Cloud Database Service
    User Enters Provider Account Name And Selects Database Provider ${mongoDB}
    Wait Until Page Contains Element    ${txtBxMongoDBOrgID}    timeout=10s
    Input Text    ${txtBxMongoDBOrgID}    ${MONGO.ORG_ID}
    Input Text    ${txtBxMongoDBPubAPI}    ${MONGO.PUB_KEY}
    Input Text    ${txtBxMongoDBPrivAPI}    ${MONGO.PRI_KEY}
    Element Should Be Visible    ${btnCreateEnabled}
    Click Element    ${btnCreateEnabled}

Provider Account Creation Successful And Application Navigates To Success Screen
    Application Navigates To Provider Account Creation Success Screen
    Provider Account Creation Success

Application Navigates To Provider Account Creation Success Screen
    Wait Until Keyword Succeeds     5x     2s      Wait Until Page Contains Element    ${lblDBInstSuccess}
    Element Should Be Visible    ${btnViewProviderAcc}

Provider Account Creation Success
    Click Element    ${btnViewProviderAcc}
    Wait Until Page Contains Element    ${btnLastUpdatedHeader}     timeout=10s
    Filter ${provaccname} On DBaaS Inventory
    ${elemDbaasInvStatusUpd}=    Replace String    ${elemDbaasInvStatus}    <<paname>>    ${provaccname}
    Wait Until Keyword Succeeds     10x     2s      Wait Until Page Contains Element    ${elemDbaasInvStatusUpd}
    Set Suite Variable    ${provaccname}

User Creates MongoDB Provider Account
    Run Keyword If    "${provaccname}" == "${EMPTY}"
    ...    Create MongoDB Provider Account
    ...  ELSE
    ...    Log To Console    Provider Account ${provaccname} Exists

Create MongoDB Provider Account
    User Filters Project redhat-dbaas-operator On Project DropDown And Navigates To Database Access Page
    User Navigates To Create Provider Account Screen From Database Access Page
    User Enters Data To Create MongoDB Provider Account
    Provider Account Creation Successful And Application Navigates To Success Screen




