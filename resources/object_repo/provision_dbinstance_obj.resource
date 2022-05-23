*** Comments ***
Object Repository for Create Database Instance Screen


*** Variables ***
${txtBxInstName}                 //input[@id='instance-name']
${elemInstanceRadio}             //td[contains(.,"<<inst-name>>")]/parent::tr//input[@aria-label="Select row 0"]
${btnConnectInst}                //button[@id='instance-select-button']
${txtCreatingDBInst}             //h3[contains(.,"Creating Database Instance...")]
${txtInstCreated}                //h2[contains(.,"Database instance creation started")]
${txtCreationInfo}               //div[contains(.,"The database instance is being created")]
${btnViewInst}                   //button[contains(.,"View Instances") and @aria-disabled="false"]
${txtInstFailHead}               //h2[contains(.,"Provider account information retrieval failed")]
${txtInstFailMsg}                //div[contains(.,"Please try again")]
${btnTryAgain}                   //button[contains(.,"Try Again") and @aria-disabled="false"]
${btnClose}                      //button[contains(.,"Close") and @aria-disabled="false"]
${drpDwnProvAccOptn}             //select[contains(@aria-label,"Provider Account")]/option
