@zenith-salesforce
Feature:
 In order to validate the opportunities section
 As a tester
 I should validate the functionalities as per test case

  @US-002844
  Scenario:verfiy existing financials and renewal currency under opportunities section
    Given I should naviagte to "Opportunities" tab in saleforce application
    Then I should see "Opportunities" link
    And I should see content "Recent Opportunities"
    When I verify recent opportunities table
    And I follow first opportunity name in recent opportunity section
    When I click on edit opportunity details on top button row
    Then I should see content "Existing Financials"
    And I should see content "Renewal Currency"
    And I verify "Renewal Currency" dropdown with selected text "GBP"