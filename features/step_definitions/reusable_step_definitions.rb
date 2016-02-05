#reusable function not specific to application

#step definition to verify the content in a web page that specified in an feature step
Then(/^I should see content "([^"]*)"$/) do |content|
begin
	 if page.has_content? content
			puts " #{content} content is present"
		else
			puts  "#{content} content is not present"
		end
	rescue Exception=> ex
		writeFailure"Error while verifying the #{content} content"
		writeFailure ex.message
	end
end

#step definition to verify the link in a web page that specified in an feature step
Then(/^I should see "([^"]*)" link$/) do |link|
  find_link(link).visible?
end

#step definition to click the particular link in a web page that specified in an feature step
When(/^I follow "([^"]*)"$/) do |link|
  click_link(link)
end
