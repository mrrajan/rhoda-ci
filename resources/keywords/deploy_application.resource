*** Settings ***
Resource        ../keywords/deploy_instance_dev.resource
Resource        ../object_repo/import_yaml_obj.resource
Resource        ../object_repo/application_obj.resource
Library         String


*** Variables ***
${appname}      ${EMPTY}
${bindName}     ${EMPTY}

*** Keywords ***
User Imports Openshift ${databaseProvider} Application From YAML
    User Navigates To Import YAML Page
    Write Yaml To Textbox    ${databaseProvider}    ${elemImportTextArea}
    Element Should Be Visible    ${btnImportYamlCreate}
    Click Element    ${btnImportYamlCreate}
    Wait Until Page Contains Element    ${txtImportSuccess}     timeout=20s

User Navigates To Import YAML Page
    Element Should Be Visible    ${lnkImportYaml}
    Click Element    ${lnkImportYaml}
    Wait Until Keyword Succeeds    5x    2s    Wait Until Page Contains Element    ${hdrImportYamlPg}
    Element Should Be Visible    ${elemImportTextArea}

User Creates Service Binding Between ${databaseProvider} DBSC Instance And Imported Openshift Application
    Click Element    ${lnkTopology}
    ${appname}=     Get Import Application Name    ${databaseProvider}
    Set Test Variable    ${appname}
    ${bindName}=    Update Service Binding    ${newProject}    ${instanceUUID}    ${appname}
    Set Test Variable    ${bindName}
    Create Service Binding      ${newProject}
    Wait Until Keyword Succeeds    3x    2s     Wait Until Page Contains Element    ${elemSrvcBindArrow}
    Click Element   ${elemSrvcBindArrow}
    ${elemIconDeploymentUpd}=       Replace String    ${elemIconDeployment}    <<appname>>    ${appname}
    Instance Pan Displays   ${bindName}

User Selects Openshift Application For ${databaseProvider}
    Element Should Be Visible    ${lnkTopology}
    Click Element    ${lnkTopology}
    ${appname}=     Get Import Application Name    ${databaseProvider}
    Set Test Variable    ${appname}
    ${elemIconDeploymentUpd}=       Replace String    ${elemIconDeployment}    <<appname>>    ${appname}
    Wait Until Page Contains Element    ${elemIconDeploymentUpd}
    Click Element    ${elemIconDeploymentUpd}
    ${hdrDeploymentPanUpd}=       Replace String    ${hdrDeploymentPan}    <<appname>>    ${appname}
    Wait Until Page Contains Element    ${hdrDeploymentPanUpd}
    Wait Until Keyword Succeeds    5x    1s    Application Pod Loads With Running Status

Application Pod Loads With ${given} Status
    ${podstatus}=   Get Element Attribute    ${txtPodStatus}    innerText
    Should Match    ${given}    ${podstatus}

The Application Accesses The Connected ${database} Database Instance
    Application Pod In Running Status
    Access Data From Connected ${database} Instance

Application Pod In Running Status
     Close Topology Pan
    ${txtApplicationUpd}=  Replace String    ${txtApplication}  <<appname>>    ${appname}
    Click Element    ${txtApplicationUpd}
    ${txtAppPodStatusUpd}=     Replace String    ${txtAppPodStatus}    <<appname>>    ${appname}
    Wait Until Keyword Succeeds    10x    1s    Wait Until Page Contains Element    ${txtAppPodStatusUpd}

Close Topology Pan
    ${status}=  Run Keyword And Return Status    Element Should Be Visible    ${btnClosePan}
    Run Keyword If    ${status}
    ...    Click Element    ${btnClosePan}

Access Data From Connected ${database} Instance
    ${linkName}=    Catenate    SEPARATOR=-     ${appname}      ${newProject}
    ${Application_URL}=     Get Quarkus Application URL   ${OCP_CONSOLE_URL}      ${linkName}
    Execute Javascript      window.open("${Application_URL}")
    Switch Window   url:${Application_URL}
    Load Data To ${database} Database From Application

Load Data To ${database} Database From Application
    Run Keyword If    "Mongo" in """${database}"""
    ...    Load Data To Mongo Application

Load Data To Mongo Application
    ${appStatus}=    Run Keyword And Return Status    Element Should Be Visible    ${hdrFruitApp}
    Run Keyword If    not ${appStatus}
    ...    Reload Page
    Run Keyword And Return Status    Element Should Be Visible    ${hdrFruitApp}
    ${fruitname}=   Random String
    Input Text    ${txtBxFruitName}    ${fruitname}
    ${description}=     Random String
    Input Text    ${txtBxDescription}    ${description}
    Click Element    ${btnSave}
    ${txtFruitListUpd}=     Replace String    ${txtFruitList}    <<fruit>>    ${fruitname}
    ${txtFruitListUpd}=     Replace String    ${txtFruitListUpd}    <<desc>>    ${description}
    ${status}=  Run Keyword And Return Status    Wait Until Page Contains Element    ${txtFruitListUpd}  timeout=5s
    Run Keyword If  ${status}
    ...     Log   Connection Loads Data As Expected
    ...  ELSE
    ...    Log  Connection Failed! Check IP Configuration For the Mongo DB Instance on ISV   WARN

