*** Comments ***
Object Repository for DBaaSInvertories Screen


*** Variables ***
${titleImportProviderAcc}       //div[@class="section-title" and contains(.,"Import Database Provider Account")]
${txtInvalidNamespace}          //h4[contains(.,"Invalid Namespace")]
${btnImportDisabled}            //button[contains(.,"Import") and @aria-disabled="true"]
${btnCancelEnabled}             //button[contains(.,"Cancel") and @aria-disabled="false"]
${txtBxName}                    id:inventory-name
${drpDwnDBProvider}             //select[contains(@aria-label,"Database Provider")]
${txtBxMongoDBOrgID}            id:mongodb-atlas-registration-orgId
${txtBxMongoDBPubAPI}           id:mongodb-atlas-registration-publicApiKey
${txtBxMongoDBPrivAPI}          id:mongodb-atlas-registration-privateApiKey
${txtBxCrunchyPubAPI}           id:crunchy-bridge-registration-publicApiKey
${txtBxCrunchyPrivAPI}          id:crunchy-bridge-registration-privateApiSecret
${txtBxCockroachAPI}            id:cockroachdb-cloud-registration-apiSecretKey
${btnImportEnabled}             //button[contains(.,"Import") and @aria-disabled="false"]
${lblDBInstSuccess}             //h2[contains(.,"Database instances") and contains(.,"successful")]
${btnViewProviderAcc}           //button[contains(.,"View Provider Accounts")]
${tblInstanceTable}             id:instance-table
${btnMenuDropDown}              //button[contains(.,"<<menu>>")]
${btnMenuOptDropDown}           //a[contains(.,"<<menuopt>>")]
${tblDBProviderAcc}             id:instance-connection-status-table
${lblDBInstFailure}             //h2[contains(.,"Database instances") and contains(.,"failed")]
${txtInvCred}                   //div[contains(.,"Invalid credentials")]
${btnEditProvAcc}               //button[contains(.,"Edit Provider") and @aria-disabled="false"]
