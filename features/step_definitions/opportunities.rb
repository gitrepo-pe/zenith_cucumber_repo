

# step definition to login in with a valid user credentials to zenith saleforce application
# and clicking on opportunities tab in a homepage
#argument tab- is a string
Given(/^I should naviagte to "([^"]*)" tab in saleforce application$/) do |tab|
  step 'I enter the credentials to the Zenith application'
  click_link(tab)
end

#step definition to click a opportunity name under recent opportunity section
When(/^I follow first opportunity name in recent opportunity section$/) do
  value =find(:xpath, "//table/tbody/tr[2]/th/a").text
  puts value
  find(:xpath, "//table/tbody/tr[2]/th/a").click
  step 'I should see content "#{value}"'
end

#step definition to verify the selected text is selected in the drop down
Then(/^I verify "([^"]*)" dropdown with selected text "([^"]*)"$/) do |dropdown, selected_text|
  page.has_select?(dropdown, :selected => selected_text).should == true
end