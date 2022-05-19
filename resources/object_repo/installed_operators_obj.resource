*** Comments ***
Object Repository for Installed Operators Screen


*** Variables ***
${elemDbaasStatus}          //a[contains(.,"OpenShift Database Access Operator")]//ancestor::tr/td[contains(.,"Succeeded")]
${titleDbaasOperator}       //h1[contains(.,"OpenShift Database Access Operator") and contains(@class,"logo__name")]
${elemDbaasInvStatus}       //td[contains(.,"<<paname>>")]/parent::tr/td[contains(.,"SpecSynced, InventoryReady")]
${titleDbaasInventories}    //h1[contains(.,"DBaaSInventories")]
${lnkProvAcc}               //a[contains(.,"OpenShift Database Access Operator")]//ancestor::tr//a[contains(.,"Provider Account")]
${btnLastUpdatedHeader}     //th[contains(@data-label,"Last updated")]
${btnInventoryFilterType}   //button[contains(@data-test-id,"dropdown-button")]
${btnInventoryFilterName}   id:NAME-Link
${txtBxSearchByName}        //input[contains(@aria-label,"Search by name")]

