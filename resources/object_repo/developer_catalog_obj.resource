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
${lnkTopology}                  //a[contains(.,"Topology")]
${elemIconDeployment}           //*[name()="g" and contains(@class,"odc-base")]/*[name()="text" and contains(.,"<<appname>>")]
${elemDeployPod}                //span[contains(.,"Pod")]//a[contains(@data-test-id,"<<appname>>")]
${txtPodStatus}                 //span[@data-test="status-text"]
${hdrDeploymentPan}             //h1//a[(.="<<appname>>")]
${btnPanActionMenu}             //button/span[.="Actions"]
${btnCreateServiceBinding}      //button/span[.="Create Service Binding"]
${hdrModelServiceBinding}       //h1[.="Create Service Binding"]
${txtBxBindingName}             //input[@id="form-input-name-field"]
${lnkBindService}               //a/span[contains(.,"<<instance>>")]
${btnBindingService}            //button[@id="form-ns-dropdown-service-field"]
${lblBindingSelected}           //button[contains(.,"<<instance>>") and contains(@id,"form-ns-dropdown-service-field")]
${hdrTopBindInstr}              //h1[.="Topology View Binding Instructions"]
${btnTopBindClose}              //button[@aria-label="Close"]
${btnTopBindContinue}           //button[.="Continue" and @aria-disabled="false"]
${elemSrvcBindArrow}            //*[name()="g" and @data-type="service-binding"]
${lnkPanInstance}               //a[contains(@href,"DBaaSConnection")]
${txtAppPodStatus}              //span[contains(.,"<<appname>>")]//following-sibling::span//span[@data-test="status-text" and (.="Running")]
${btnClosePan}                  //button[@data-test-id="sidebar-close-button"]
${txtApplication}               //*[.="<<appname>>"]/parent::*[name()="g"]
${lnkAppRoute}                  //h2[.="Routes"]/following::div/a
${txtNoDBInstExist}             //div[contains(@class,"pf-c-empty-state__content")]
${txtNoDBInstance}              //h2[contains(.,"No Database Instances")]
${lnkImportProvAcc}             //a[contains(.,"Import a Provider Account")]

