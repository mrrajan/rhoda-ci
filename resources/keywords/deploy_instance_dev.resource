*** Settings ***
Resource    ../keywords/import_provider_account.resource
Resource    ../object_repo/developer_catalog_obj.resource
Resource    ../object_repo/provision_dbinstance_obj.resource

*** Variables ***
${newProject}        ${EMPTY}
${instanceName}      ${EMPTY}

*** Keywords ***
User Selects A Project For Database Connection
    Run Keyword If    '${newProject}'=='${EMPTY}'
    ...    Create New Project
    ...  ELSE    Run Keywords
    ...    Log To Console    Project ${newProject} exists
    ...    AND    Set Project Namespace To ${newProject}

Create New Project
    Wait Until Page Contains Element    ${drpDwnProjectSelect}    timeout=15s
    Click Element    ${drpDwnProjectSelect}
    Wait Until Page Contains Element    ${btnCreateProject}
    Click Element    ${btnCreateProject}
    Wait Until Page Contains Element    ${hdrCreateProject}
    ${newProject}=     Get Project Name    ${TEST TAGS}
    Set Suite Variable    ${newProject}
    Input Text    ${txtBxProjectName}    ${newProject}
    Click Element    ${btnConfirmCreate}
    ${lblProjectSelectUpd}=     Replace String    ${lblProjectSelect}    <<project>>    ${newProject}
    Element Should Not Be Visible    ${txtProjectCreateError}
    Wait Until Page Contains Element    ${lblProjectSelectUpd}

Set Project Namespace To ${proj}
    Wait Until Page Contains Element    ${drpDwnProjectSelect}    timeout=15s
    Click Element    ${drpDwnProjectSelect}
    ${btnProjectSelectUpd}=    Replace String    ${btnProjectSelect}    <<project>>    ${proj}
    ${lblProjectSelectUpd}=    Replace String    ${lblProjectSelect}    <<project>>    ${proj}
    Wait Until Page Contains Element    ${btnProjectSelectUpd}    timeout=5s
    Click Element    ${btnProjectSelectUpd}
    Element Should Be Visible    ${lblProjectSelectUpd}

User Navigates To Add ${databaseProvider} To Topology Screen
    User Selects Developer View
    User Selects A Project For Database Connection
    User Navigates To Developers Catalog Add Screen
    User Clicks On Cloud Hosted Database Menu
    User Selects ${databaseProvider} Tile Under Cloud Hosted Database
    Click Element    ${btnDBProvAddTopology}

User Navigates To Developers Catalog Add Screen
    Wait Until Page Contains Element    ${lnkAdd}
    Click Element    ${lnkAdd}

User Clicks On Cloud Hosted Database Menu
    Wait Until Page Contains Element    ${lnkCloudHostMenu}
    Click Element    ${lnkCloudHostMenu}
    Wait Until Page Contains Element    ${hdrCloudHostDBScreen}     timeout=10s

User Selects ${databaseProvider} Tile Under Cloud Hosted Database
    ${lnkDBProviderTileUpd}=    Replace String    ${lnkDBProviderTile}    <<dbprovider>>    ${databaseProvider}
    Wait Until Page Contains Element    ${lnkDBProviderTileUpd}
    Click Element    ${lnkDBProviderTileUpd}
    ${hdrDBProviderModalUpd}=   Replace String    ${hdrDBProviderModal}    <<dbprovider>>    ${databaseProvider}
    Element Should Be Visible    ${hdrCloudHostDBScreen}

User Selects Database Instance For The Provider Account
    Wait Until Keyword Succeeds     5x     1s      Wait Until Page Contains Element    ${drpDwnDevProvAccount}
    Select From List By Label    ${drpDwnDevProvAccount}     ${provaccname}
    ${instanceName}=    Select Database Instance    ${tblDevDBInstance}    ${btnDevDBInstanceConnect}    ${txtAlreadyExists}
    User Clicks Continue On Topoloy Binding Instructions
    Set Suite Variable    ${instanceName}

User Filters And Selects The Created Database Instance
    Wait Until Page Contains Element    ${drpDwnDevProvAccount}     timeout=10s
    Select From List By Label    ${drpDwnDevProvAccount}     ${provaccname}
    Element Should Be Visible    ${txtBxSearchByName}
    Input Text    ${txtBxSearchByName}    ${instanceName}
    ${elemInstanceRadioUpd}=    Replace String    ${elemInstanceRadio}    <<inst-name>>    ${instanceName}
    Element Should Be Visible    ${elemInstanceRadioUpd}
    Click Element    ${elemInstanceRadioUpd}
    Scroll Element Into View    ${btnConnectInst}
    Click Button    ${btnConnectInst}

Set ${type} View On Topology View
    Wait Until Page Contains Element    ${btnDevTopViewSwitch}     timeout=10s
    ${currentView}=     Get Element Attribute    ${btnDevTopViewSwitch}    aria-label
    Run Keyword If    "${type}" in """${currentView}"""
    ...    Click Element    ${btnDevTopViewSwitch}
    ${btnTopologyViewUpd}=    Replace String    ${btnTopologyView}    <<type>>    ${type}
    Element Should Not Be Visible    ${btnTopologyViewUpd}

DBSC Instance Deployed On Developer Topology Graph View
    Wait Until Keyword Succeeds     10x     2s      Wait Until Page Contains Element    ${txtBxDisplayOptions}
    Set Graph View On Topology View
    ${instance}=    Get Substring    ${instanceName}    0   6
    ${elemDBInstTopologyUpd}=       Replace String    ${elemDBInstTopology}    <<instance>>    ${instance}
    Wait Until Page Contains Element    ${elemDBInstTopologyUpd}    timeout=10s
    Click Element    ${elemDBInstTopologyUpd}
    DBSC Instance Pan Displays

DBSC Instance Deployed On Developer Topology List View
    Wait Until Keyword Succeeds     10x     2s      Wait Until Page Contains Element    ${txtBxDisplayOptions}
    Set List View On Topology View
    ${txtTopListInstanceUpd}=       Replace String    ${txtTopListInstance}    <<instance>>    ${instanceName}
    Wait Until Page Contains Element    ${txtTopListInstanceUpd}  timeout=10s
    Click Element    ${txtTopListInstanceUpd}
    DBSC Instance Pan Displays

DBSC Instance Pan Displays
    ${elemTopInstancePanUpd}=     Replace String    ${elemTopInstancePan}    <<instance>>    ${instanceName}
    Wait Until Page Contains Element    ${elemTopInstancePanUpd}    timeout=10s

User Clicks Continue On Topoloy Binding Instructions
    Wait Until Page Contains Element    ${hdrTopBindInstr}      timeout=10s
    Click Element    ${btnTopBindContinue}
