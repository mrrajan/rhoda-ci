*** Settings ***
Resource    ../keywords/deploy_instance_dev.resource
Resource    ../object_repo/provision_dbinstance_obj.resource
Resource    ../object_repo/database_access_obj.resource
Library     ../../utils/scripts/util.py


*** Keywords ***
User Navigates To Create Database Instance Screen From Database Access Page
    User Navigates To Database Access Under Data Services
    Wait Until Page Contains Element    ${titleDatabaseAccess}
    Select Create Database Instance From Configuration Button DropDown

User Navigates To Create Database Instance Screen On Developer View
    User Navigates To Add ${DBProvider} To Topology Screen
    User Selects Database Provider Account
    Run Keyword If    not ${invalid}    Run Keywords
    ...    Element Should Be Visible    ${lnkCreateDBInst}
    ...    AND    Click Element    ${lnkCreateDBInst}

User Selects DBProvider And Provider Account
    [Arguments]    ${isv_name}=${isv}
    Wait Until Keyword Succeeds    5x    2s    Wait Until Element Is Visible    ${drpDwnDBProvider}
    Wait Until Keyword Succeeds    10s    1s    Toggle Database Provider Drop Down ${isv_name}
    User Selects Database Provider Account

User Selects Database Provider Account
    Wait Until Page Contains Element    ${drpDwnDevProvAccount}     timeout=10s
    Select From List By Label    ${drpDwnDevProvAccount}     ${provaccname}

Toggle Database Provider Drop Down ${isv_name}
    Select From List By Label    ${drpDwnDBProvider}    Select database provider
    Select From List By Label    ${drpDwnDBProvider}    ${isv_name}
    Element Should Be Visible    ${drpDwnProvAccOptn}

User Enters Data To Create Database Instance On Admin View
    User Selects DBProvider And Provider Account
    ${instanceName}=    Get Instance Name   adm
    Set Test Variable    ${instanceName}
    Input Text    ${txtBxInstName}    ${instanceName}
    ${mongoProj}=     Get Project Name    ${TEST TAGS}
    Run Keyword If    "Mongo" in """${DBProvider}"""    Run Keywords
    ...    Element Should Be Visible    ${txtBxProjName}
    ...    AND    Input Text    ${txtBxProjName}    ${mongoProj}
    Element Should Be Visible    ${btnCreateEnabled}
    Click Element    ${btnCreateEnabled}
    Element Should Be Visible    ${txtCreatingDBInst}

User Enters Data To Create Instance On Dev View
    Wait Until Keyword Succeeds    15s    2s    Element Should Be Visible    ${txtBxInstName}
    ${instanceName}=    Get Instance Name   dev
    Set Test Variable    ${instanceName}
    Input Text    ${txtBxInstName}    ${instanceName}
    Run Keyword If    "Mongo" in """${DBProvider}"""    Run Keywords
    ...    Element Should Be Visible    ${txtBxProjName}
    ...    AND    Input Text    ${txtBxProjName}    ${newProject}
    Element Should Be Visible    ${btnCreateEnabled}
    Click Element    ${btnCreateEnabled}
    Element Should Be Visible    ${txtCreatingDBInst}

${databaseProvider} DBSC Instance Provisioned And Deployed On Developer Topology Graph View
    DBSC Instance Provisioned Successfully
    Run Keyword If    "Admin" in """${perspective}"""    Run Keywords
    ...    DBSC Instance Available On DataBase Access Page
    ...    AND        User Navigates To Add ${DBProvider} To Topology Screen
    DBSC Instance For ${databaseProvider} Deployed Successfully

DBSC Instance Provisioned Successfully
    Wait Until Keyword Succeeds     7x     1s      Wait Until Page Contains Element    ${txtInstCreated}
    Element Should Be Visible    ${txtCreationInfo}
    Element Should Be Visible    ${btnViewDBInst}
    Click Button    ${btnViewDBInst}

DBSC Instance Available On DataBase Access Page
    Wait Until Keyword Succeeds     5x     2s   Filter DBSC Instance Until Success

Filter DBSC Instance On Database Access Inventory Table
    Wait Until Page Contains Element    ${titleDatabaseAccess}
    Element Should Be Visible    ${txtBxSearchByName}
    Input Text    ${txtBxSearchByName}    ${instanceName}
    ${elemInstanceNameUpd}=    Replace String    ${elemInstanceName}    <<inst-name>>    ${instanceName}
    ${elemInstProvNameUpd}=    Replace String    ${elemInstProvName}    <<inst-name>>    ${instanceName}
    ${elemInstProvNameUpd}=    Replace String    ${elemInstProvNameUpd}    <<paname>>    ${provaccname}
    Wait Until Element Is Visible    ${elemInstanceNameUpd}
    Element Should Be Visible    ${elemInstProvNameUpd}

Filter DBSC Instance Until Success
    ${instFound}=    Run Keyword And Return Status    Filter DBSC Instance On Database Access Inventory Table
    Run Keyword If    not ${instFound}
    ...    Run Keywords
    ...    Reload Page    AND    Fail

DBSC Instance For ${databaseProvider} Deployed Successfully
    User Filters And Selects The Created Database Instance
    DBSC Instance Deployed On Developer Topology Graph View

DBSC Instance Retrieval Failed On Admin View
    Wait Until Element Is Visible    ${txtProvFailHead}
    Element Should Be Visible    ${txtProvFailMsg}
    Element Should Be Visible    ${btnTryAgain}
    Element Should Be Visible    ${btnClose}
    Click Button    ${btnClose}

DBSC Instance Retrieval Failed On Dev View
    Wait Until Element Is Visible    ${txtInstFailHead}
    Element Should Be Visible    ${txtInstRtrvFail}
    Element Should Be Visible    ${btnTryAgain}
    Element Should Be Visible    ${btnClose}
    Click Button    ${btnClose}
