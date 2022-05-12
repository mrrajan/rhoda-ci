*** Settings ***
Resource    ../keywords/create_provider_account.resource
Resource    ../object_repo/developer_catalog_obj.resource

*** Variables ***
${newProject}      ${EMPTY}
${instanceName}      ${EMPTY}

*** Keywords ***
User Selects A Project For Database Connection
    Run Keyword If    '${newProject}'=='${EMPTY}'
    ...    Create New Project
    ...  ELSE
    ...    Log To Console    Project ${newProject} exists

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
    Element Should Not Be Visible    ${txtProjectCreateError}

User Navigates To Connect ${databaseProvider} Screen On Developers View
    User Selects Developer View
    User Closes Welcome Message
    User Selects A Project For Database Connection
    User Navigates To Developers Catalog Add Screen
    User Clicks On Connected Database Menu
    User Selects ${databaseProvider} Tile Under Connected Database
    Click Element    ${btnDBProviderConnect}

User Navigates To Developers Catalog Add Screen
    Wait Until Page Contains Element    ${lnkAdd}
    Click Element    ${lnkAdd}

User Clicks On Connected Database Menu
    Wait Until Page Contains Element    ${lnkConnectedDBMenu}
    Click Element    ${lnkConnectedDBMenu}
    Wait Until Page Contains Element    ${hdrConnectedDBScreen}     timeout=10s

User Selects ${databaseProvider} Tile Under Connected Database
    ${lnkDBProviderTileUpd}=    Replace String    ${lnkDBProviderTile}    <<dbprovider>>    ${databaseProvider}
    Wait Until Page Contains Element    ${lnkDBProviderTileUpd}
    Click Element    ${lnkDBProviderTileUpd}
    ${hdrDBProviderModalUpd}=   Replace String    ${hdrDBProviderModal}    <<dbprovider>>    ${databaseProvider}
    Element Should Be Visible    ${hdrConnectedDBScreen}

User Selects Database Instance For The Provider Account
    Wait Until Page Contains Element    ${drpDwnDevCatProviderAccount}     timeout=10s
    Select From List By Label    ${drpDwnDevCatProviderAccount}     ${provaccname}
    ${instanceName}=    Select Database Instance    ${tableDevCatDatabaseInstance}    ${btnDevCatDBInstanceConnect}    ${txtAlreadyExists}
    Set Suite Variable    ${instanceName}

User Changes Topology View To List View
    Wait Until Page Contains Element    ${btnDevTopologyViewSwitch}     timeout=10s
    ${currentView}=     Get Element Attribute    ${btnDevTopologyViewSwitch}    aria-label
    Run Keyword If    '${currentView}'=='List view'
    ...    Click Element    ${currentView}
    Element Should Be Visible    ${elemGraphView}

DBSC Instance Deployed On Developer Topology Graph View
    Wait Until Keyword Succeeds     10x     2s      Wait Until Page Contains Element    ${txtBxDisplayOptions}
    ${instance}=    Get Substring    ${instanceName}    0   6
    ${elemDBInstanceTopologyUpd}=       Replace String    ${elemDBInstanceTopology}    <<instance>>    ${instance}
    Wait Until Page Contains Element    ${elemDBInstanceTopologyUpd}    timeout=10s
    Click Element    ${elemDBInstanceTopologyUpd}
    DBSC Instance Pan Displays

DBSC Instance Deployed On Developer Topology List View
    Wait Until Keyword Succeeds     10x     2s      Wait Until Page Contains Element    ${txtBxDisplayOptions}
    User Changes Topology View To List View
    ${txtTopologyListInstanceUpd}=       Replace String    ${txtTopologyListInstance}    <<instance>>    ${instanceName}
    Wait Until Page Contains Element    ${txtTopologyListInstanceUpd}  timeout=10s
    Click Element    ${txtTopologyListInstanceUpd}
    DBSC Instance Pan Displays

DBSC Instance Pan Displays
    ${elemTopologyInstancePanUpd}=     Replace String    ${elemTopologyInstancePan}    <<instance>>    ${instanceName}
    Wait Until Page Contains Element    ${elemTopologyInstancePanUpd}    timeout=10s

