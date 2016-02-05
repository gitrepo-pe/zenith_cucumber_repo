
def _checkIfTheFieldIsRequired(fieldName)	

	#   ----------------    This code is to find if the field is a required field.   ------------------------
	
	if page.has_xpath?('.//label[contains(text(),"'"#{fieldName}"'")]/parent::td[contains(@class ,"requiredInput")]')
		puts "#{fieldName} field is present and is a required field"
	elsif page.has_xpath?('.//label[contains(text(),"'"#{fieldName}"'")]')
		puts "#{fieldName} field is present"
	else
		raise "#{fieldName}field is not present"
	end
	
	
	rescue Exception => ex
		puts "Error while executing _checkIfTheFieldIsRequired method"
		puts ex.message
end

def _navigateToGivenTab(tabname)	

	#   ----------------    This code is to navigate any given tab   ------------------------
	
	if find('.allTabsArrow').visible?
		find('.allTabsArrow').click
	else
		puts " ----- ERROR ---- The all tabs link is not present over home page"
	end	
	sleep 5
	within('.outer') do
		if page.has_xpath?('.//a[contains(text(),"'"#{tabname}"'")]')
			find('a',:text=> "#{tabname}").click
			puts "----  PASS  ---  #{tabname} opened"
		else	
			puts "--- ERROR ---- The tab is not present #{tabname}"
		end	
	end
	rescue Exception => ex
		puts "--- ERROR --- Error while executing _navigateToGivenTab method"
		puts ex.message
end

def _clickButton(attribute_val)	
	# This code is to click button over the page
	if find(:button,attribute_val).visible?
		click_on(attribute_val)
	else
		puts "-- FAIL-- The Button is not visible over the page"
	end
	rescue Exception => ex
		puts "Error while executing _clickButton method"
		puts ex.message
	#end
end

def _arrayComp1(expectedArrayOption,actualArrayOption)
	# This code will compare two array and return true if they are identical.
	if expectedArrayOption.sort==actualArrayOption.sort
		puts "--PASS -- The actual and expected option in the array is identical"
	else
		puts "-- FAIL-- The actual and expected option in the array are not identical"
	end
end

