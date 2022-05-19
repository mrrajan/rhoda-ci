*** Comments ***
Object Repository for +Add Developer Catalog Screen on Developers View


*** Variables ***
${lnkAdd}                       //a[contains(.,"+Add")]
${btnCreateProject}             //button[contains(.,"Create Project")]
${hdrCreateProject}             //h1[contains(.,"Create Project")]
${txtBxProjectName}             id:input-name
${btnConfirmCreate}             id:confirm-action
${txtProjectCreateError}        //h4[contains(@class,"alert__title")]
${lnkCloudHostMenu}             //a[contains(.,"Cloud-Hosted Database")]
${hdrCloudHostDBScreen}         //h1/div[contains(.,"Cloud-Hosted Database")]
${lnkDBProviderTile}            //div[contains(.,"<<dbprovider>>")]/parent::a[contains(@class,"catalog-tile")]
${hdrDBProviderModal}           //h1[contains(.,"<<dbprovider>>") and contains(@class,"title")]
${btnDBProvAddTopology}         //div[contains(@class,"overlay-action")]//a[contains(.,"Add to Topology")]
${hdrDBProvConnectScreen}       //h1[contains(.,"Connect") and contains (.,"<<dbprovider>>")]
${drpDwnDevProvAccount}         //select[contains(@aria-label,"Provider Account")]
${tblDevDBInstance}             //table[contains(@aria-label,"Instance Table")]//tbody/tr
${btnDevDBInstanceConnect}      id:instance-select-button
${txtAlreadyExists}             //h4[contains(.,"AlreadyExists")]
${elemDBInstTopology}           //*[name()="g" and @class="odc-operator-backed-service" and (contains(.,"<<instance>>"))]
${btnDevTopViewSwitch}          //button[@data-test-id="topology-switcher-view"]
${btnTopologyView}              //button[@data-test-id="topology-switcher-view" and contains(@aria-label,"<<type>>")]
${elemTopInstancePan}           //a[contains(.,"<<instance>>")]
${txtTopListInstance}           //span[contains(.,"DBaaS")]/parent::div[contains(.,"<<instance>>")]
${txtBxDisplayOptions}          //span[contains(.,"Display options")]
