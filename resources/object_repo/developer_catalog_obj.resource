*** Comments ***
Object Repository for +Add Developer Catalog Screen on Developers View


*** Variables ***
${lnkAdd}                       //a[contains(.,"+Add")]
${btnCreateProject}             //button[contains(.,"Create Project")]
${hdrCreateProject}             //h1[contains(.,"Create Project")]
${txtBxProjectName}             id:input-name
${btnConfirmCreate}             id:confirm-action
${txtProjectCreateError}        //h4[contains(@class,"alert__title")]
${lnkConnectedDBMenu}           //a[contains(.,"Connected Database")]
${hdrConnectedDBScreen}         //h1/div[contains(.,"Connected Database")]
${lnkDBProviderTile}            //div[contains(.,"<<dbprovider>>")]/parent::a[contains(@class,"catalog-tile")]
${hdrDBProviderModal}           //h1[contains(.,"Mongo") and contains(@class,"title")]
${btnDBProviderConnect}         //div[contains(@class,"overlay-action")]//a[contains(.,"Connect")]
${hdrDBProviderConnectScreen}   //h1[contains(.,"Connect") and contains (.,"<<dbprovider>>")]
${drpDwnDevCatProviderAccount}  //select[contains(@aria-label,"Provider Account")]
${tableDevCatDatabaseInstance}  //table[contains(@aria-label,"Instance Table")]//tbody/tr
${btnDevCatDBInstanceConnect}   id:instance-select-button
${txtAlreadyExists}             //h4[contains(.,"AlreadyExists")]
${elemDBInstanceTopology}       //*[name()="g" and @class="odc-operator-backed-service" and (contains(.,"<<instance>>"))]
${btnDevTopologyViewSwitch}     //button[@data-test-id="topology-switcher-view"]
${btnTopologyView}              //button[@data-test-id="topology-switcher-view" and contains(@aria-label,"<<type>>")]
${elemTopologyInstancePan}      //a[contains(.,"<<instance>>")]
${txtTopologyListInstance}      //span[contains(.,"DBaaS")]/parent::div[contains(.,"<<instance>>")]
${txtBxDisplayOptions}          //span[contains(.,"Display options")]
