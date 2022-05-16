*** Settings ***
Resource    ../keywords/create_provider_account.resource
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
    Wait Until Page Contains Element    ${drpDwnDevCatProvAcc}     timeout=10s
    Select From List By Label    ${drpDwnDevCatProvAcc}     ${provaccname}
    ${instanceName}=    Select Database Instance    ${tableDevCatDatabaseInstance}    ${btnDevCatDBInstanceConnect}    ${txtAlreadyExists}
    Set Suite Variable    ${instanceName}

User Filters And Selects The Created Database Instance
    Wait Until Page Contains Element    ${drpDwnDevCatProvAcc}     timeout=10s
    Select From List By Label    ${drpDwnDevCatProvAcc}     ${provaccname}
    Element Should Be Visible    ${txtBxSearchByName}
    Input Text    ${txtBxSearchByName}    ${instanceName}
    ${elemInstanceRadioUpd}=    Replace String    ${elemInstanceRadio}    <<inst-name>>    ${instanceName}
    Element Should Be Visible    ${elemInstanceRadioUpd}
    Click Element    ${elemInstanceRadioUpd}
    Scroll Element Into View    ${btnConnectInst}
    Click Button    ${btnConnectInst}

Set ${type} View On Topology View
    Wait Until Page Contains Element    ${btnDevTopologyViewSwitch}     timeout=10s
    ${currentView}=     Get Element Attribute    ${btnDevTopologyViewSwitch}    aria-label
    Run Keyword If    "${type}" in """${currentView}"""
    ...    Click Element    ${btnDevTopologyViewSwitch}
    ${btnTopologyViewUpd}=    Replace String    ${btnTopologyView}    <<type>>    ${type}
    Element Should Not Be Visible    ${btnTopologyViewUpd}

DBSC Instance Deployed On Developer Topology Graph View
    Wait Until Keyword Succeeds     10x     2s      Wait Until Page Contains Element    ${txtBxDisplayOptions}
    Set Graph View On Topology View
    ${instance}=    Get Substring    ${instanceName}    0   6
    ${elemDBInstanceTopologyUpd}=       Replace String    ${elemDBInstanceTopology}    <<instance>>    ${instance}
    Wait Until Page Contains Element    ${elemDBInstanceTopologyUpd}    timeout=10s
    Click Element    ${elemDBInstanceTopologyUpd}
    DBSC Instance Pan Displays

DBSC Instance Deployed On Developer Topology List View
    Wait Until Keyword Succeeds     10x     2s      Wait Until Page Contains Element    ${txtBxDisplayOptions}
    Set List View On Topology View
    ${txtTopologyListInstanceUpd}=       Replace String    ${txtTopologyListInstance}    <<instance>>    ${instanceName}
    Wait Until Page Contains Element    ${txtTopologyListInstanceUpd}  timeout=10s
    Click Element    ${txtTopologyListInstanceUpd}
    DBSC Instance Pan Displays

DBSC Instance Pan Displays
    ${elemTopologyInstancePanUpd}=     Replace String    ${elemTopologyInstancePan}    <<instance>>    ${instanceName}
    Wait Until Page Contains Element    ${elemTopologyInstancePanUpd}    timeout=15s
