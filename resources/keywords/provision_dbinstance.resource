*** Settings ***
Resource    ../keywords/deploy_instance_dev.resource
Resource    ../object_repo/provision_dbinstance_obj.resource
Resource    ../object_repo/database_access_obj.resource
Library     ../../utils/scripts/util.py


*** Keywords ***
User Navigates To Create Database Instance Screen From Database Access Page
    User Navigates To Database Access Under Data Services
    Wait Until Page Contains Element    ${titleDatabaseAccess}
    Select Database Instance From Create Button DropDown

User Selects DBProvider And Provider Account
    [Arguments]    ${isv_name}=${isv}
    Wait Until Element Is Visible    ${drpDwnDBProvider}    timeout=20s
    Wait Until Keyword Succeeds    10s    1s    Toggle Database Provider Drop Down ${isv_name}
    Wait Until Page Contains Element    ${drpDwnDevCatProvAcc}     timeout=10s
    Select From List By Label    ${drpDwnDevCatProvAcc}     ${provaccname}

Toggle Database Provider Drop Down ${isv_name}
    Select From List By Label    ${drpDwnDBProvider}    Select database provider
    Select From List By Label    ${drpDwnDBProvider}    ${isv_name}
    Element Should Be Visible    ${drpDwnProvAccOptn}

User Enters Data To Create CrunchyDB Database Instance On Admin View
    User Selects DBProvider And Provider Account
    ${instanceName}=    Get Instance Name   adm
    Set Test Variable    ${instanceName}
    Input Text    ${txtBxInstName}    ${instanceName}
    Element Should Be Visible    ${btnCreateEnabled}
    Click Element    ${btnCreateEnabled}

User Enters Data To Create CrunchyDB Database Instance On Dev
    [Arguments]    ${isv}=Crunchy Bridge managed PostgreSQL
    ${instanceName}=    Get Instance Name   dev
    Set Test Variable    ${instanceName}
    Input Text    ${txtBxInstName}    ${instanceName}
    Element Should Be Visible    ${btnCreateEnabled}
    Click Element    ${btnCreateEnabled}
    Element Should Be Visible    ${txtCreatingDBInst}

DBSC Instance Provisioned And Deployed On Developer Topology Graph View
    DBSC Instance Provisioned Successfully
    DBSC Instance Available On DataBase Access Page
    DBSC Instance Deployed Successfully

DBSC Instance Provisioned Successfully
    Wait Until Element Is Visible    ${txtInstCreated}    timeout=25s
    Element Should Be Visible    ${txtCreationInfo}
    Element Should Be Visible    ${btnViewInst}
    Click Button    ${btnViewInst}

DBSC Instance Available On DataBase Access Page
    Wait Until Page Contains Element    ${titleDatabaseAccess}    timeout=10s
    Element Should Be Visible    ${txtBxSearchByName}
    Input Text    ${txtBxSearchByName}    ${instanceName}
    ${elemInstanceNameUpd}=    Replace String    ${elemInstanceName}    <<inst-name>>    ${instanceName}
    ${elemInstProvNameUpd}=    Replace String    ${elemInstProvName}    <<inst-name>>    ${instanceName}
    ${elemInstProvNameUpd}=    Replace String    ${elemInstProvNameUpd}    <<paname>>    ${provaccname}
    Element Should Be Visible    ${elemInstanceNameUpd}
    Element Should Be Visible    ${elemInstProvNameUpd}

DBSC Instance Deployed Successfully
    User Navigates To Connect Crunchy Bridge Screen On Developers View
    User Filters And Selects The Created Database Instance
    DBSC Instance Deployed On Developer Topology Graph View

DBSC Instance Retrieval Failed
    Wait Until Element Is Visible    ${txtInstFailHead}
    Element Should Be Visible    ${txtInstFailMsg}
    Element Should Be Visible    ${btnTryAgain}
    Element Should Be Visible    ${btnClose}
    Click Button    ${btnClose}
