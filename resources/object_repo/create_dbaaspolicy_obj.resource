*** Comments ***
Object Repository for DBaaSPolicies Screen


*** Variables ***
${txtNoDBaaSPolicy}             //div[.="No operands found"]
${lblOperand}                   //label[contains(.,"Current namespace only")]
${btnCreateDBaaSPolicy}         //button[contains(@id,"yaml-create") and (.="Create DBaaSPolicy")]
${titleCreateDBaaSPolicy}       //span[.="Create DBaaSPolicy"]
${txtBxDBaaSPolicyName}         id:root_metadata_name
${btnToggleConnNS}              id:root_spec_connectionNamespaces_accordion-toggle
${btnAddConnNS}                 id:root_spec_connectionNamespaces_add-btn
${txtBxConnNS}                  //input[contains(@id,"root_spec_connectionNamespaces")]
${lnkDBaaSPolicyName}           //a[contains(@href,"DBaaSPolicy") and (.="<<policyname>>")]
${errDBaaSPolicyForbid}         //li[contains(.,"dbaaspolicies.dbaas.redhat.com is forbidden")]
${radFormView}                  //label[contains(.,"Form view")]
${txtQuotaError}                //div[@aria-label="Danger Alert"]//ul[contains(.,"exceeded quota")]
${btnToggleConnNSSelect}        id:root_spec_connectionNsSelector_accordion-toggle
${btnToggleMatchExp}            id:root_spec_connectionNsSelector_matchExpressions_accordion-toggle
${btnAddMatchExp}               id:root_spec_connectionNsSelector_matchExpressions_add-btn
${txtBxAddConnValue}            //input[@id="root_spec_connectionNamespaces_<<index>>"]
${txtBxAddConnNsKey}            //input[@id="root_spec_connectionNsSelector_matchExpressions_<<index>>_key"]
${txtBxAddConnOper}             //input[@id="root_spec_connectionNsSelector_matchExpressions_<<index>>_operator"]
${btnAddConnNSToggle}           //button[@id="root_spec_connectionNsSelector_matchExpressions_<<index>>_values_accordion-toggle"]
${btnAddConnNsValue}            //button[@id="root_spec_connectionNsSelector_matchExpressions_<<index>>_values_add-btn"]
${txtBxAddConnNsValue}          //button[@id="root_spec_connectionNsSelector_matchExpressions_<<index>>_values_<<index2>>"]
