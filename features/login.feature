#checking the branch is working
Feature: Opening  into Zenith Application

  Background: Login to the Application
    When I enter the credentials to the Zenith application

  @US-003041_1
  Scenario: US-003041:Verify Fields Batch Type and Client Batch Year on Asset
    When I navigate to Opportunity Asset tab
    Then I open new OpportunityAsset
    Then I verify the type of Batch Type field
    And verify labels Batch Type on Asset is required field
    Then verify if the Client Batch Year is a text field
    And verify labels Client Batch Year on Asset is required field

  @US-003041_2
  Scenario: US-003041:Verify Fields Batch Type and Client Batch Year on Asset
    When I navigate to Opportunity Asset tab
    Then I open existing OpportunityAsset
    Then I verify the type of Batch Type field
    And verify labels Batch Type on Asset is required field
    Then verify if the Client Batch Year is a text field
    And verify labels Client Batch Year on Asset is required field

  @US-003042_1
  Scenario: US-003042:Verify the Product group
    When I navigate to Opportunity Asset tab
    Then I open new OpportunityAsset
    And I verify the product group field
    And I verify label Product Group on Asset is required field or not
    Then I verify the product group type
    Then verify the product group field is editable or not for OperationRep
    Then I verify the values present in Product group field
    Then create new Opportunity Asset by entering all mandatory fields
    And save the Opportunity Asset
    Then edit the Opportunity Asset
    And select the value for product group field
    And save the Opportunity Asset

  @US-003042_2
  Scenario: US-003042:Verify the Product group
    And click on Opportunity Asset tab
    Then open on any existing Opportunity Asset as SalesOps
    And I verify the product group field
    Then verify the product group field is editable or not

  @US-003044_1
  Scenario: US-003044:Verify the PO Submitted Amount field
    When I navigate to Opportunity Asset tab
    Then I open new OpportunityAsset
    And I verify the PO Submitted Amount field is present or not
    Then check "PO Submitted Amount" is editable or not editable
    And I verify label PO Submitted Amount on Asset as required field or not
    And I verify the PO Submitted Amount type
    Then create new Opportunity Asset by entering all mandatory fields for PO Submitted Amount
    And save the Opportunity Asset
    Then edit the Opportunity Asset
    And enter the value for PO Submitted Amount field
    And save the Opportunity Asset

  @US-003044_2
  Scenario: US-003044:Verify the PO Submitted Amount field
    And click on Opportunity Asset tab
    And Select "Opportunity Asset - Renewal" from View list
    Then open any existing Opportunity Asset from the list to verify the PO Submitted Amount
    Then edit the Opportunity Asset
    Then check "PO Submitted Amount" is editable or not editable

  @US-003045_1
  Scenario: US-003045: PO Submission Date field
    When I navigate to Opportunity tab
    Then click on new Opportunity
    Then enter the data to mandatory field to create the Opportunity
    And save the Opportunity
    And select Edit button
    And verify the 'PO Submission Date field' field is editable or not
    And verify PO Submission Date field is mandatory
    And verify the PO Submission Date field type
    And PO Submission Date field is populated
    And save the Opportunity

  @US-003045_2
  Scenario: US-003045: PO Submission Date field
    When I navigate to Opportunity tab
    And Select "Recently Viewed Opportunity" from View list
    Then open any existing Opportunity from the list
    And verify the PO Submitted Date field
    Then Double click into PO Submitted Date field

  @US-003046_1
  Scenario: US-003046:Verify the Discount Amount
    When I navigate to Quotes tab
    And select all Quotes
    Then click on go button
    Then select any quote
    And select Edit button
    Then I verify the Discount Amount field is available or not
    And I verify the Discount Amount field is not mandatory
    And I verify the Discount Amount field type
    And check the Discount Amount field is read writeable mode
    Then enter the value for Discount Amount field
    And click on Save button to save Quote
    Then Validate the Discount Amount field value

  @US-003046_2
  Scenario: US-003046:Verify the Discount Amount field
    When I navigate to Quotes tab
    And select all Quotes
    Then click on go button
    Then select any quote
    Then I verify the Discount Amount field is available or not
    And check the Discount Amount field is read only mode

  @US-003047
  Scenario: US-003047 :Opportunity Type picklist values
    When I navigate to Opportunity tab
    And Select "Recently Viewed Opportunity" from View list
    Then open any existing Opportunity from the list
    And select Edit button
    Then verify the Opportunity type field is available
    And verify the Opportunity type field is editable
    And check the Opportunity Type is mandatory
    And verify the Opportunity type field type
    And verify the picklist value of Opportunity type field
    And save the Opportunity

  @US-003048
  Scenario: US-003048 :Direct or Channel picklist values
    When I navigate to Opportunity tab
    And Select "Recently Viewed Opportunity" from View list
    Then open any existing Opportunity from the list
    And select Edit button
    Then verify the Direct or Channel field is available
    And verify the 'Direct or Channel' field is editable or not
    And check field "Direct/Channel" is mandatory
    And verify the Direct or Channel field type
    And check the picklist value of Direct or Channel
    And save the Opportunity

  @US-003049
  Scenario: US-003049 :Opportunity Currency picklist values
    When I navigate to Opportunity tab
    And Select "Recently Viewed Opportunity" from View list
    Then open any existing Opportunity from the list
    And select Edit button
    Then verify the field Opportunity Currency field is available or not
    And verify the 'Opportunity Currency' field is editable or not
    And check whether field Opportunity Currency is mandatory
    And verify the Opportunity Currency field type
    And check the picklist value of Opportunity Currency
    And save the Opportunity

  @US-003050
  Scenario: US-003050 :Client Region picklist values
    When I navigate to Opportunity tab
    And Select "Recently Viewed Opportunity" from View list
    Then open any existing Opportunity from the list
    And select Edit button
    Then verify the field Client Region is available
    And verify the 'Client Region' field is editable or not
    And check whether field Client Region is a mandatory
    And verify the Client Region field type
    And check the picklist value of Client Region
    And save the Opportunity

  @US-003051
  Scenario: US-003051 :Client Territory picklist values
    When I navigate to Opportunity tab
    And Select "Recently Viewed Opportunity" from View list
    Then open any existing Opportunity from the list
    And select Edit button
    Then I verify the field Client Territory
    And I verify the type of the field Client Territory
    And I verify the field Client Territory field is editable or not
    Then I verify the field Client Territory is mandatory or not
    And check the picklist value of Client Territory
    And save the Opportunity

  @US-003053_1
  Scenario: US-003053:Verify the Currency
    When I navigate to Quotes tab
    And click on new button
    Then I verify the field Currency in Quote
    And I verify the currency field type in Quote
    And I verify the currency field is editable or not in Quote
    Then I verify the Currency field is mandatory or not in Quote
    Then verify the picklist of the Currency in Quote

  @US-003053_2
  Scenario: US-003053:Verify the Currency
    When I navigate to Quotes tab
    And click on new button

  @US-003055_1
  Scenario: US-003055:Verify the Currency field
    When I navigate to Opportunity Asset tab
    Then I open new OpportunityAsset
    And I verify the currency field in OpportunityAsset
    Then I verify the currency field  is editable or not
    And I verify the currency field type
    Then I verify the Currency field is not mandatory in OpportunityAsset
    Then verify the values present in currency field of an OpportunityAsset

  @US-003055_2
  Scenario: US-003055:Verify the Currency field
    When I navigate to Opportunity Asset tab
    And Select "Opportunity Asset - Renewal" from View list
    Then open any existing Opportunity Asset from the list
    Then edit the Opportunity Asset
    Then verify the values present in currency field of an OpportunityAsset

  @US-003056_1
  Scenario: US-003056: Batch Type picklist values
    When I navigate to Opportunity Asset tab
    Then I open new OpportunityAsset
    And I verify field Batch Type field is present or not in the Under Additional Information section of OpportunityAsset
    And I verify field Batch Type field is editable or not in the Under Additional Information section of OpportunityAsset
    Then I verify field Batch Type as required field or not on Asset
    And I verify the type of Batch Type field
    Then I check for all the values of Batch Type dropdown list

  @US-003056_2
  Scenario: US-003056: Batch Type picklist values
    When I navigate to Opportunity Asset tab
    And Select "Opportunity Asset - Renewal" from View list
    Then open any existing Opportunity Asset from the list
    Then edit the Opportunity Asset
    Then I check for all the values of Batch Type dropdown list

  @US-003081_1
  Scenario: US-003081 "Renewal List Price Currency" and "Renewal Currency" picklists
    When I navigate to Opportunity tab
    And Select All Opportunities from View list
    Then open any existing Open Opportunity from the list
    And select Edit button
    And verify the 'Renewal List Price Currency' field is editable or not
    And verify the field Renewal List Price Currency is mandatory
    And verify the Renewal List Price Currency field type
    Then Verify 'Renewal List Price Currency' picklist value
    And verify the 'Renewal Currency' field is editable or not
    And find the field Renewal Currency is mandatory
    And verify the Renewal Currency field type
    Then Verify 'Renewal Currency' picklist value
    And save the Opportunity

  @US-003081_2
  Scenario: US-003081 "Renewal List Price Currency" and "Renewal Currency" picklists
    When I navigate to Opportunity tab
    And Select All Opportunities from View list
    Then open any existing Open Opportunity from the list
    Then 'Renewal List Price Currency' and  'Renewal Currency' fields are available
    And 'Renewal List Price Currency' and  'Renewal Currency' fields are readonly

  @US-003082
  Scenario: US-003082 :Verify "PO Accepted" to the picklist in "Ops Stage"
    When I navigate to Opportunity tab
    And Select All Opportunities from View list
    And click on the Opportunity Name link
    And select Edit button
    Then I verify Ops Stage field is present in the Opportunity or not
    And I verify type of the Ops Stage field
    Then I verify Ops Stage field is editable or not
    And I verify Ops Stage field mandatory or not
    And verify the PO Accepted field is present in Ops Stage field

  @US-003054_1
  Scenario: US-003054:Verify picklist values of Existing Renewal Currency
    When I navigate to Opportunity Asset tab
    Then I open new OpportunityAsset
    And I verify field Existing Renewal Currency field is present or not
    Then I verify field Existing Renewal Currency field editable or not editable
    Then I verify field Existing Renewal Currency on Asset as required field or not
    And I verify the type of Existing Renewal Currency field
    And I verify the values of Existing Renewal Currency

  @US-003054_2
  Scenario: US-003054:Verify picklist values of Existing Renewal Currency
    When I navigate to Opportunity Asset tab
    And Select "Opportunity Asset - Renewal" from View list
    Then open any existing Opportunity Asset from the list to verify the Existing Renewal Currency
    Then edit the Opportunity Asset
    And I verify the type of Existing Renewal Currency field
    And I verify the values of Existing Renewal Currency

  @US-003057_1
  Scenario: @US-003057:Verify the SSI Result Reason
    When I navigate to Opportunity Asset tab
    Then I open new OpportunityAsset
    And I verify the SSI Result Reason field is present or not in OpportunityAsset
    Then I verify type of SSI Result Reason field
    And I verify SSI Result Reason field is editable or not
    Then I verify "SSI Result Reason" field is mandatory or not in OpportunityAsset
    Then verify the values present in SSI Result Reason picklist of an OpportunityAsset

  @US-003057_2
  Scenario: @US-003057:Verify the SSI Result Reason
    When I navigate to Opportunity Asset tab
    And Select "Opportunity Asset - Renewal" from View list
    Then open any existing Opportunity Asset from the list
    Then edit the Opportunity Asset
    Then verify the values present in SSI Result Reason picklist of an OpportunityAsset

  @US-003052
  Scenario: US-003052 :Business Line picklist values
    When I navigate to Opportunity tab
    And Select "Recently Viewed Opportunity" from View list
    Then open any existing Opportunity from the list
    And select Edit button
    Then I verify the field Business Line
    And I verify field type of the Business Line
    And I verify field Business Line is editable or not
    Then I verify the Business Line field is mandatory or not
    And check the picklist value of Business Line
    And save the Opportunity

  @US-002978_1
  Scenario: US-002978 Opportunity Workflow
    When I navigate to Opportunity tab
    Then click on new Opportunity
    Then enter the data to mandatory field to create the Opportunity
    And save the Opportunity
    And verify the fields Earliest New Start Date,Latest New End Date,Transaction Amount field
    Then verify the type of Earliest New Start Date,Latest New End Date,Transaction Amount field
    And verify the Earliest New Start Date,Latest New End Date are editable or not
    When I navigate to Opportunity tab
    And Select "Recently Viewed Opportunity" from View list
    And Select an opportunity that does not have a quote attached yet
    And click on New Quote button
    And Enter all fields information to create the quote
    Then click on Save button to save Quote
    And Click on the Opportunity Name link from the Opportunity field
    Then click on Edit button
    And Enter the Quote Number from the lookup field
    And save the Opportunity
    And Verify the fields Earliest New Start Date,Latest New End Date,Transaction Amount values

  @US-002978_2
  Scenario: US-002978 Opportunity Workflow
    When I navigate to Opportunity tab
    Then click on new Opportunity

  @US-003058_1
  Scenario: US-003058 Currency on "Renewal Currency" and currency on "Transaction Currency" might be different
    When I navigate to Opportunity tab
    Then click on new Opportunity to verify quote no
    Then verify the field Quote Number field is present
    Then verify Quote Number is Editable field
    And verify whether Quote Number is non mandatory field
    Then I verify the type of Quote Number
    Then enter the data to mandatory field to create the Opportunity
    And save the Opportunity
    When I navigate to Opportunity Asset tab
    Then I open new OpportunityAsset
    Then create new Opportunity Asset by entering all mandatory fields
    And save the Opportunity Asset
    When I navigate to Opportunity tab
    And Select All Opportunities from View list
    And click on the Opportunity Name link
    And click on New Quote button
    And Enter all fields information
    Then click on Save button to save Quote
    And Click on the Opportunity Name link in the Opportunity field
    Then click on Edit button
    And Enter the Quote Number from the lookup field
    Then click on Save button to save Quote

  @US-003058_2
  Scenario: US-003058 Currency on "Renewal Currency" and currency on "Transaction Currency" might be different
    When I navigate to Opportunity tab
    Then click on new Opportunity

  @US-003040
  Scenario: @US-003040:Verify the "Request Update" button
    When I navigate to contact tab
    Then Select existing contact from recent contacts list
    And verify the Request Update button in contact page

  @US-003060
  Scenario: US-003060:Initial SLA for Quote Request is 48 hours.
    When I navigate to Opportunity tab
    And select 'All Open Opportunities' in the View picklist
    Then Open an Opportunity from "All open opportunity" collection
    And Click the 'Create Case' button from opportunity detail page
    Then verify Record Type of new record field
    And Click on the 'Record Type of new record' picklist and ensure the correct values are present
    Then Select Quote Request option from 'Record Type of new record' picklist
    And Click the 'Continue' button
    Then Filled data in the required field for quote request case
    And Click the 'Save' button
    Then Validate the Name in the 'Case Milestones' section as 48 Hours
    And In the 'Case Milestones' section click on the underlined Name 48 Hours
    Then Validate the 'Milestone' field value as 48 Hours

  @US-003061
  Scenario: US-003061:Initial SLA for Data Update is 24 hours
    When I navigate to Opportunity tab
    And select 'All Open Opportunities' in the View picklist
    Then Open an Opportunity from "All open opportunity" collection
    And Click the 'Create Case' button from opportunity detail page
    Then verify Record Type of new record field
    And Click on the 'Record Type of new record' picklist and ensure the correct values are present
    Then Select Booking Request option from 'Record Type of new record' picklist
    And Click the 'Continue' button
    Then Filled data in the required field for Booking Request case
    And Click the 'Save' button
    Then Validate the Name in the 'Case Milestones' section as 24 Hours
    And In the 'Case Milestones' section click on the underlined Name 24 Hours
    Then Validate the 'Milestone' field value as 24 Hours

  @US-003062
  Scenario: US-003062:Initial SLA for Data Update is 48 hours
    When I navigate to Opportunity tab
    And select 'All Open Opportunities' in the View picklist
    Then Open an Opportunity from "All open opportunity" collection
    And Click the 'Create Case' button from opportunity detail page
    Then verify Record Type of new record field
    And Click on the 'Record Type of new record' picklist and ensure the correct values are present
    Then Select Data Update Request option from 'Record Type of new record' picklist
    And Click the 'Continue' button
    Then Filled data in the required field for Data Update Request case
    And Click the 'Save' button
    Then Validate the Name in the 'Case Milestones' section as 48 Hours
    And In the 'Case Milestones' section click on the underlined Name 48 Hours
    Then Validate the 'Milestone' field value as 48 Hours

  @US-003043_1 @AllUser
  Scenario: @US-003043:Verify the "Existing Business Line" field in Opportunity
    When I navigate to Opportunity tab
    And Select "Recently Viewed Opportunity" from View list
    Then open any existing Opportunity from the list
    And I Verify that 'Existing Business Line' field should not be editable

  @US-003043_2 @OpsRep_OpsManager
  Scenario: @US-003043:Verify the "Existing Business Line" field in Opportunity
    When I navigate to Opportunity tab
    Then click on new Opportunity to edit
    And verify the Existing Business Line field in Opportunity Detail section
    Then verify the type of Existing Business Line field
    Then verify the Existing Business Line field is mandatory
    And verify the values present in Existing Business Line field
    Then enter the data to mandatory field to create the Opportunity
    And save the Opportunity
    Then edit the Opportunity and verify that the field 'Existing Business Line' should not be editable

  @delete
  Scenario: Deletion of created records
    When I navigate to Opportunity Asset tab
    Then click on go button
    And search for created OpportunityAsset record
    When I navigate to Opportunity tab
    Then click on go button
    And search for created Opportunity record