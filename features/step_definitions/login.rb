


When(/^I enter the credentials to the Zenith application$/) do
	begin
	sleep 5
		visit env
		arg=getCredentialInfo
		fill_in "Username",:with => arg["Username"]
		fill_in "Password",:with => arg["Password"]
		puts "Entered Credentials"
		find(:id,"Login").click
		page.driver.browser.manage.window.maximize
		puts "Logged in successfully"
		sleep 10
		puts "Login as " + ENV['UserRole']
		role=ENV['UserRole']		
		if (role.include? "Admin")==false
			page.find(:id, "userNavLabel").click
			within all('.mbrMenuItems')[0] do
				click_on 'Setup'
				sleep 2
			end
			sleep 5
			click_on 'Manage Users'
			sleep 10
			click_on 'Users'
			sleep 10
			if(role=="WW Exec")
				page.find(:xpath, '(.//a[text()="'"#{role}"'"]/parent::td/following-sibling::td/a[text()="Zenith - Read Only"]/parent::td/preceding-sibling::td/a[text()="Login"])[1]').click
					sleep 10
				  page.driver.browser.switch_to.window(page.driver.browser.window_handles.last)
			elsif page.has_xpath?('(.//td/a[text()="'"#{role}"'"]/parent::td/preceding-sibling::td/a[text()="Login"])[1]')
				page.find(:xpath, '(.//td/a[text()="'"#{role}"'"]/parent::td/preceding-sibling::td/a[text()="Login"])[1]').click
				sleep 10
				 page.driver.browser.switch_to.window(page.driver.browser.window_handles.last)
				puts "Logged in successfully as #{role}"
			elsif
				puts "The #{role} is not present over the page"
			end
		end
	rescue Exception => ex
		puts "Error  while entering credentials"
		puts "Error while logging as #{role}"
		puts ex.message
	end
end


When(/^I navigate to Opportunity Asset tab$/) do
begin
	sleep 5
		find(".wt-Opportunity_Asset").click
		puts "Opportunity Asset tab clicked"
	rescue Exception=> ex
		writeFailure "Error while navigating Opportunity Asset tab"
		writeFailure ex.message
	end
end

Then(/^I open new OpportunityAsset$/) do
begin
	sleep 5
		within ('.pbHeader') do
		  click_on " New "
		  puts "New Opportunity Asset window opens"
		end
		
	rescue Exception=> ex
		writeFailure"Error while navigating to New Opportunity asset"
		writeFailure ex.message
	end
end

And(/^I verify the product group field$/) do 
begin
	sleep 5
	within all('.pbSubsection')[1] do	
		if page.has_content? "Product Group"
			puts "Product Group field is present" 
		else 
			writeFailure  "Product Group field is not present"
		end
	end
	rescue Exception=> ex
		writeFailure"Error while verifying the Product Group field"
		writeFailure ex.message
	end
end


And(/^I verify label (.*?) on Asset is required field or not$/) do |product_group| 
begin
	sleep 5
	if page.has_xpath?('.//label[contains(text(),"'"#{product_group}"'")]/parent::td[contains(@class ,"requiredInput")]')
		 writeFailure "Product Group field is required field"
	 else
		 puts "Product Group field is not required field"
	 end
	
	rescue Exception=> ex
		writeFailure"Error while verifying the Product Group field"
		writeFailure ex.message
	end
end


Then(/^I verify the product group type$/) do
begin
	sleep 5
		within all('.pbSubsection')[1] do
		 	 if page.has_select?('00N4B000000L2E1')
			  puts"Product Group is a DropDown"
			  else
			  writeFailure"Product Group is not a DropDown"
			  end
		end
					
	rescue Exception=> ex
		writeFailure"Error while verifying the Product Group field"
		writeFailure ex.message
	end
	
end


Then(/^I verify the values present in Product group field$/) do
begin
	sleep 5
		within all('.pbSubsection')[1] do
		 	
				 LOVinapplication =find(:xpath, "//*[contains(@name, '00N4B000000L2E1')]").all('option').collect(&:text)	
				 Datalist =["--None--","LL","MQ","SM","SO","UM"]
				
				if  LOVinapplication.sort == Datalist.sort 
					puts "All values are present in the dropdown"
					Datalist.each do |val|
								puts val	
					end
				else
					
					finalresult= LOVinapplication-Datalist
					writeFailure "This is not a valid value present in ProductGroup"
					finalresult.each do |val|
						writeFailure val
						 
					end
					
					finalresult= Datalist-LOVinapplication
					writeFailure "These values are not present in the dropdown"
					finalresult.each do |val|
						writeFailure val
					end
				end
		end
	rescue Exception=> ex
		writeFailure"Error while verifying values of Product Group field "
		
	end
end



Then(/^create new Opportunity Asset by entering all mandatory fields$/) do
begin
sleep 5
	arg=getDetails 'OpportunityAssetvalues1'
		
	within all('.detailList')[0] do
		table = all("tbody")[0]
		fill_in "Name",:with => arg["OpportunityAssetName"]
	end	
	
		page.driver.browser.window_handles.first
		find("img[alt='Opportunity Lookup (New Window)']").click
		sleep 1
		page.driver.browser.switch_to.window(page.driver.browser.window_handles.last)
		sleep 2
		page.driver.browser.switch_to.frame("resultsFrame")
		within('.pbBody') do
			table=all("tbody")[0]
			table.all("tr")[1].all("th")[0].find('a').click					
		end
		sleep 3
		page.driver.browser.switch_to.window(page.driver.browser.window_handles.first)
		
	sleep 2
		
	 within all('.pbSubsection')[1] do
		sleep 2
		if page.has_field?('Existing Start Date', :type => 'text') == true
			fill_in "Existing Start Date",:with => arg["ExistingStartDate"]
		else
			 puts"Value for Existing Start Date is not required"
		end
		fill_in "Existing End Date",:with => arg["ExistingEndDate"]
	 end
	 sleep 2
	within all('.pbSubsection')[3] do
		fill_in "Existing Renewal Amount",:with => arg["ExistingRenewalAmount"]
		
	end
	sleep 2
	 within all('.pbSubsection')[4] do
		sleep 2
		if page.has_field?('Client Batch Year', :type => 'text') == true
			fill_in "Client Batch Year",:with => arg["ClientBatchYear"]
		else
			 puts"Client Batch Year is not required"
		end	
		sleep 2
		if page.has_select?('00N61000003Y6jY')
			find_field('Client Batch Quarter').select(arg["ClientBatchQuarter"])
		else
			 puts"Client Batch Quarter is not required"
		end	
		sleep 2
		if page.has_select?('00N61000003Y6jP')
			find_field('Batch Type').select(arg["BatchType"])
		else
			 puts"Batch Type is not required"
		end	
		
	 end
	sleep 2
	 arg=getDetails 'OpportunityAssetvalues2'
	within all('.pbSubsection')[1] do
			table =all("table")[0]
				if table.all("tr")[5].all("td")[3].has_css?('.requiredInput')== true
						find_field('Product Group').select(arg["ProductGroup"])
				else
				 puts "Product Group field is not mandatory to select"
				end
	end
		puts"Required fields are populated"
	rescue Exception=> ex
		writeFailure "Error while creating new Opportunity Asset"
		writeFailure ex.message
	end
end

Then(/^create new Opportunity Asset by entering all mandatory fields for PO Submitted Amount$/) do

begin
sleep 5
	arg=getDetails 'OpportunityAssetvalues2'
	within all('.detailList')[0] do
		table = all("tbody")[0]
		fill_in "Name",:with => arg["OpportunityAssetName"]
	end	
		#table.all("tr")[0].all("td")[3].find_field('Opportunity').set("Testing")
		page.driver.browser.window_handles.first
		find("img[alt='Opportunity Lookup (New Window)']").click
		sleep 1
		page.driver.browser.switch_to.window(page.driver.browser.window_handles.last)
		sleep 2
		page.driver.browser.switch_to.frame("resultsFrame")
		within('.pbBody') do
			table=all("tbody")[0]
			table.all("tr")[1].all("th")[0].find('a').click					
		end
		sleep 3
		page.driver.browser.switch_to.window(page.driver.browser.window_handles.first)
       	
	sleep 5
	within all('.pbSubsection')[1] do
		table=all("tbody")[0]
		sleep 2
		if page.has_field?('Existing Start Date', :type => 'text') == true
			fill_in "Existing Start Date",:with => arg["ExistingStartDate"]
		else
			 puts"Existing Start Date is not required"
		end
		fill_in "Existing End Date",:with => arg["ExistingEndDate"]
	end
	sleep 5
	within all('.pbSubsection')[3] do
		table=all("tbody")[0]
		fill_in "Existing Renewal Amount",:with => arg["ExistingRenewalAmount"]
	end
	sleep 2
	within all('.pbSubsection')[4] do
		table = all("tbody")[0]
		sleep 2
		if page.has_field?('Client Batch Year', :type => 'text') == true
			fill_in "Client Batch Year",:with => arg["ClientBatchYear"]
		else
			 puts"Client Batch Year is not required"
		end	
		sleep 2
		if page.has_select?('00N61000003Y6jY')
			find_field('Client Batch Quarter').select(arg["ClientBatchQuarter"])
		else
			 puts"Client Batch Quarter is not required"
		end	
		sleep 2
		if page.has_select?('00N61000003Y6jP')
			find_field('Batch Type').select(arg["BatchType"])
		else
			 puts"Batch Type is not required"
		end	
		
				
	 end
	sleep 2
				
	arg=getDetails 'OpportunityAssetvalues1'
	within all('.pbSubsection')[3] do
		table = all("tbody")[0]	
		sleep 2
		if table.all("tr")[2].all("td")[1].has_css?('div','requiredInput')== true
				fill_in 'PO Submitted Amount', :with => '500'
				writeFailure "PO Submitted Amount field is required field"
		else
				 puts "PO Submitted Amount field is not required"
		end
	 	sleep 2
	end
	puts"Required fields are populated" 	
	rescue Exception=> ex
		writeFailure "Error while creating new Opportunity Asset"
		writeFailure ex.message
	end

end

And(/^save the Opportunity Asset$/) do
begin
	sleep 2
	within('.pbBottomButtons') do
		click_on " Save "
		sleep 5
	end
	sleep 2
	if page.has_content?("Error: Invalid Data. ")
				 writeFailure"Opportunity Asset is not created due to Invalid Data. "
				
	else
				puts"Opportunity Asset save successfully" 
	end
	sleep 2
	rescue Exception=> ex
		writeFailure"Error while saving the Opportunity Asset"
		writeFailure ex.message
	end
end

When(/^I click on Edit opportunity details on top button row$/) do
begin
	if (ENV['UserRole']=="WW Exec")
	 puts "Edit button is not present"
	else
		within all('.pbButton')[0] do
			click_on " Edit "
			puts "OpportunityAsset is editable"
		  end
	end		
	rescue Exception=> ex
		writeFailure"Error while editing the OpportunityAsset"
		writeFailure ex.message
	end
end


And(/^select the value for product group field$/) do
begin
	sleep 5
	arg=getDetails 'OpportunityAssetvalues1'
	within all('.pbSubsection')[1] do
		sleep 2
		find_field('Product Group').select(arg["ProductGroup"])
		puts"Selected Product Group value is selected"
	end
			
	rescue Exception=> ex
		writeFailure"Error while selecting value for the Product Group field"
		writeFailure ex.message
	end
end


Given(/^login as SalesOps$/) do
begin
	sleep 5
	find(:id,"userNavLabel").click
		within('.menuWidthExtended') do
			find("a",:text => "Setup").click
		end
		sleep 2
		within(:id,"AutoNumber5") do
			find("a",:text => "Manage Users").click
		end
		within(:id,"AutoNumber5") do
			within(:id,"Users_child") do
				find(:id,"ManageUsers_font").click
			end
		end
		sleep 5
		
		within('.pbBody') do
			within('.list') do
				
				click_on "Login - Record 11 - Sales Ops, Leica"
				
			end
		end	
		puts "SalesOps logged in Successfully"
	sleep 2
	rescue Exception=> ex
		writeFailure"Error while login as SalesOps"
		writeFailure ex.message
	end
end

And(/^click on Opportunity Asset tab$/) do
begin
	sleep 5
		find(".wt-Opportunity_Asset").click
		puts "Opportunity Asset tab clicked"
	rescue Exception=> ex
		writeFailure"Error while Opportunity Asset tab is clicking"
		writeFailure ex.message
	end
end

Then(/^open on any existing Opportunity Asset as SalesOps$/) do
begin
	sleep 5
	#This code for existing opportunity asset to click
	within ('.pbBody') do
			 table =all("table")[0]
			  table.all("tr")[1].find('a').click
			  puts "Existing Opportunity Asset is selected"
	end	
		
	rescue Exception=> ex
		writeFailure"Error while click on Opening the Existing Opportunity Asset"
		writeFailure ex.message
	end
end

Then(/^open on any existing Opportunity Asset to PO Submitted Amount field$/) do
begin
	sleep 5
	#This code for existing opportunity asset to click
	within ('.pbBody') do
			 table =all("table")[0]
			  table.all("tr")[1].find('a').click
			  puts "Existing Opportunity Asset is selected"
	end	
		
	rescue Exception=> ex
		writeFailure"Error while click on Opening the Existing Opportunity Asset"
		writeFailure ex.message
	end
end

Then(/^open any existing Opportunity Asset from the list to verify the Existing Renewal Currency$/) do
begin
	sleep 7
		within('.x-grid3-body') do
			sleep 2
			table = all("tbody")[0]

				if (ENV['UserRole']=="WW Exec")
					table.all('tr')[0].all('td')[1].find('a').click
				else
					table.all('tr')[0].all('td')[3].find('a').click
				end
				 
				
		end	
	
		
	rescue Exception=> ex
		writeFailure"Error while click on Opening the Existing Opportunity Asset"
		writeFailure ex.message
	end
end



Then(/^verify the product group field is editable or not for OperationRep$/) do
begin
	sleep 5
		within all('.pbSubsection')[1] do
			if page.has_select?('00N4B000000L2E1')
				puts"Product Group field is editable"
			  else
			  writeFailure"Product Group is not editable"
			  end
		end
		
	rescue Exception=> ex
		writeFailure"Error while verifying the Product Group field is editable"
		writeFailure ex.message
	end
end


Then(/^verify the product group field is editable or not$/) do
begin
	sleep 5
		within all('.pbSubsection')[1] do
		 
			  if page.has_select?('00N4B000000L2E1')
				writeFailure"Product Group field is editable"
			  else
			  puts"Product Group is not editable"
			  end
		end
	rescue Exception=> ex
		writeFailure"Error while verifying the Product Group field is editable"
		writeFailure ex.message
	end
end


Given(/^I login as OperationRep$/) do
begin
	sleep 5
	find(:id,"userNavLabel").click
		within('.menuWidthExtended') do
			find("a",:text => "Setup").click
		end
		sleep 2
		within(:id,"AutoNumber5") do
			find("a",:text => "Manage Users").click
		end
		within(:id,"AutoNumber5") do
			within(:id,"Users_child") do
				find(:id,"ManageUsers_font").click
			end
		end
		sleep 5
		within('.pbBody') do
			within('.list') do
				click_on "Login - Record 8 - Operations Rep, Leica"
				
			end
		end	
		puts "OperationRep logged in Successfully"
	sleep 2
	rescue Exception=> ex
		writeFailure"Error while login as OperationRep"
		writeFailure ex.message
	end
end
 
Then(/^I logout$/) do
begin
	sleep 5
	find(:id,"userNavLabel").click
		within all('.mbrMenuItems')[0] do
			click_on 'Logout'
			sleep 2
		end
		sleep 2
		puts "Logged out Successfully"
	sleep 2
	rescue Exception=> ex
		writeFailure"Error while logging out"
		writeFailure ex.message
	end
end

Given(/^I login as SalesRep$/) do
begin
	sleep 5
	find(:id,"userNavLabel").click
		within('.menuWidthExtended') do
			find("a",:text => "Setup").click
		end
		sleep 2
		within(:id,"AutoNumber5") do
			find("a",:text => "Manage Users").click
		end
		within(:id,"AutoNumber5") do
			within(:id,"Users_child") do
				find(:id,"ManageUsers_font").click
			end
		end
		sleep 2
		within('.pbBody') do
			within('.list') do
				click_on "Login - Record 12 - Sales Rep, Leica"
				
			end
		end	
		puts "SalesRep logged in Successfully"
	sleep 2
	rescue Exception=> ex
		writeFailure"Error while login as SalesRep"
		writeFailure ex.message
	end
end

And(/^I verify label (.*?) on Asset as required field or not$/) do |po_submitted_amount| 
begin
	sleep 5
	 if page.has_xpath?('.//label[contains(text(),"'"#{po_submitted_amount}"'")]/parent::td[contains(@class ,"requiredInput")]')
		 writeFailure "PO Submitted Amount field is present and is a required field"
	 else
		 puts "PO Submitted Amount field is not required field"
	 end	
	rescue Exception=> ex
		writeFailure"Error while verifying the PO Submitted Amount field"
		writeFailure ex.message
	end
end


And(/^I verify the PO Submitted Amount field is present or not$/) do
begin
	sleep 5
		within all('.pbSubsection')[3] do
			if page.has_field? "PO Submitted Amount"
				puts "PO Submitted Amount field is present" 
			else 
				puts  "Error-PO Submitted Amount field is not present"
			end
		end		
	rescue Exception=> ex
		writeFailure"Error while verifying the PO Submitted Amount"
		writeFailure ex.message
	end
end 

And(/^I verify the PO Submitted Amount type$/) do
begin
	sleep 5
		within all('.pbSubsection')[3] do
			if page.has_field?('PO Submitted Amount', :type => 'text') == true
				puts "PO Submitted Amount is a text field"
			else
			   puts"Error-PO Submitted Amount is not a text field"
			end
		end
	rescue Exception=> ex
		writeFailure"Error while verifying the PO Submitted Amount"
		writeFailure ex.message
	end
end 

Then(/^enter the value for PO Submitted Amount field$/) do
	begin
		sleep 5
		within all('.pbSubsection')[3] do
		table = all("tbody")[0]						
			if	page.has_content?('PO Submitted Amount') 
				fill_in 'PO Submitted Amount', :with => '100'
				sleep 5			
				puts "PO Submitted Amount field exist"
			else
				puts "PO Submitted Amount field does not exist" 
			end		
			sleep 5
		end
		rescue Exception=> ex
			writeFailure"Error while verifying PO Submitted Amount field"	
			writeFailure ex.message
	end
end


Given(/^I login as SalesManager$/) do
	begin
	sleep 5
		page.find(:id, "userNavLabel").click
		sleep 10
		within all('.mbrMenuItems')[0] do
			click_on 'Setup'
			sleep 2
		end
		sleep 5
		click_on 'Manage Users'
		sleep 10
		click_on 'Users'
		sleep 10
		click_on ('Login - Record 10 - Sales Manager, Leica')
		sleep 10
		puts "login SalesManager"
		rescue Exception=> ex
			writeFailure"Error while Navigating to Opportunities Assets tab as SalesManager"
			writeFailure ex.message
	end
end

Given(/^I login as SalesOps$/) do
	begin
	sleep 5
		page.find(:id, "userNavLabel").click
		sleep 10
		within all('.mbrMenuItems')[0] do
			click_on 'Setup'
			sleep 2
		end
		sleep 10
		click_on 'Manage Users'
		sleep 10
		click_on 'Users'
		sleep 10
		click_on ('Login - Record 11 - Sales Ops, Leica')
		sleep 10
		puts "login sales Ops"
		rescue Exception=> ex
			writeFailure"Error while Navigating to Opportunities Assets tab as sales ops"
			writeFailure ex.message
	end
end

And(/^Select "Opportunity Asset - Renewal" from View list$/) do
	begin
	sleep 5
		if  find_field('fcf').find('option[selected]').text == "Opportunity Asset - Renewal"
			within('.filterOverview') do
				#find(:xpath, '//input[@type="button" and @title="Go!"]').click
				click_on "Go!"
				puts "Opportunity tab refresh and all recently viewed Opportunities are listed"			
			end
		else
	
			select "Opportunity Asset - Renewal", :from => "View:"
			puts "Opportunity Assets refresh and all available Opportunity Assets are listed"
		end
			sleep 7
		rescue Exception=> ex
			writeFailure"Error while Selecting Opportunity Asset - Renewal from View list"
			writeFailure ex.message
	end	
end

Then(/^open any existing Opportunity Asset from the list to verify the PO Submitted Amount$/) do
	begin
	sleep 7
		within('.x-grid3-body') do
			sleep 2
			table = all("tbody")[0]

				if (ENV['UserRole']=="WW Exec")
					table.all('tr')[0].all('td')[1].find('a').click
				else
					table.all('tr')[0].all('td')[3].find('a').click
				end
				 
				
		end
			
		rescue Exception=> ex
			writeFailure"Error while  opening existing Opportunity Asset Name from the list"
			writeFailure ex.message
		end
end

Then(/^open any existing Opportunity Asset from the list$/) do
	begin
	sleep 5
		within('.x-grid3-body') do
			sleep 2
			table = all("tbody")[0]

				if (ENV['UserRole']=="WW Exec")
					table.all('tr')[0].all('td')[1].find('a').click
				else
					table.all('tr')[0].all('td')[3].find('a').click
				end
				 
				
		end
			
		rescue Exception=> ex
			writeFailure"Error while  opening existing Opportunity Asset Name from the list"
			writeFailure ex.message
		end
end

Then(/^check "PO Submitted Amount" is editable or not editable$/) do
	begin
	sleep 5
		within all('.pbSubsection')[3] do
		table = all("tbody")[0]
			
			if	table.all('tr')[2].all('td')[1].has_css?("input") == true
				puts "PO submitted field is editable "
			else
				writeFailure"PO submitted field is not editable"
			sleep 5
			end
		end
	rescue Exception=> ex
			writeFailure"Error while checking PO Submitted Amount is NOT editable"	
			writeFailure ex.message			
	end
end

Then(/^check "PO Submitted Amount" is editable or not editable for SalesOps$/) do
	begin
	sleep 5
		within all('.pbSubsection')[3] do
		table = all("tbody")[0]
			
			if	table.all('tr')[2].all('td')[1].has_css?("input") == true
				writeFailure "PO submitted field is editable "
			else
				puts"PO submitted field is not editable"
			sleep 5
			end
		end
	rescue Exception=> ex
			writeFailure"Error while checking PO Submitted Amount is NOT editable"	
			writeFailure ex.message			
	end
end



And(/^I verify field Existing Renewal Currency field is present or not$/) do 
begin
	sleep 5
	within all('.pbSubsection')[3] do
	 if page.has_content? "Existing Renewal Currency"
			puts "Existing Renewal Currency field is present" 
		else 
			puts  "Existing Renewal Currency field is not present"
		end					
	end	
	rescue Exception=> ex
		writeFailure"Error while verifying the Existing Renewal Currency field"
		writeFailure ex.message
	end
end

Then(/^I verify field (.*?) on Asset as required field or not$/) do |existing_renewal_currency| 
begin
	sleep 5
	 if page.has_xpath?('.//label[contains(text(),"'"#{existing_renewal_currency}"'")]/parent::td[contains(@class ,"requiredInput")]')
		 puts "Existing Renewal Currency field is present and is a required field"
	 else
		 writeFailure "Existing Renewal Currency field is not required field"
	 end	
		
	rescue Exception=> ex
		writeFailure"Error while verifying the Existing Renewal Currency field"
		writeFailure ex.message
	end
end

Then(/^I verify field Existing Renewal Currency field editable or not editable$/) do
	begin
	sleep 5
		within all('.pbSubsection')[3] do
		if page.has_select?('00N61000003Y6jo')
			  puts"Existing Renewal Currency is a Editable"
			  else
			  puts"Existing Renewal Currency is not a Editable"
			  end
		end
	rescue Exception=> ex
			writeFailure"Error while checking Existing Renewal Currency"	
			writeFailure ex.message			
	end
end

And(/^I verify the type of Existing Renewal Currency field$/) do
begin
sleep 5
	within all('.pbSubsection')[3] do
			if page.has_select?('00N61000003Y6jo')
			  puts"Existing Renewal Currency is a DropDown"
			  else
			  puts"Existing Renewal Currency is not a DropDown"
			  end
	end
	sleep 5
	rescue Exception => ex
		writeFailure "Error while verify the Existing Renewal Currency"
		writeFailure ex.message
	end
end

And(/^I verify the values of Existing Renewal Currency$/) do
begin
	sleep 5
		within all('.pbSubsection')[3] do
		sleep 5
			if page.has_select?('00N61000003Y6jo')
		
				Datalist =["CHF","DKK","EUR","GBP","SEK"]
				 LOVinapplication =find(:xpath, "//*[contains(@name, '00N61000003Y6jo')]").all('option').collect(&:text)
				 
				if  LOVinapplication.sort == Datalist.sort 
					puts "All values are present in the dropdown"
					Datalist.each do |val|
							puts val	
					end
				else
					
					finalresult= LOVinapplication-Datalist
					writeFailure "This is not a valid value present in Existing Renewal Currency"
					finalresult.each do |val|
						writeFailure val	
					end
					
					finalresult= Datalist-LOVinapplication
					writeFailure "These values are not present in the dropdown"
					finalresult.each do |val|
						writeFailure val	
					end
				end
			else
			
			puts "Existing Renewal Currency field is not editable"
			
			end
	end
	rescue Exception=> ex
		writeFailure"Error while verify the values of Existing Renewal Currency"
	end
end

And(/^verify the values of Existing Renewal Currency as SalesManager$/) do
begin
	sleep 5
		within all('.pbSubsection')[3] do
		table=all("tbody")[0]
		table.all("tr")[1].all("td")[1].click
				sleep 5
				Datalist =["CHF","DKK","EUR","GBP","SEK"]
				 LOVinapplication =find(:xpath, "//*[contains(@name, '00N61000003Y6jo')]").all('option').collect(&:text)
				 
				if  LOVinapplication.sort == Datalist.sort 
					puts "All values are present in the dropdown"
					Datalist.each do |val|
							puts val	
					end
				else
					
					finalresult= LOVinapplication-Datalist
					writeFailure "These values are present in dropdown and not present in application list"
					finalresult.each do |val|
						writeFailure val	
					end
					
					finalresult= Datalist-LOVinapplication
					writeFailure "These values are deleted from dropdown"
					finalresult.each do |val|
						writeFailure val	
					end
				end
	end
	rescue Exception=> ex
		writeFailure"Error while verify the values of Existing Renewal Currency"
		writeFailure ex.message
	end
end


Then(/^I verify the (.*?) field is not mandatory in OpportunityAsset$/) do |currency| 
begin
	sleep 5
	 if page.has_xpath?('.//label[contains(text(),"'"#{currency}"'")]/parent::td[contains(@class ,"requiredInput")]')
		 puts"Currency field is a required field"
	 else
		 writeFailure "Currency field is not required field"
	 end	
	rescue Exception=> ex
		writeFailure"Error while verifying the Currency field"
		writeFailure ex.message
	end
end

And(/^I verify the currency field in OpportunityAsset$/) do
begin
sleep 5
	within all('.pbSubsection')[3] do
		if page.has_content? "Currency"
			puts "Currency field is present" 
		else 
			writeFailure "Currency field is  not present"
		end				
	end
	rescue Exception => ex
		writeFailure "Error while verify the Currency field in OpportunityAsset"
		writeFailure ex.message
	end
end
 
Then(/^I verify the currency field  is editable or not$/) do
begin
sleep 5
	within all('.pbSubsection')[3] do
			if page.has_select?('CurrencyIsoCode')
			  puts "Currency is a editable"
			  else
			  puts "Currency is not editable"
			  end
	end

	rescue Exception => ex
		writeFailure "Error while editing field Currency"
		writeFailure ex.message
	end
end


And(/^I verify the currency field type$/) do
begin
sleep 5
	within all('.pbSubsection')[3] do
			if page.has_select?('CurrencyIsoCode')
			  puts"Currency is a DropDown"
			  else
			  writeFailure"Currency is not a DropDown"
			  end
	end
	rescue Exception => ex
		writeFailure "Error while verify the Currency field type"
		writeFailure ex.message
	end

end

Then(/^I verify the field Currency in Quote$/) do
begin
sleep 5
	within all('.pbSubsection')[1] do
		if page.has_content? "Currency"
			
			  puts"Currency field is a present"
			  else
			  puts"Currency field is not present"
			  end
	end
	rescue Exception => ex
		writeFailure "Error while verify the Currency field"
		writeFailure ex.message
	end

end

And(/^I verify the currency field is editable or not in Quote$/) do
begin
sleep 5
	within all('.pbSubsection')[1] do
			if page.has_select?('CurrencyIsoCode')
			  puts "Currency field is a editable"
			  else
			  puts "Currency field is not a editable"
			  end
	end
	rescue Exception => ex
		writeFailure "Error while verify the currency field"
		writeFailure ex.message
	end
end

Then(/^I verify the (.*?) field is mandatory or not in Quote$/) do |currency| 
begin
	sleep 5
	 if page.has_xpath?('.//label[contains(text(),"'"#{currency}"'")]/parent::td[contains(@class ,"requiredInput")]')
		 puts "Currency is a required field"
	 else
		 writeFailure "Currency is not required field"
	 end	
		
	rescue Exception=> ex
		writeFailure"Error while verifying the Currency"
		writeFailure ex.message
	end
end

And(/^I verify the currency field type in Quote$/) do
begin
sleep 5
	within all('.pbSubsection')[1] do
			if page.has_select?('CurrencyIsoCode')
			  puts "Currency field is a DropDown"
			  else
			  puts "Currency field is not a DropDown"
			  end
	end
	rescue Exception => ex
		writeFailure "Error while verify the currency field type"
		writeFailure ex.message
	end
end

Then(/^verify the values present in currency field of an OpportunityAsset$/) do
	begin	
		sleep 5
		within all('.pbSubsection')[3] do
			
			if page.has_select?('CurrencyIsoCode')
				 LOVinapplication =find(:xpath, "//*[contains(@name, 'CurrencyIsoCode')]").all('option').collect(&:text)
					
					Datalist =["CHF - Swiss Franc","DKK - Danish Krone","EUR - Euro","GBP - British Pound","SEK - Swedish Krona"]
				 
					if  LOVinapplication.sort == Datalist.sort 
						puts "All values are present in the dropdown"
						Datalist.each do |val|
									puts val	
						end
											
					else
						finalresult= LOVinapplication-Datalist
						finalresult.each do |val|
							puts "These values are present in application list #{val}"
							 
						end
						finalresult= Datalist-LOVinapplication
						finalresult.each do |val|
							puts "These values are deleted from dropdown #{val}"
							
						end
					end
			else
					puts "Currency field is not editable"
			end
		end
	rescue Exception=> ex
			writeFailure"Error while verify the  values present in currency of an OpportunityAsset"
			
	end
end

And(/^I verify the SSI Result Reason field is present or not in OpportunityAsset$/) do
begin	
		sleep 5
		within all('.pbSubsection')[4] do
			if page.has_content? "SSI Result Reason"
				puts "SSI Result Reason field is present" 
			else 
				writeFailure"SSI Result Reason field is  not present"
			end				
		end
	rescue Exception=> ex
			writeFailure"Error while verify the SSI Result Reason  is present in OpportunityAsset"
			writeFailure ex.message
	end
end


Then(/^I verify type of SSI Result Reason field$/) do
begin
	sleep 5
	within all('.pbSubsection')[4] do
		if page.has_select?('00N61000003Y6k9')
			puts "SSI Result Reason field is dropdown" 
		else 
			writeFailure"SSI Result Reason field is not dropdown"
		end				
			
	end
	rescue Exception => ex
		writeFailure"Error while verifing type of SSI Result Reason field"
		writeFailure ex.message
	end
end


And(/^I verify SSI Result Reason field is editable or not$/) do
begin
	sleep 5
	within all('.pbSubsection')[4] do
		if page.has_select?('00N61000003Y6k9')
			puts "SSI Result Reason field is editable" 	
		else 	
			writeFailure"SSI Result Reason field is  not editable"
		end				
	end
	rescue Exception => ex
		writeFailure"Error while verifing type of SSI Result Reason field"
		writeFailure ex.message
	end
end


Then(/^I verify "(.*?)" field is mandatory or not in OpportunityAsset$/) do |sSI_result_reason| 
begin
	sleep 5
	 if page.has_xpath?('.//label[contains(text(),"'"#{sSI_result_reason}"'")]/parent::td[contains(@class ,"requiredInput")]')
		 writeFailure "SSI Result Reason field is present and is a required field"
	 else
		 puts "SSI Result Reason field is not required field"
	 end	
	rescue Exception=> ex
		writeFailure"Error while verifying the SSI Result Reason field"
		writeFailure ex.message
	end
end


Then(/^verify the values present in SSI Result Reason picklist of an OpportunityAsset$/) do
	begin	
		sleep 5
		arg=getDetails 'SSIResultReason'	
		if page.has_select?('00N61000003Y6k9')
		
			within all('.pbSubsection')[4] do
				table=all("tbody")[0]
				  LOVinapplication =find(:xpath, "//*[contains(@name, '00N61000003Y6k9')]").all('option').collect(&:text)	
				  
					Datalist =Array.new
					Datalist =arg["value"].split(',')
					
					
					if  LOVinapplication.sort == Datalist.sort 
					puts "All values are present in the dropdown"
							Datalist.each do |val|
							puts val	
						end
						
					else
						finalresult= LOVinapplication-Datalist
						finalresult.each do |val|
							writeFailure "These values are present in dropdown and not present in application list as follows: #{val}"
						end
											finalresult= Datalist-LOVinapplication
						finalresult.each do |val|
						writeFailure "These values are deleted from dropdown as follows #{val}"
							 
						end
					end
					
			end
		else
		
			puts"SSI Result Reason field is not editable" 
				
		end
	rescue Exception=> ex
			writeFailure"Error while verify the  values present in SSI Result Reason of an OpportunityAsset"
			writeFailure ex.message
	end

end


When(/^I navigate to contact tab$/) do
begin
	sleep 5
		#find(".brandPrimaryFgr").click
		find('a',:text=> "Contacts").click
			puts "Contacts tab opens"
	rescue Exception=> ex
		writeFailure"Error while navigating to Contact tab opens"
		writeFailure ex.message
	end
end

Then(/^Select existing contact from recent contacts list$/) do
begin
	sleep 5
	within('.hotListElement') do
		within('.pbBody') do                  
			@table =all("tbody")[0]
				tr = @table.all("tr")
				@tRowCount=tr.count
		end 
	end 
	if @tRowCount>1
		@table.all("tr")[1].find("th").find("a").click
		find(:xpath, '//td[@id="topButtonRow"]/input[@title="Edit"]').click
	else 
		#  Creating new contect in the following code=
		arg=getDetails "NewContect"
		within('.pbHeader') do
			page.click_on('New')
		end
		@contectLastName=arg["Last Name"]+ Random.new.rand(1111..9999).to_s
		page.find_field("Account Name").set(arg["Account Name"])
		page.find_field("Last Name").set(@contectLastName)
		find(:xpath, '//td[@id="topButtonRow"]/input[@name="save"]').click
		if page.has_content? ("Error: Invalid Data.")
			writeFailure"Error while saving new contact"
		else
			click_on('Contacts')
			sleep 10
			within('.hotListElement') do
				within('.pbBody') do                 
					table =all("tbody")[0]
					tr = table.all("tr")
					table.all("tr")[1].find("th").find("a").click
				end
			end
			find(:xpath, '//td[@id="topButtonRow"]/input[@title="Edit"]').click
		end
	end
	sleep 10
	#if page.has_text?('Back to List: Contacts')
	if page.has_text?('Contact Edit')
		puts "Contact Detail page opens"
	else 
		writeFailure "Fail to open Contact Detail page"
	end
	rescue Exception=> ex
		writeFailure"Error while navigating to Contact tab"
		writeFailure ex.message
	end
end

And(/^verify the Request Update button in contact page$/) do
begin
	sleep 5
		within all('.pbButton')[0] do
			if page.has_css?('Request Update')
					writeFailure "Request Update button is available"
			else
					puts "Request Update button should not be available"
			end
		end
	rescue Exception=> ex
		writeFailure"Error while verify the Request Update button in contact page"
		writeFailure ex.message
	end
end


When(/^I navigate to Opportunity tab$/) do
begin
	sleep 5
		find('a',:text=> "Opportunities").click
			puts "Opportunity tab opens"
	rescue Exception=> ex
		writeFailure"Error while navigating to Opportunities tab"
		writeFailure ex.message
	end
end

Then(/^click on new Opportunity to edit$/) do
begin
	sleep 5
		within('.pbHeader') do
			click_on "New"
			puts "New Opportunity window opens"
		end
		#page.select 'Opportunity - Edit', :from => 'Record Type of new record'
		#click_on('Continue')		
	rescue Exception=> ex
		writeFailure"Error while navigating to New Opportunities"
		writeFailure ex.message
	end
end
 
Then(/^click on new Opportunity$/) do
begin
	sleep 5
		within('.pbHeader') do
		sleep 5
			#if page.has_submit?("New")
					click_on "New"
					puts "New Opportunity window opened"
			#else
		end
		
		
	rescue Exception=> ex
		writeFailure"Error while navigating to New Opportunities"
		writeFailure ex.message
	end
end

Then(/^verify the type of Existing Business Line field$/) do
begin
	sleep 5
		within('.pbBody') do
			if page.has_select?('Existing Business Line')
				puts "The field 'Existing Business Line' is of type select"
			else 
				writeFailure "The field 'Existing Business Line' is not of type select"
			end
		end
		
	rescue Exception=> ex
		writeFailure"Error while navigating to New Opportunities"
		writeFailure ex.message
	end
end

And(/^verify the Existing Business Line field in Opportunity Detail section$/) do
begin
	sleep 5
		within all('.pbSubsection')[0] do
			if page.has_text?('Existing Business Line')
				if page.has_field?('Existing Business Line')
					puts "Existing Business Line field is present and Editable"
				end
				if page.has_no_field?('Existing Business Line')
					writeFailure "Existing Business Line field is not Editablele"
				end
			else
				writeFailure "Existing Business Line field is not present over the page"
			end
		end
	rescue Exception=> ex
		writeFailure"Error while verify the Existing Business Line field"
		writeFailure ex.message
	end
end

Then(/^verify the Existing Business Line field is mandatory$/) do
begin
	sleep 5
		if page.has_xpath?('.//label[text()="Existing Business Line"]/parent::td[contains(@class ,"requiredInput")]')
			puts "Existing Business Line field is a required field"
		else
			writeFailure "Existing Business Line field is not a required field"
		end
	rescue Exception=> ex
		writeFailure"Error while verify the Existing Business Line field is mandatory"
		writeFailure ex.message
	end
end


And(/^verify the values present in Existing Business Line field$/) do   #Change 12-01
begin
	sleep 5
		arg=getDetails("CommonData")
		expectedOption=arg["Existing_Business_Line_option"]
		
		within all('.pbSubsection')[0] do
			table=all("tbody")[0]
			table.all("tr")[6].all("td")[3].click
			LOV =find(:xpath, '//label[text()="Existing Business Line"]/parent::td/following-sibling::td[1]//select').all('option').collect(&:text)
			
			resultArray=expectedOption-LOV
			
			if resultArray.count==0
				puts "Expected options are appearing "
				puts "The expected options are as follows"
				expectedOption.each do |option_Existing_Business_Line|
					puts option_Existing_Business_Line
				end
			else
				writeFailure "The options not appearing are as follows"
				resultArray.each do |option_Existing_Business_Line|
					puts option_Existing_Business_Line
				end
			end
		end
				
	rescue Exception=> ex
		writeFailure"Error while verify the values present in Existing Business Line"
		writeFailure ex.message
	end
end

Then(/^enter the data to mandatory field to create the Opportunity$/) do
	begin
		sleep 7
		@oppName = ""
			arg=getDetails 'Opportunityvalues'			
			within all('.pbSubsection')[0] do
				table=all("tbody")[0]				
				find(:id, "00N61000003Y6hh").select(arg["BusinessLine"])
				@oppName =arg["OpportunityName"]+Random.new.rand(1111..99999).to_s
				#puts "The Opportunity name is " oppName
				
				fill_in "Opportunity Name",:with => @oppName
				find_field("Opportunity Currency").select(arg["OpportunityCurrency"])							
				find(:id, "opp11").select(arg["Stage"])	
			
			#To find the mandatory of Opportunity type
			table =all("table")[0]
				if table.all("tr")[1].all("td")[3].has_css?('.requiredInput')== true
						find_field('Opportunity Type').select(arg["OpportunityType"])
				else
				 puts "Opportunity Type field is not mandatory to select"
				end
			#To find  Direct/channel mandatory
				if table.all("tr")[2].all("td")[1].has_css?('.requiredInput')== true
						find_field('Direct/Channel').select(arg["Directchannel"])
				else
				 puts "Directchannel field is not mandatory to select"
				end
			
			# to find Ops Stage mandatory
				if table.all("tr")[4].all("td")[3].has_css?('.requiredInput')== true
						find_field('Ops Stage').select(arg["OpsStage"])
				else
				 puts "Ops Stage field is not mandatory to select"
				end
				
				# to find Existing Business Line
				if table.all("tr")[6].all("td")[3].has_css?('.requiredInput')== true
						find_field("Existing Business Line").select(arg["ExistingBusinessLine"])		
				else
				 puts "Existing Business Line is not mandatory to select"
				end
				
				# if page.has_select?('Existing Business Line')
					# find_field("Existing Business Line").select(arg["ExistingBusinessLine"])			
				# end	
			end
			sleep 5
			puts @oppName	
			sleep 5
			
			page.driver.browser.window_handles.first
			find("img[alt='Account Name Lookup (New Window)']").click
			sleep 1
			page.driver.browser.switch_to.window(page.driver.browser.window_handles.last)
			sleep 2
			page.driver.browser.switch_to.frame("resultsFrame")
			within('.pbBody') do
				within('.list') do					
					table=all("tbody")[0]
					table.all("tr")[1].all("th")[0].all('a')[0].click
				end
			end
			sleep 3
			page.driver.browser.switch_to.window(page.driver.browser.window_handles.first)			
			puts "clicked on lookup"
			within all('.pbSubsection')[1] do
				table =all("table")[0]
				if table.all("tr")[0].all("td")[1].has_css?('.requiredInput')== true
						find_field('SSI Theatre').select(arg["SSITheatre"])	
				else
				 puts "SSITheatre field is not mandatory to select"
				end
			
				if table.all("tr")[0].all("td")[3].has_css?('.requiredInput')== true
						page.find_field("Client Territory").select(arg["ClientTerritory"])		
				else
				 puts "ClientTerritory field is not mandatory to select"
				end
			
				if table.all("tr")[1].all("td")[3].has_css?('.requiredInput')== true
						page.find_field("Client Region").select(arg["ClientRegion"])				
				else
				 puts "Client Region field is not mandatory to select"
				end
			
				if table.all("tr")[2].all("td")[3].has_css?('.requiredInput')== true
						find_field('Country').select(arg["country"])				
				else
				 puts "Country field is not mandatory to select"
				end			
			
			end		
			
			sleep 5
			
			within all('.pbSubsection')[9] do
			
				fill_in "Close Date",:with => arg["CloseDate"]				
			end	
			
			#arg=getDetails "Opportunityvalues"
			within all('.pbSubsection')[8] do
				#if page.has_xpath?('.//label[text()="'"#{po_submission_date}"'"]/parent::td[contains(@class ,"requiredInput")]')
				table =all("table")[0]
				if table.all("tr")[2].all("td")[1].has_css?('.requiredInput')== true
					page.find_field("PO Submission Date").set(arg["POSubmissionDate"])
					 writeFailure "PO Submission Date is a required field"
				else
					 puts "PO Submission Date is a not required field"
				end
			
			end
			sleep 10
			# To find the Quote number is mandatory
			# within all('.pbSubsection')[7] do
				# if table.all("tr")[0].all("td")[1].has_css?('.requiredInput')== true
					# sleep 5
					# page.driver.browser.window_handles.first
					# find("img[alt='Quote Number Lookup (New Window)']").click
					# sleep 5
					# page.driver.browser.switch_to.window(page.driver.browser.window_handles.last)
					# sleep 10
					# page.driver.browser.switch_to.frame("resultsFrame")		
						# within('.pbBody') do			
							# table=all("tbody")[0]
							# table.all("tr")[1].all("th")[0].find('a').click					
						# end
					# sleep 3
					# page.driver.browser.switch_to.window(page.driver.browser.window_handles.first)
					# puts "Quote Number is selected"	
									
				# else
					 # puts "Quote Number is a not required field"
				# end
							
			#end	
			sleep 5
			
			rescue Exception=> ex
				writeFailure"Error while Entering all mandatory field"
				
	end
end

And(/^save the Opportunity$/) do  #Change 12-01
begin
	sleep 5
	within('.pbBottomButtons') do
		if  find(:button,'Save').visible?
			click_on " Save "
			puts"Save Button has been clicked"
		else
			puts "Save button is not available"
		end
	end
	if page.has_content? ("Error: Invalid Data.")
		writeFailure"The save action failed"
	else
		puts "The Opportunity has been saved successfully"
	end
	
	sleep 2
	rescue Exception=> ex
		writeFailure"Error while saving the Opportunity"
		writeFailure ex.message
	end
end

Then(/^edit the Opportunity and verify that the field 'Existing Business Line' should not be editable$/) do
begin
	sleep 5
		page.find('#topButtonRow').find(:button, 'Edit').click
		within('.pbBody') do
			if page.has_text?('Existing Business Line')
				if page.has_no_field?('Existing Business Line')
					puts "Existing Business Line field is not Editable"
				end
				if page.has_field?('Existing Business Line')
					writeFailure "Existing Business Line field is Editable "
				end
			else
				writeFailure "Existing Business Line field is not present over the page"
			end
		end
	rescue Exception=> ex
		writeFailure"Error while editing the Opportunity"
		writeFailure ex.message
	end
end

Then(/^edit the Opportunity$/) do
begin
	sleep 5
		 within all('.pbHeader')[2] do
		 	  click_on "Edit"
		  end
		puts"Existing Bussiness Line should becomes editable"		
	rescue Exception=> ex
		writeFailure"Error while editing the Opportunity"
		writeFailure ex.message
	end
end

And(/^Select "Recently Viewed Opportunity" from View list$/) do
	begin
	sleep 5
		if  find_field('fcf').find('option[selected]').text == "Recently Viewed Opportunities"
			within('.filterOverview') do
				#find(:xpath, '//input[@type="button" and @title="Go!"]').click
				click_on "Go!"
				puts "Opportunity tab refresh and all recently viewed Opportunities are listed"			
			end
		else
			select "Recently Viewed Opportunities", :from => "View:"
			puts "Opportunity tab refresh and all recently viewed Opportunities are listed"
		end	
		sleep 5
	rescue Exception=> ex
		writeFailure"Error while Recently Viewed Opportunity from View list"
		writeFailure ex.message
	end	

end

Then(/^open any existing Opportunity from the list$/) do
begin
sleep 5
	within('.x-grid3-body') do
		table = all("tbody")[0]	
		sleep 5
		table.all('tr')[0].all('td')[1].find('a').click
		puts "Opportunity Details page opens"
		sleep 5	
	end

	rescue Exception=> ex
	writeFailure"Error while  opening existing Opportunity Asset Name from the list"
	writeFailure ex.message
	end
end

And(/^I Verify that 'Existing Business Line' field should not be editable$/) do
begin
 sleep 5
		page.find('#topButtonRow').find(:button, 'Edit').click
		within('.pbBody') do
			if page.has_text?('Existing Business Line')
				if page.has_no_field?('Existing Business Line')
					puts "Existing Business Line field is not Editable"
				end
				if page.has_field?('Existing Business Line')
					writeFailure "Existing Business Line field is Editable "
				end
			else
				writeFailure "Existing Business Line field is not present over the page"
			end
		end
	rescue Exception=> ex
	writeFailure"Error while checking PO Submitted Amount is available"	
	writeFailure ex.message
	end
end

Then(/^verify the "Existing Business Line" field of an Opportunity$/) do
begin
	within all('.pbSubsection')[0] do
			 table=all("tbody")[0]	 
			
		if	table.all("tr")[6].all("td")[3].click ==true
			puts "Existing Bussiness Line is becomes editable. "
		else
			puts"Existing Bussiness Line should NOT becomes editable. "
		end
			 sleep 5
		
	end
	rescue Exception=> ex
		writeFailure"Error while verify the Existing Business Line field of an Opportunity"
		writeFailure ex.message
	end
end

And(/^click on any existing Opportunity Asset$/) do
begin
	sleep 5
	#This code for existing opportunity asset to click
	if  find_field('fcf').find('option[selected]').text == "All Opportunity Assets"
			select "Opportunity Asset - Renewal", :from => "View:"
			find(".wt-Opportunity_Asset").click
			select "All Opportunity Assets", :from => "View:"
			puts "All Opportunity Assets is selected"
	else
			select "All Opportunity Assets", :from => "View:"
			raise "All Opportunity Assets is selected"
	end
	
	within('.x-grid3-body') do
	
		within all('.x-grid3-row-table')[0] do
		
			 table =all("tbody")[0]
			  table.all("tr")[0].all("td")[2].find('a').click
			  puts "Existing Opportunity Asset is Opened"
		end
	end	
	rescue Exception=> ex
		writeFailure"Error while Opening existing Opportunity Asset"
		writeFailure ex.message
	end
end

Then(/^Select Opportunity Asset - Renewal from View list$/) do
begin
	sleep 5
	 puts find_field('fcf').find('option[selected]').text
		if  find_field('fcf').find('option[selected]').text == "Opportunity Asset - Renewal"
			select "All Opportunity Assets", :from => "View:"
			find(".wt-Opportunity_Asset").click
			select "Opportunity Asset - Renewal", :from => "View:"
			puts "Opportunity Asset - Renewal is selected"
		else
			select "Opportunity Asset - Renewal", :from => "View:"
			raise "Opportunity Asset - Renewal is selected"
		end
			
	rescue Exception=> ex
		writeFailure"Error while select Opportunity Asset - Renewal from View list"
		writeFailure ex.message
	end
end

And(/^open any existing Opportunity Asset - Renewal$/) do
begin
	sleep 5
	#This code for existing opportunity asset to click
	within('.x-grid3-body') do
	
		within all('.x-grid3-row-table')[0] do
			 table =all("tbody")[0]
			  table.all("tr")[0].all("td")[3].find('a').click
			  puts "Existing Opportunity Asset is opened"
		end
	end	
		
	rescue Exception=> ex
		writeFailure"Error while opening on existing Opportunity Asset"
		writeFailure ex.message
	end
end

And(/^verify the PO Submitted Date field$/) do
begin
 sleep 5
		within all('.pbSubsection')[8] do
			
			if page.has_content? "PO Submission Date"
				puts "PO Submission Date field is present" 
			else 
				writeFailure "PO Submission Date field is not present"
			end
		end
		
	rescue Exception=> ex
	writeFailure"Error while checking PO Submitted Amount is available"	
	writeFailure ex.message
	end
end
 
Then(/^click on go button$/) do
	begin
	sleep 5	
	within('.bFilterView') do
	sleep 5
		click_on("Go!", match: :first)	
	end	
	rescue Exception => ex
		puts "Error while clicking on Go button"
		puts "Unable to on Go button"
	end
end

And(/^search for created OpportunityAsset record$/) do
	begin
	sleep 5
		arg=getDetails 'OpportunityAssetvalues1'
		foundCount = ""
		puts arg["OpportunityAssetName"]
		
			within('.x-grid3-body') do
				if page.has_content?(arg["OpportunityAssetName"])
				puts "present"
				click_on arg["OpportunityAssetName"]
				else
				puts "not present"
				end
			end
	sleep 5	
	within all('.pbHeader')[0] do
			click_on "Delete"
		
	end
	sleep 5
	page.accept_confirm 
	
	rescue Exception => ex
		writeFailure "Error while search for created OpportunityAsset record"
		writeFailure ex.message
	end
end 


And(/^search for created OpportunityAsset record for PO submission$/) do
	begin
	sleep 5
	arg=getDetails 'OpportunityAssetvalues1'
	within('.x-grid3-body') do
		if page.has_content? arg["OpportunityAssetName"] 
			puts "present"
			click_on (arg["OpportunityAssetName"])

		else
			puts"not present"
		end
	end	
	within all('.pbHeader')[0] do
			click_on "Delete"
			
	end
	alert = page.driver.browser.switch_to.alert
	alert.accept	
	sleep 5
	
	arg=getDetails 'OpportunityAssetvalues2'
	within('.x-grid3-body') do
		if page.has_content? arg["OpportunityAssetName"] 
			puts "present"
			click_on (arg["OpportunityAssetName"])

		else
			puts"not present"
		end
		
	end	
	within all('.pbHeader')[0] do
			click_on "Delete"
			
	end
	alert = page.driver.browser.switch_to.alert
	alert.accept
	sleep 5
		
	rescue Exception => ex
		writeFailure "Error search for created OpportunityAsset record for PO submission"
		writeFailure ex.message
	end
end

And(/^search for created Opportunity record$/) do
	begin
	sleep 5
	arg=getDetails 'Opportunityvalues'
	within('.x-grid3-body') do
		if page.has_content? arg["OpportunityName"] 
			puts "present"
			click_on (arg["OpportunityName"])

		else
			puts"not present"
		end
	end	
	within all('.pbHeader')[0] do
			click_on "Delete"
			
	end
	alert = page.driver.browser.switch_to.alert
	alert.accept	
	sleep 5
	rescue Exception => ex
		writeFailure "Error while search for created Opportunity record"
		writeFailure ex.message
	end
end

Then(/^delete the OpportunityAsset$/) do
begin
	sleep 5
	within all('.pbHeader')[0] do
			click_on "Delete"
	end
	alert = page.driver.browser.switch_to.alert
	alert.accept	
	rescue Exception => ex
		writeFailure "Error while delete the OpportunityAsset "
		writeFailure ex.message
	end
end

Then(/^delete the Opportunity$/) do
begin
	sleep 5
	within all('.pbHeader')[0] do
			click_on "Delete"
	end
	alert = page.driver.browser.switch_to.alert
	alert.accept		
	rescue Exception => ex
		writeFailure "Error while delete the Opportunity"
		writeFailure ex.message
	end
end

And(/^I verify field Batch Type field is present or not in the Under Additional Information section of OpportunityAsset$/) do
begin
sleep 5
		within all('.pbSubsection')[4] do
			if page.has_content? "Batch Type"
			puts "Batch Type field is present" 
			else 
			writeFailure "Batch Type field is  not present"
			end				
			
		end
			rescue Exception=> ex
				writeFailure"Error while checking on Batch Type Under Additional Information section"
				writeFailure ex.message
	end
end

And(/^I verify field Batch Type field is editable or not in the Under Additional Information section of OpportunityAsset$/) do
begin
sleep 5
		within all('.pbSubsection')[3] do
			if page.has_select?('00N61000003Y6jo')
			  puts"Batch Type is a editable"
			  else
			  puts"Batch Type is not a editable"
			  end
		end
			rescue Exception=> ex
				writeFailure"Error while checking Batch Type is editable or not"
				writeFailure ex.message
	end
end

And(/^I verify the type of Batch Type field$/) do
begin
sleep 2
         if page.has_select?('Batch Type')
                 puts"Batch Type is a DropDown"
         else
                 writeFailure"Batch Type is not a DropDown"
         end
     rescue Exception => ex
               writeFailure "Error while verify the Batch Type"
              writeFailure ex.message
     end
end

 
And(/^I verify field (.*?) as required field or not on Asset$/) do |batch_type| 
begin
	sleep 5
	 if page.has_xpath?('.//label[contains(text(),"'"#{batch_type}"'")]/parent::td[contains(@class ,"requiredInput")]')
		 puts "Batch Type field is present and is a required field"
	 else
		 writeFailure "Batch Type field is not required field"
	 end	
		
	rescue Exception=> ex
		writeFailure"Error while verifying the Batch Type field"
		writeFailure ex.message
	end
end

Then(/^I check for all the values of Batch Type dropdown list$/) do
begin
	sleep 5
		within all('.pbSubsection')[4] do
		sleep 5
			if page.has_select?('00N61000003Y6jo')
				
				Datalist =["--None--","Expired","Renewal","Warranty","IBOW","Adds/Recovery Expired","Adds/Recovery Renewal","Adds/Recovery Uncovered"]
				 LOVinapplication =find(:xpath, "//*[contains(@name, '00N61000003Y6jP')]").all('option').collect(&:text)
				 
				if  LOVinapplication.sort == Datalist.sort 
					puts "All values are present in the dropdown"
					Datalist.each do |val|
								puts val	
					end
								
				else
					finalresult= LOVinapplication-Datalist
					writeFailure "These values are present in dropdown and not present in application list"
					finalresult.each do |val|
						writeFailure val	
						 
					end
					finalresult= Datalist- LOVinapplication
					writeFailure "These values are deleted from dropdown "
					finalresult.each do |val|
						writeFailure val	
						
					end
				
				end
			else
					puts "Batch Type is not editable"
			end
		end
			rescue Exception=> ex
				writeFailure "Error while checking for all the values of Batch Type dropdown list"	
				
	end
end

And(/^PO Submission Date field is populated$/) do 
begin
sleep 5
	arg=getDetails "Opportunityvalues"
	within all('.pbSubsection')[8] do
			page.find_field("PO Submission Date").set(arg["POSubmissionDate"])
			sleep 5
					
	end		
	rescue Exception=> ex
				writeFailure"Error when entering value to PO Submission Date field"	
				writeFailure ex.message	
	end

end

Then(/^Double click into PO Submitted Date field$/) do
	begin
	sleep 5
		within all('.pbSubsection')[8] do
			table=all("tbody")[0]
			table.all('tr')[2].all('td')[1].double_click != true
				if(find('.inlineEditDiv',:visible => true)['style'].should include('display: block','display: block'))
					puts "Double clicked on PO Submitted Date field"					 
				else
				if(find('.inlineEditDiv',:visible => true)['style'].should include('display:none', 'display: none'))
					writeFailure "Unable to Double click on PO Submitted Date field"		
				end	
				end
		end
		rescue Exception=> ex
				writeFailure"Unable to Double click on PO Submitted Date field"			
		end
end	

And(/^select Edit button$/) do
	begin
	sleep 5
		within(:id,'topButtonRow') do
			sleep 5
			if find(:button,'Edit').visible?
				click_on 'Edit'
				puts"Opportunity is editable"
			 else
			 sleep 5
				puts "Edit button is not available"
			 end
		
		end
		
		rescue Exception=> ex
			writeFailure "Error while clicking on Edit button"
			writeFailure ex.message
	end		 
end

And(/^verify the 'Renewal List Price Currency' field$/) do
begin
	sleep 5
	within all('.pbSubsection')[4] do
		table=all("tbody")[0]
		
		if table.all('tr')[0].all('td')[0].text == "Renewal List Price Currency"
			puts "The Renewal List Price Currency field is available and editable"
		else
			writeFailure "The Renewal List Price Currency field is  not available"
		end
				
	end
	rescue Exception=> ex
			writeFailure "verify the Renewal List Price Currency field"	
			writeFailure ex.message
	end

end	


Then(/^Verify 'Renewal List Price Currency' picklist value$/) do
begin
	sleep 5
	within all('.pbSubsection')[4] do
		sleep 2
			if page.has_select?('00N61000003Y6j3')
								 
					  Datalist =["--None--","CHF","DKK","EUR","GBP","SEK"]
					 LOVinapplication =find(:xpath, "//*[contains(@name, '00N61000003Y6j3')]").all('option').collect(&:text)
					 
					if  LOVinapplication.sort == Datalist.sort 
						puts "All values are present in the dropdown"
						Datalist.each do |val|
									puts val	
						end
					else
						finalresult= LOVinapplication-Datalist
						finalresult.each do |val|
							writeFailure "Invalid values present in the dropdown #{val}"
							 
						end
						finalresult= Datalist-LOVinapplication
						finalresult.each do |val|
							writeFailure "These values are deleted from dropdown #{val}"
							
						end
					end
			else
				puts "Renewal List Price Currency is not editable"
			end
	end
	rescue Exception=> ex
			writeFailure"Error while verifying Verifying Renewal List Price Currency picklist"
			writeFailure ex.message
	end

end

And(/^verify the 'Renewal Currency' field is editable or not$/) do
begin
	sleep 5
	within all('.pbSubsection')[4] do
		table=all("tbody")[0]		
		if page.has_select?('00N61000003Y6j2')
				puts"Renewal Currency field is editable"
			else
				writeFailure"Renewal Currency field is not a editable"
			end
	end
	rescue Exception=> ex
			writeFailure "Error while verifying the Renewal Currency field"
			writeFailure ex.message
	end

end	


And(/^find the field (.*?) is mandatory$/) do |renewal_currency| 
	begin
		sleep 5	
		
		if page.has_xpath?('.//label[text()="'"#{renewal_currency}"'"]/parent::td[contains(@class ,"requiredInput")]')
			 writeFailure "Renewal_currency field is a required field"
		 else
			 puts "Renewal_currency field is not required field"
		 end	
			
		rescue Exception=> ex
			writeFailure"Error while verifying the renewal currency field"
			writeFailure ex.message
	end
end

And(/^verify the Renewal Currency field type$/) do 
	begin
		sleep 3
		within all('.pbSubsection')[4] do
			if page.has_select?('00N61000003Y6j2')
				puts"Renewal Currency is a DropDown"
			 else
				writeFailure"Renewal Currency is not a DropDown"
			 end
		end
	rescue Exception=> ex
		writeFailure"Error while verifying the Renewal Currency"
		writeFailure ex.message
	end

end

And(/^verify the 'Renewal Currency' field$/) do
begin
	sleep 5
	within all('.pbSubsection')[4] do
		table=all("tbody")[0]
		
		
		if table.all('tr')[1].all('td')[0].text == "Renewal Currency"
			puts "The Renewal Currency field is available and editable"
		else
			writeFailure "The Renewal Currency field is  not available"
		end
				
		
	end
	rescue Exception=> ex
			writeFailure "verify the Renewal Currency field"
			writeFailure ex.message
	end

end	

Then(/^Verify 'Renewal Currency' picklist value$/) do
	begin
	sleep 5
	within all('.pbSubsection')[4] do
			if page.has_select?('00N61000003Y6j2')
				 
				 
				puts "The following values should be available:"
			  Datalist =["--None--","CHF","DKK","EUR","GBP","SEK"]
				 LOVinapplication =find(:xpath, "//*[contains(@name, '00N61000003Y6j2')]").all('option').collect(&:text)
				 
				if  LOVinapplication.sort == Datalist.sort 
					puts "All values are present in the dropdown"
					Datalist.each do |val|
								puts val	
					end
								
				else
					finalresult= LOVinapplication-Datalist
					finalresult.each do |val|
						puts "These values are present in dropdown and not present in application list #{val}"
						 
					end
					finalresult= Datalist-LOVinapplication
					finalresult.each do |val|
						puts "These values are deleted from dropdown #{val}"
						
					end
				
				end
			else
				puts "Renewal Currency is not editable"
			end
	end
	rescue Exception=> ex
			writeFailure"Verify Renewal Currency picklist"	
				
	end

end



Then(/^open any existing Open Opportunity from the list$/) do
begin
sleep 5
	within('.x-grid3-body') do
		table = all("tbody")[0]	
		table.all('tr')[0].all('td')[1].find('a').click
		puts "Opportunity Details page opens"
		sleep 5	
	end

	rescue Exception=> ex
	writeFailure"Error while  opening existing Opportunity Asset Name from the list"
	writeFailure ex.message
	end
end

Then(/^'Renewal List Price Currency' and  'Renewal Currency' fields are available$/) do
	begin
		sleep 5
		within all('.pbSubsection')[4] do
			table=all("tbody")[0]
		
			if page.has_content? "Renewal List Price Currency"
				puts "Renewal List Price Currency field is present" 
			else 
				puts  "Renewal List Price Currency field is not present"
			end
			if page.has_content? "Renewal Currency"
				puts "Renewal Currency field is present" 
			else 
				puts  "Renewal Currency field is not present"
			end
					
		end
		rescue Exception=> ex
				writeFailure "Error while verifying 'Renewal List Price Currency' and 'Renewal Currency' fields are available."	
					writeFailure ex.message
	end

end

And(/^'Renewal List Price Currency' and  'Renewal Currency' fields are readonly$/) do
	begin
	sleep 5
		within all('.pbSubsection')[4] do
			if page.has_select?('00N61000003Y6j3')
					puts"Renewal List Price Currency field is editable"
				else
					puts"Renewal List Price Currency is not a editable"
			end
			if page.has_select?('00N61000003Y6j2')
					puts"Renewal List Price Currency field is editable"
				else
					puts"Renewal List Price Currency is not a editable"
			end
					
		end
		rescue Exception=> ex
			writeFailure "Error while verifying 'Renewal List Price Currency' and 'Renewal Currency' fields are readonly."
			writeFailure ex.message
	end
end


 
Given(/^I login as OperationsManager$/) do
	begin
	sleep 5
		page.find(:id, "userNavLabel").click
		sleep 10
		within all('.mbrMenuItems')[0] do
			click_on 'Setup'
			sleep 2
		end
		sleep 5
		click_on 'Manage Users'
		sleep 10
		click_on 'Users'
		sleep 10
		click_on ('Login - Record 7 - Operations Manager, Leica')
		sleep 10
		puts "login sales Ops"
		rescue Exception=> ex
			writeFailure"Error while Navigating to Opportunities Assets tab as sales ops"
			writeFailure ex.message
	end
end

And(/^Select All Opportunities from View list$/) do
	begin
	sleep 2
		if  find_field('fcf').find('option[selected]').text == "All Opportunities"
			within('.filterOverview') do
				#find(:xpath, '//input[@type="button" and @title="Go!"]').click
				click_on "Go!"
				puts "All Opportunities are listed"			
			end
		else
			select "All Opportunities", :from => "View:"
			puts "Selecting All Opportunities from View list"
			sleep 5	
        end			
		rescue Exception=> ex
			writeFailure"Error while selecting All Opportunities from View list"
			writeFailure ex.message
		end	

end

And(/^click on the Opportunity Name link$/) do	
begin
sleep 5
	within('.x-grid3-body') do
		within('.x-grid3-row-first') do
				table = all("tbody")[0]	
				sleep 2		
			table.all('tr')[0].all('td')[1].all('a')[0].click
			puts "Existing Opportunity Name link is opened"	
			sleep 5	
		end
	end
		
	rescue Exception=> ex
		writeFailure"Error while  opening existing Opportunity Name from the list"
		writeFailure ex.message
end
end

And (/^click on New Quote button$/) do 
	begin	
	sleep 5
		within('.oRight') do
		
			click_on "New Quote"
			puts "New Quote button is clicked"
		end
		rescue Exception=> ex
			writeFailure"Error while clicking on New Quote button"
			writeFailure ex.message
	end
end

And(/^Enter all required fields information$/) do
	begin
	sleep 5
	arg=getDetails 'Quotesdetails'
	
		within all('.pbSubsection')[0] do			
			puts "hi8"
			sleep 2
			page.find_field('Quote Type').select("Direct")
			
		end	
		
	rescue Exception=> ex
			writeFailure"Error while clicking on New Quote button"
			writeFailure ex.message
	end
end

Then(/^I verify Ops Stage field is present in the Opportunity or not$/) do
begin
sleep 5
	within all('.pbSubsection')[0] do
		if page.has_content? "Ops Stage"
			puts "Ops Stage field is present" 
		else 
			puts  "Ops Stage field is  not present"
		end				
				
	end
rescue Exception=> ex
			writeFailure"Error verify Ops Stage field"
			writeFailure ex.message
	end

end

Then(/^I verify type of the Ops Stage field$/) do
begin
sleep 5
	within all('.pbSubsection')[0] do
		if page.has_select?('00N61000003Y6iq')
			  puts"Ops Stage is a DropDown"
			  else
			  puts"Ops Stage is not a DropDown"
			  end			
				
	end
rescue Exception=> ex
			writeFailure"Error verify Ops Stage field"
			writeFailure ex.message
	end

end


Then(/^I verify Ops Stage field is editable or not$/) do
begin
sleep 5
	within all('.pbSubsection')[0] do
		if page.has_select?('00N61000003Y6iq')
			  puts"Ops Stage is a editable"
			  else
			  writeFailure "Ops Stage is not editable"
			  end			
				
	end
rescue Exception=> ex
			writeFailure"Error verify Ops Stage field"
			writeFailure ex.message
	end

end

 
And(/^I verify (.*?) field mandatory or not$/) do |ops_stage| 
begin
	sleep 5
	 if page.has_xpath?('.//label[contains(text(),"'"#{ops_stage}"'")]/parent::td[contains(@class ,"requiredInput")]')
		 writeFailure "Ops Stage field is present and is a required field"
	 else
		 puts "Ops Stage field is not required field"
	 end	
		
	rescue Exception=> ex
		writeFailure"Error while verifying the Ops Stage field"
		writeFailure ex.message
	end
end 


Then(/^verify the PO Accepted field is present in Ops Stage field$/) do
begin
	sleep 5
	within all('.pbSubsection')[0] do
	flag=0
			table=all("tbody")[0]
				table.all("tr")[4].all("td")[2].click
				 sleep 2
				 ExistingRecord=["PO Accepted"]
				 @LOV =find(:xpath, "//*[contains(@name, '00N61000003Y6iq')]").all('option').collect(&:text)	
								 
				ExistingRecord.each do |i|
					if @LOV.include?(i)
						puts "The #{i} is present"
					else	
						flag=1
						writeFailure "The option #{i} is not present"
					end
				end	 
		
	end
	rescue Exception=> ex
			writeFailure"Error Verify PO Accepted field"
			writeFailure ex.message
	end
end


 
And(/^verify the Opportunity type field is available$/) do
	begin
		sleep 5
		within all('.pbSubsection')[0] do
			if page.has_content? "Opportunity Type"
				puts "Opportunity type field is present" 
			else 
				writeFailure "Opportunity type field is not present"
			end
		end
		rescue Exception=> ex
			writeFailure"Verify Opportunity type field"	
			writeFailure ex.message
	end
end

And(/^verify the Opportunity type field is editable$/) do
	begin
		sleep 5
		within all('.pbSubsection')[0] do
			if page.has_select?('00N61000003Y6ip')
				puts"Opportunity type field is editable"
			else
				writeFailure"Opportunity type is not a editable"
			end
		end
		rescue Exception=> ex
		writeFailure"Error while verifying the Opportunity type field is editable"
		writeFailure ex.message
	end
end

And(/^check the (.*?) is mandatory$/) do |opportunity_type|
	begin
		sleep 5
		
		if page.has_xpath?('.//label[contains(text(),"'"#{opportunity_type}"'")]/parent::td[contains(@class ,"requiredInput")]')
			writeFailure "Opportunity type field is a required field"
		else
			puts "Opportunity type field is not required field"
		end			
		rescue Exception=> ex
			writeFailure"Error while verifying the opportunity type field"
			writeFailure ex.message
	end		
end

And (/^verify the Opportunity type field type$/) do
	begin
		sleep 3
		within all('.pbSubsection')[0] do
			if page.has_select?('00N61000003Y6ip')
				puts"Opportunity type is a DropDown"
			 else
				writeFailure"Opportunity type is not a DropDown"
			 end
		end
	rescue Exception=> ex
		writeFailure"Error while verifying the Opportunity type"
		writeFailure ex.message
	end
end 

Then(/^verify the picklist value of Opportunity type field$/) do
	begin
		sleep 5
		within all('.pbSubsection')[0] do
				if page.has_select?('00N61000003Y6ip')
					 LOVinapplication =find(:xpath, "//*[contains(@name, '00N61000003Y6ip')]").all('option').collect(&:text)
					 
					Datalist =["--None--","CORE","Auto-Renewal"]
					 
					if  LOVinapplication.sort == Datalist.sort 
						puts "All values are present in the dropdown"
						Datalist.each do |val|
							puts val	
						end
									
					else
						finalresult= LOVinapplication-Datalist						
						finalresult.each do |val|
							writeFailure "Invalid values present in the dropdown #{val}"
							
					end
						finalresult= Datalist-LOVinapplication
						finalresult.each do |val|
							writeFailure "These values are deleted from dropdown #{val}" 								
						end					
					end	
				else
					puts "Opportunity type is not editable"
				end
		end
		rescue Exception=> ex
				writeFailure"Verify Opportunity type picklist"	
						
	end
end


And (/^Enter all fields information$/) do
	begin
	sleep 5
		arg=getDetails "Quotesdetails"			
		within all('.detailList')[0] do	
			table=all("tbody")[0]		
			all('tr')[2].all('td')[1].select(arg["QuoteType"])		
			all('tr')[3].all('td')[1].select(arg["QuoteTypeYear"])					
		end
		within all('.pbSubsection')[1] do			
			find_field("Earliest New Start Date").set(arg["EarliestNewStartDate"])
			find_field("Latest New End Date").set(arg["LatestNewEndDate"])
			find_field("Currency").set(arg["currency"])
			fill_in	"Transaction Amount",:with=> arg["TransactionAmount"]						
		end		
			rescue Exception=> ex
			writeFailure"Error while  opening existing Opportunity Name from the list"
			writeFailure ex.message
	end
end

And(/^click on Save button to save Quote$/) do
	begin
	sleep 5
		within('.pbHeader') do
			click_on 'Save'
			sleep 5
		end
		rescue Exception=> ex
			writeFailure"Error while clicking on Save button"	
			writeFailure ex.message
	end
end



And(/^Click on the Opportunity Name link from the Opportunity field$/) do
	begin
		within all('.pbSubsection')[0] do	
			table=all("tbody")[0]
			all('tr')[0].all('td')[3].all('a')[0].click
		end
		rescue Exception=> ex
			writeFailure"Error while  opening existing Opportunity Name from the list"
			writeFailure ex.message
	end
end	


		
And(/^verify labels (.*?) and (.*?) present on Asset are required fields$/) do |batch_Type,client_Batch_Year|   
begin
	sleep 5	
	_checkIfTheFieldIsRequired(batch_Type)
	_checkIfTheFieldIsRequired(client_Batch_Year)	
	rescue Exception=> ex
		puts"Error while verify labels Batch Type and Client Batch Year on Asset"
		puts ex.message
	end
end
Then(/^click on Edit button$/) do
	begin
	sleep 5		
		within(:id,'topButtonRow') do
			click_on 'Edit'
			sleep 5
		end		
		rescue Exception=> ex
			writeFailure"Error while clicking on Edit button"	
			writeFailure ex.message
	end		 
end


And(/^verify the Direct or Channel field is available$/) do
	begin
		sleep 5
		within all('.pbSubsection')[0] do
			if page.has_content? "Direct/Channel"  
				puts "Direct/Channel field is present" 
			else 
				writeFailure "Direct/Channel field is not present"
			end			
		end
		rescue Exception=> ex
			writeFailure"Error Verify  Direct/Channel field"	
			writeFailure ex.message			
	end
end

And(/^verify the 'Direct or Channel' field is editable or not$/) do
	begin
		sleep 5
		within all('.pbSubsection')[0] do
			if page.has_select?('00N61000003Y6iJ')
				puts"Direct/Channel field is editable"
			else
				writeFailure "Direct/Channel field is not a editable"
			end
		end
		rescue Exception=> ex
		writeFailure"Error while verifying the Direct/Channel field is editable"
		writeFailure ex.message
	end
end

And(/^check field "(.*?)" is mandatory$/) do |direct_channel|
	begin
		sleep 5	
			
			if page.has_xpath?('.//label[text()="'"#{direct_channel}"'"]/parent::td[contains(@class ,"requiredInput")]')
			writeFailure "Direct/Channel field is a required field"
		else
			puts "Direct/Channel field is not required field"
		end		
		rescue Exception=> ex
			writeFailure"Error while verifying the Direct/Channel field"
			writeFailure ex.message
	end

end

And(/^verify the Direct or Channel field type$/) do
	begin
	sleep 5
		within all('.pbSubsection')[0] do	
			if page.has_select?('00N61000003Y6iJ')
				puts "Direct/Channel field is a dropdown" 
			else 
				writeFailure "Direct/Channel field is not a dropdown"
			end
		end
		rescue Exception=> ex
		writeFailure"Error while verifying the Direct/Channel field"
		writeFailure ex.message
	end
end

 

Then(/^check the picklist value of Direct or Channel$/) do
begin
	sleep 5
	within all('.pbSubsection')[0] do
			if page.has_select?('00N61000003Y6iJ')
				sleep 2
				 LOVinapplication =find(:xpath, "//*[contains(@name, '00N61000003Y6iJ')]").all('option').collect(&:text)	
				Datalist =["--None--","Direct","Channel Tier 1","Channel Tier 2"]
				 
				if  LOVinapplication.sort == Datalist.sort 
					puts "All values are present in the dropdown"
					Datalist.each do |val|
								puts val	
					end
								
				else
					finalresult= LOVinapplication-Datalist
					finalresult.each do |val|
						writeFailure "Invalid values present in dropdown #{val}"
						 
					end
					finalresult= Datalist-LOVinapplication
					finalresult.each do |val|
						writeFailure "These values are deleted from dropdown #{val}"
						
					end
				
				end 
			else
				puts "Direct/Channel field is not editable"
			end
	end
	rescue Exception=> ex
			writeFailure"error verify the picklist value of Direct/Channel field"		
			
	end

end



Then(/^verify the field Opportunity Currency field is available or not$/) do
	begin
		sleep 5
		within all('.pbSubsection')[0] do	
			if page.has_content? "Opportunity Currency"
				puts "Opportunity Currency field is present" 
			else 
				writeFailure  "Opportunity Currency field is not present"
			end
		end
		rescue Exception=> ex
			writeFailure"Verify  Opportunity Currency field"	
			writeFailure ex.message
	end

end

And(/^verify the 'Opportunity Currency' field is editable or not$/) do
begin
	sleep 5
		within all('.pbSubsection')[0] do
			if page.has_select?('opp16')
				puts"Opportunity Currency field is editable"
			else
				writeFailure"Opportunity Currency is not a editable"
			end
		end
		rescue Exception=> ex
			writeFailure"Error while verifying the Opportunity Currency field is editable"
			writeFailure ex.message
	end
end

And(/^check whether field (.*?) is mandatory$/) do |opportunity_currency|
	begin
		sleep 5	
		puts opportunity_currency
		if page.has_xpath?('.//label[text()="'"#{opportunity_currency}"'"]/parent::td[contains(@class ,"requiredInput")]')
			 puts "Opportunity Currency field is present and is a required field"
		 else
			 puts "Opportunity Currency field is not required field"
		 end	
			
		rescue Exception=> ex
			writeFailure"Error while verifying the Opportunity Currency field"
			writeFailure ex.message
	end
end

And(/^verify the Opportunity Currency field type$/) do
	begin
		sleep 3
		within all('.pbSubsection')[0] do
			if page.has_select?('opp16')
				puts"Opportunity Currency field is a DropDown"
			 else
				writeFailure"Opportunity Currency field is not a DropDown"
			 end
		end
	rescue Exception=> ex
		writeFailure"Error while verifying the Opportunity Currency field"
		writeFailure ex.message
	end

end

And(/^check the picklist value of Opportunity Currency$/) do
	begin
		sleep 5
		within all('.pbSubsection')[0] do
			if page.has_select?('opp16')
					sleep 2
					 LOVinapplication =find(:xpath, "//*[contains(@name, 'opp16')]").all('option').collect(&:text)	
					Datalist =["CHF - Swiss Franc","DKK - Danish Krone","EUR - Euro","GBP - British Pound","SEK - Swedish Krona"]
			 
				if  LOVinapplication.sort == Datalist.sort 
					puts "All values are present in the dropdown"
					Datalist.each do |val|
								puts val	
					end
										
				else
					finalresult= LOVinapplication-Datalist
					finalresult.each do |val|
						puts "These values are present in application list #{val}"
						 
					end
					finalresult= Datalist-LOVinapplication
					finalresult.each do |val|
						puts "These values are deleted from dropdown #{val}"
						
					end
				end

			else
				puts "Opportunity Currency field is not editable"
			end


		end
		rescue Exception=> ex
				writeFailure"error verify the picklist value of Opportunity Currency field"		
				
	end

end


Then(/^verify the field Client Region is available$/) do
	begin
		sleep 5
		within all('.pbSubsection')[1] do
			if page.has_content? "Client Region"
				puts "Client Region field is present" 
			else 
				writeFailure "Client Region field is not present"
			end
		end		
		rescue Exception=> ex
			writeFailure"Error verify the Client Region field is available"	
			writeFailure ex.message
	end

end

And(/^verify the 'Client Region' field is editable or not$/) do
	begin
		sleep 5
		within all('.pbSubsection')[1] do
			if page.has_select?('00N61000003Y6i2')
				puts "Client Region field is editable"
			else
				writeFailure "Client Region field is not a editable"
			end
		end
		rescue Exception=> ex
			writeFailure"Error while verifying the Client Region field is editable"
			writeFailure ex.message
	end
end

And (/^check whether field (.*?) is a mandatory$/) do |client_region|
	begin
	sleep 5	
			if page.has_xpath?('.//label[text()="'"#{client_region}"'"]/parent::td[contains(@class ,"requiredInput")]')
				 puts "Client Region field is a required field"
			 else
				 writeFailure "Client Region field is not required field"
			 end			
		rescue Exception=> ex
			writeFailure"Error while verifying the Client Region field"
			writeFailure ex.message
	end
end

And(/^verify the Client Region field type$/) do
	begin
		sleep 3
		within all('.pbSubsection')[1] do
			if page.has_select?('00N61000003Y6i1')
				puts"Client Region field is a DropDown"
			 else
				writeFailure"Client Region field is not a DropDown"
			 end
		end
		rescue Exception=> ex
			writeFailure"Error while verifying the Client Region field"
			writeFailure ex.message
	end
end


And(/^check the picklist value of Client Region$/) do
	begin
		sleep 5
		within all('.pbSubsection')[1] do
		sleep 2
			if page.has_select?('00N61000003Y6i2')	
					sleep 2
					LOVinapplication =find(:xpath, "//*[contains(@name, '00N61000003Y6i1')]").all('option').collect(&:text)	
					Datalist =["EMEA"]
					
					if  LOVinapplication.sort == Datalist.sort 
						puts "All values are present in the dropdown"
							Datalist.each do |val|
								puts val	
							end										
					else					
						finalresult= LOVinapplication-Datalist						
							finalresult.each do |val|
								writeFailure "Invalid values present in the dropdown #{val}"
							end
							finalresult= Datalist-LOVinapplication
								finalresult.each do |val|
									writeFailure "These values are deleted from dropdown #{val}" 								
								end					
					end	
			else
				puts "Client Region field is not editable"
			end
		end
			rescue Exception=> ex
				writeFailure"Error while verifying the Client Region field"	
						
	end
end


Then(/^I verify the field Client Territory$/) do
begin
	sleep 5
	within all('.pbSubsection')[1] do
		if page.has_content? "Client Territory"
			puts "Client Territory field is present" 
		else 
			writeFailure "Client Territory field is not present"
		end				
				 
		
	end
	rescue Exception=> ex
			writeFailure"Verify  Client Region field"	
				writeFailure ex.message
	end

end


And(/^I verify the field Client Territory field is editable or not$/) do
begin
sleep 5
	within all('.pbSubsection')[1] do
			if page.has_select?('00N61000003Y6i2')
			  puts "Client Territory is a Editable"
			  else
			  writeFailure"Client Territory is not a Editable"
			  end
	end

	rescue Exception => ex
		writeFailure "Error while verify the Client Territory"
		writeFailure ex.message

	end

end
 
And(/^I verify the type of the field Client Territory$/) do
begin
sleep 5
	within all('.pbSubsection')[1] do
			if page.has_select?('00N61000003Y6i2')
			  puts "Client Territory is a DropDown"
			  else
			  writeFailure"Client Territory is not a DropDown"
			  end
	end

	rescue Exception => ex
		writeFailure "Error while verify the Client Territory"
		writeFailure ex.message

	end

end




And(/^I verify the field (.*?) is mandatory or not$/) do |client_territory| 
begin
	sleep 5
	 if page.has_xpath?('.//label[contains(text(),"'"#{client_territory}"'")]/parent::td[contains(@class ,"requiredInput")]')
		 writeFailure "Client Territory field is required field"
	 else
		 puts "Client Territory field is not required field"
	 end	
		
	rescue Exception=> ex
		writeFailure"Error while verifying the Client Territory field"
		writeFailure ex.message
	end
end

And(/^check the picklist value of Client Territory$/) do
begin
	sleep 5
	within all('.pbSubsection')[1] do
			if page.has_select?('00N61000003Y6i2')
				
				sleep 5
				 LOVinapplication =find(:xpath, "//*[contains(@name, '00N61000003Y6i2')]").all('option').collect(&:text)	
				Datalist =["EMEA"]
				
				if  LOVinapplication.sort == Datalist.sort 
					puts "All values are present in the dropdown"
					Datalist.each do |val|
								puts val	
					end
								
				else
					finalresult= LOVinapplication-Datalist
					puts "These values are extra present in the application"
					finalresult.each do |val|
					
						writeFailure val	
						 
					end
					finalresult= Datalist-LOVinapplication
					puts "These values are deleted from dropdown "
					finalresult.each do |val|
							writeFailure val	
					end
				
				end
			else
				puts "Client Territory is not editable"
			end
				
	end
	rescue Exception=> ex
			writeFailure"Error verify the picklist value of Client Territory"		
			
	end

end


Then(/^I verify the field Business Line$/) do
begin
	sleep 5
	within all('.pbSubsection')[0] do
				
		if page.has_content? "Business Line"
			puts "Business Line field is present" 
		else 
			writeFailure  "Business Line field is not present"
		end				
				
	end
	rescue Exception=> ex
			writeFailure"Verify  Business Line field"	
				writeFailure ex.message
	end

end


And(/^I verify field Business Line is editable or not$/) do
begin
sleep 5
	within all('.pbSubsection')[0] do
			if page.has_select?('00N61000003Y6hh')
			  puts"Business Line is a editable"
			  else
			  writeFailure"Business Line is a not editable"
			  end
	end

	rescue Exception => ex
		writeFailure "Error while verify the Business Line"
		writeFailure ex.message

	end

end



And(/^I verify field type of the Business Line$/) do
begin
sleep 5
	within all('.pbSubsection')[0] do
			if page.has_select?('00N61000003Y6hh')
			  puts"Business Line is a DropDown"
			  else
			  writeFailure"Business Line is not a DropDown"
			  end
	end

	rescue Exception => ex
		writeFailure "Error while verify the Business Line"
		writeFailure ex.message

	end

end

Then(/^I verify (.*?) field is mandatory or not$/) do |business_line| 
begin
	sleep 5
	if page.has_xpath?('.//label[contains(text(),"'"#{business_line}"'")]/parent::span/parent::td[contains(@class ,"requiredInput")]')
	 
		 puts "Business Line field is a required field"
	 else
		 writeFailure "Business Line field is not required field"
	 end	
		
	rescue Exception=> ex
		writeFailure"Error while verifying the Business Line field"
		writeFailure ex.message
	end
end

And(/^check the picklist value of Business Line$/) do
begin
	sleep 5
	within all('.pbSubsection')[0] do
			if page.has_select?('00N61000003Y6hh')
				sleep 5
				 LOVinapplication =find(:xpath, "//*[contains(@name, '00N61000003Y6hh')]").all('option').collect(&:text)	
				Datalist =["WP","WV"]
							 
				if  LOVinapplication.sort == Datalist.sort 
					puts "All values are present in the dropdown"
					Datalist.each do |val|
								puts val	
					end
								
				else
					finalresult= LOVinapplication-Datalist
					finalresult.each do |val|
						puts "These values are invalid #{val}"
						 
					end
					finalresult= Datalist-LOVinapplication
					finalresult.each do |val|
						puts "These values are deleted from dropdown #{val}"
						
					end
				
				end
			else
			
				writeFailure "Business Line is not editable"
			end
				
	end
	rescue Exception=> ex
			writeFailure"Error verify the picklist value of Business Line"		
			writeFailure ex.message
	end

end


When(/^I navigate to Quotes tab$/) do
begin
	sleep 5
	find('a',:text=> "Quotes").click
			puts "Quotes tab opens"
	rescue Exception=> ex
		writeFailure"Error while navigating to Quotes tab"
		writeFailure ex.message
	end
end
	

And(/^select all Quotes$/) do
	begin
		sleep 2	
			
		select 'All Quotes' ,:from => 'View:'
		sleep 2
		rescue Exception => ex
		writeFailure "Error while selecting all Quotes"
		writeFailure ex.message
	end
end


And(/^click on new button$/) do
	begin
	sleep 5
	within('.pbHeader') do
	sleep 2
		if find(:button,'New').visible?
				click_on "New"
			puts"New Button is clicked"
		else
			puts "New Button is not present for this user"
		end
	end
	
	rescue Exception => ex
	writeFailure "Error while finding new button"
	
	end
end


Then(/^select any quote$/) do
	begin
	sleep 5
	within('.x-grid3-body') do
		table=all("tbody")[0]
		if (ENV['UserRole']=="WW Exec")
			table.all('tr')[0].all('td')[0].all('a')[0].click
			puts "Quote is selected"
			else
			table.all('tr')[0].all('td')[2].all('a')[0].click
			puts "Quote is selected"
		end
	end
	
	rescue Exception => ex
	writeFailure "Error while select any quote"
	writeFailure ex.message
	end
end

Then(/^I verify the Discount Amount field is available or not$/) do
	begin
	sleep 5
	within all('.pbSubsection')[1] do
		if page.has_content? "Discount Amount"
			puts "Discount Amount field is present" 
		else 
			writeFailure "Discount Amount field is not present"
		end				
			
	end
	
	rescue Exception => ex
	writeFailure "Error while verify the Discount Amount field"
	writeFailure ex.message
	end
end	


 
And(/^I verify the (.*?) field is not mandatory$/) do |discount_amount| 
	begin
	sleep 5
	within all('.pbSubsection')[1] do
		if page.has_xpath?('.//label[contains(text(),"'"#{discount_amount}"'")]/parent::td[contains(@class ,"requiredInput")]')
		 writeFailure "Discount Amount field is present and is a required field"
	 else
		 puts "Discount Amount field is not required field"
	 end
	sleep 5
	end
	
	rescue Exception => ex
	writeFailure "Error while verifying the field Discount Amount"
	writeFailure ex.message
	end
end



Then(/^verify the picklist of the Currency in Quote$/) do
begin
	sleep 5
	within all('.pbSubsection')[1] do
		if page.has_select?('CurrencyIsoCode')	
				sleep 2
				 LOVinapplication =find(:xpath, "//*[contains(@name, 'CurrencyIsoCode')]").all('option').collect(&:text)	
				Datalist =["CHF - Swiss Franc","DKK - Danish Krone","EUR - Euro","GBP - British Pound","SEK - Swedish Krona"]	
				
				 
				if  LOVinapplication.sort == Datalist.sort 
					puts "All values are present in the dropdown"
					Datalist.each do |val|
								puts val	
					end
								
				else
					finalresult= LOVinapplication-Datalist
					finalresult.each do |val|
						puts "These values are present in dropdown and not present in application list #{val}"
						 
					end
					writeFailure "These values are not present "
					finalresult= Datalist-LOVinapplication
					finalresult.each do |val|
						puts val
						
					end
				
				end
		else
			puts "Currency field is not editable"
		end
	end
	rescue Exception=> ex
			writeFailure"Error verify the picklist value of Currency field"		
			
	end

end



Then(/^enter the data to mandatory field to create the Opportunity for quote validation$/) do
begin
sleep 5
	arg=getDetails "Opportunityvalues"

		within all('.pbSubsection')[0] do	
			table = all("tbody")[0]	
			sleep 2		
			fill_in	"Opportunity Name",:with=> arg["OpportunityName"]
			sleep 1
			find(:id, "00N61000003Y6hh").select(arg["BusinessLine"])
			#table.all('tr')[5].all('td')[1].select "WP", :from => "Business Line"
			sleep 2				
			page.find_field('Opportunity Currency').select(arg["OpportunityCurrency"])
			sleep 2		
			find(:id, "opp11").select(arg["stage"])
			sleep 2		
			find(:id, "00N4B000000L2EB").select(arg["ExistingBusinessLine"])
			sleep 2			
		end
			page.driver.browser.window_handles.first
			find("img[alt='Account Name Lookup (New Window)']").click
			sleep 5
			page.driver.browser.switch_to.window(page.driver.browser.window_handles.last)
			sleep 10
			page.driver.browser.switch_to.frame("resultsFrame")			
			within('.list') do
				tr = first("tbody").all("tr")
				tr.each do |row|
						if row.all("th")[0].text == "testing_acc"
							row.all("th")[0].all('a')[0].click
							break
						end         
				end
			end
			sleep 3
			page.driver.browser.switch_to.window(page.driver.browser.window_handles.first)
			sleep 2
			puts "clicked on lookup"			
		within all('.pbSubsection')[1] do
			sleep 2
			page.find_field("SSI Theatre").select(arg["SSITheatre"])
			sleep 2	
			page.find_field("Client Territory").select(arg["ClientTerritory"])
			sleep 2		
			page.find_field("Client Region").select(arg["ClientRegion"])
			sleep 2		
			page.find_field("Country").select(arg["country"])
			sleep 2			
		end
		within all('.pbSubsection')[9] do
			page.find_field("Close Date").set(arg["CloseDate"])		
			sleep 2		
		end				
		rescue Exception=> ex
			writeFailure"Error when Required fields are populated"	
			writeFailure ex.message
	end
end


And(/^Select an opportunity that does not have a quote attached yet$/) do
begin  
sleep 5
		arg=getDetails 'Opportunityvalues'
		puts @oppName
	
		sleep 5
		foundCount = ""
		#puts OpportunityName
		
		#if page.has_content? arg["OpportunityName"]
		if page.has_content? @oppName
			begin  
				within(".x-grid3-body") do
					div = all(".x-grid3-row")
					div.each do |row|
						#if row.all("td")[1].text==arg["Name"]
						if row.all("td")[1].text==@oppName
							row.all("td")[1].all('a')[0].click					
							sleep 5
							foundCount = "found"
							break
							end
					end	
				end	
				if page.has_css?('.next')
					find(".next").click
					sleep 3
					else
					break
				end
			end until (page.has_css?('.nextoff'))			
			if foundCount==""
					within(".x-grid3-body") do
					div = all(".x-grid3-row")
					div.each do |row|
						if row.all("td")[1].text==@oppName
							row.all("td")[1].all('a')[0].click					
							sleep 5
							foundCount = "found"
							break
						end
					end	
				end	
			end
			
		else
		puts "Opportunity is not present"
		end
		rescue Exception=> ex
			writeFailure"Error while Verifying the fields values"	
			writeFailure ex.message
	end
end


And(/^Enter all fields information to create the quote$/) do
	begin
	sleep 5
		arg=getDetails "Quotesdetails"
		#save_and_open_page
		puts all('.pbSubsection').count
		within all('.detailList')[0] do	
			table=all("tbody")[0]
			all('tr')[2].all('td')[1].select(arg["QuoteType"])
			all('tr')[3].all('td')[1].select(arg["QuoteTypeYear"])
		end
		within all('.pbSubsection')[1] do			
			find_field("Earliest New Start Date").set(arg["EarliestNewStartDate"])
			find_field("Latest New End Date").set(arg["LatestNewEndDate"])
			find_field("Currency").set(arg["currency"])
			fill_in	"Transaction Amount",:with=> arg["TransactionAmount"]		
		end		
		rescue Exception=> ex
			writeFailure"Error while create the quote"
			writeFailure ex.message
	end
end

		
And(/^Click on the Opportunity Name link in the Opportunity field$/) do
	begin
	sleep 5
		within all('.pbSubsection')[0] do	
			table=all("tbody")[0]
			all('tr')[0].all('td')[3].all('a')[0].click
			sleep 2
		end
		rescue Exception=> ex
			writeFailure"Error while opening existing Opportunity Name from the list"
			writeFailure ex.message
	end
end	


And(/^Enter the Quote Number from the lookup field$/) do
	begin
	sleep 5
		page.driver.browser.window_handles.first
		find("img[alt='Quote Number Lookup (New Window)']").click
		sleep 5
		page.driver.browser.switch_to.window(page.driver.browser.window_handles.last)
		sleep 10
		page.driver.browser.switch_to.frame("resultsFrame")		
			within('.pbBody') do			
				table=all("tbody")[0]
				table.all("tr")[1].all("th")[0].find('a').click					
			end
		sleep 3
		page.driver.browser.switch_to.window(page.driver.browser.window_handles.first)
		puts "Quote Number is selected"	
		rescue Exception=> ex
			writeFailure"Error while opening existing Opportunity Name from the list"
			writeFailure ex.message
	end
end

And(/^Verify the fields Earliest New Start Date,Latest New End Date,Transaction Amount values$/) do

		begin
		sleep 5
		arg=getDetails "Quotesdetails"
		sleep 5
			within all('.pbSubsection')[6] do
				table = all("tbody")[0]			
				@startdate = table.all('tr')[0].all('td')[3].text				
				puts "EarliestNewstartdate: #{@startdate}" 
				@Enddate = table.all('tr')[1].all('td')[3].text	
				puts "LatestNewEnddate: #{@Enddate}"
			end
			within all('.pbSubsection')[7] do
				table = all("tbody")[0]			
				@amount = table.all('tr')[0].all('td')[3].text[4..-1]			
				puts "Transaction Amount: #{@amount}" 
			end						
			if(@startdate.to_s == arg["EarliestNewStartDate"].to_s)
			puts "The values of Earliest New Start Date field is same the value entered in the Quote steps."
			else 
			puts "The values of Earliest New Start Date field is not same the value entered in the Quote steps."
			end
			if(@Enddate.to_s == arg["LatestNewEndDate"].to_s)
			puts "The values of Latest New End Date field is same the value entered in the Quote steps."
			else 
			puts "The values of Latest New End Date field is not same the value entered in the Quote steps."
			end
			if(@amount.to_s == arg["TransactionAmount"].to_s)
			puts "The values of Transaction Amount field is same the value entered in the Quote steps."
			else 
			puts "The values of Transaction Amount field is not same the value entered in the Quote steps."
			end
			rescue Exception=> ex
			writeFailure"Error while Verifying the fields values"
			writeFailure ex.message
	
			end
end

And(/^verify the fields Earliest New Start Date,Latest New End Date,Transaction Amount field$/) do
begin
sleep 5
	within all('.pbSubsection')[6] do
		
			if	page.has_content?('Earliest New Start Date') 
				puts "Earliest New Start Date field is present"
			else
				puts "Earliest New Start Date field is not present" 
			end	
			if	page.has_content?('Latest New End Date') 
				puts "Latest New End Date field is present"
			else
				puts "Latest New End Date field is not present" 
			end	
		
			
	end
	within all('.pbSubsection')[7] do
		
			if	page.has_content?('Transaction Amount') 
				puts "Transaction Amount field is present"
			else
				puts "Transaction Amount is not present" 
			end	
	end
	
	rescue Exception=>ex
	writeFailure "Error while verify the fields Earliest New Start Date,Latest New End Date,Transaction Amount field"
	writeFailure ex.message
	end
end

Then(/^verify the type of Earliest New Start Date,Latest New End Date,Transaction Amount field$/) do
begin
sleep 5
	within all('.pbSubsection')[6] do
		
			table = all("tbody")[0]
			if	table.all('tr')[0].all('td')[3].has_css?("input") == true
				puts "Earliest New Start Date field is text type "
			else
				writeFailure "Earliest New Start Date field is not text type"
			sleep 5
			end
			
			if	table.all('tr')[1].all('td')[3].has_css?("input") == true
				puts "Latest New End Date field is text type "
			else
				writeFailure "Latest New End Date field is not text type"
			sleep 5
			end
		
	end
	within all('.pbSubsection')[7] do
		table = all("tbody")[0]
			if	table.all('tr')[0].all('td')[3].has_css?("input") == true
				puts "Transaction Amount field is text type "
			else
				writeFailure "Transaction Amount field is not text type"
			sleep 5
			end
	end
	
	
	
	rescue Exception=>ex
	writeFailure "Error while verify the type Earliest New Start Date,Latest New End Date"
	writeFailure ex.message
	end
end

And(/^verify the Earliest New Start Date,Latest New End Date are editable or not$/) do
begin
sleep 5
	within all('.pbSubsection')[6] do
			table = all("tbody")[0]
			if	table.all('tr')[0].all('td')[3].click ==true
			puts "Earliest New Start Date field is editable"
			else
				writeFailure "Earliest New Start Date field is not editable" 
			end		
			if	table.all('tr')[1].all('td')[3].click == true
				puts "Latest New End Date field is editable "
			else
				writeFailure "Latest New End Date field is not editable"
			sleep 5
			end
					
	end
	within all('.pbSubsection')[7] do
		table = all("tbody")[0]
			if	table.all('tr')[0].all('td')[3].click == true
				puts "Transaction Amount field is editable "
			else
				writeFailure "Transaction Amount field is not editable"
			sleep 5
			end
	end
	
	
rescue Exception=>ex
writeFailure "Error while check the Discount Amount field is read only mode"
writeFailure ex.message
end
end





And(/^check the Discount Amount field is read writeable mode$/) do
begin
sleep 5
	within all('.pbSubsection')[1] do
		
			table = all("tbody")[0]
			if	table.all('tr')[3].all('td')[1].has_css?("input") == true
				puts "Discount Amount field is editable "
			else
				writeFailure "Discount Amount field is not editable"
			sleep 5
			end
	end

rescue Exception=>ex
writeFailure "Error while check the Discount Amount field is read writeable"
writeFailure ex.message
end
end

Then(/^enter the value for Discount Amount field$/) do
begin
sleep 5
	within all('.pbSubsection')[1] do
		
			if	page.has_content?('Discount Amount') 
				fill_in 'Discount Amount', :with => '100'
				sleep 5			
				puts "Discount Amount is entered"
			else
				puts "Discount Amount is not entered" 
			end		
	end

rescue Exception=>ex
writeFailure "Error while enter the value for Discount Amount field"
writeFailure ex.message
end
end


Then(/^Validate the Discount Amount field value$/) do
begin
sleep 5
	within all('.pbSubsection')[1] do
		table = all("tbody")[0]
			if	page.has_content?('Discount Amount') 
				val = table.all('tr')[3].all('td')[1].text
				puts val
				sleep 5			
				puts "Discount Amount is present in percentage"
			else
				puts "Discount Amount is not present in percentage" 
			end		
			
	end
rescue Exception=>ex
writeFailure "Error while Validate the Discount Amount field value"
writeFailure ex.message
end
end


And(/^select any quote as sales ops$/) do
	begin
	sleep 5
	within('.x-grid3-body') do
		table=all("tbody")[0]
		table.all('tr')[0].all('td')[0].all('a')[0].click
		puts "Quote is selected"
	end
	
	rescue Exception => ex
	writeFailure "Error while select any quote"
	writeFailure ex.message
	end
end

And(/^check the Discount Amount field is read only mode$/) do
begin
sleep 5
	within all('.pbSubsection')[1] do
			table = all("tbody")[0]
			if	table.all('tr')[3].all('td')[1].click ==true
			puts "Discount Amount is editable"
			else
				puts "Discount Amount is not editable" 
			end		
	end

rescue Exception=>ex
writeFailure "Error while check the Discount Amount field is read only mode"
writeFailure ex.message
end
end

And(/^I verify the Discount Amount field type$/) do
	begin
	sleep 5
		within all('.pbSubsection')[1] do
			if page.has_field?('Discount Amount', :type => 'text') == true
				puts "Discount Amount is a text field"
			else
				writeFailure"Error-Discount Amount is not a text field"
			end
		end
		rescue Exception=> ex
			writeFailure"Error while verifying the Discount Amount"
			writeFailure ex.message
	end
end 


And(/^verify the 'Renewal List Price Currency' field is editable or not$/) do
	begin
		sleep 5
		within all('.pbSubsection')[4] do
			if page.has_select?('00N61000003Y6j3')
				puts"Renewal List Price Currency field is editable"
			else
				writeFailure"Renewal List Price Currency is not a editable"
			end
		end
		rescue Exception=> ex
		writeFailure"Error while verifying the Renewal List Price Currency field is editable"
		writeFailure ex.message
	end
end	

And(/^verify the field (.*?) is mandatory$/) do |renewal_list_price_currency| 
begin
	sleep 5	
	
	if page.has_xpath?('.//label[text()="'"#{renewal_list_price_currency}"'"]/parent::td[contains(@class ,"requiredInput")]')
		 writeFailure "Renewal List Price Currency field is a required field"
	 else
		 puts "Renewal List Price Currency field is not required field"
	 end	
		
	rescue Exception=> ex
		writeFailure"Error while verifying the Renewal List Price Currency field"
		writeFailure ex.message
	end
end

And(/^verify the Renewal List Price Currency field type$/) do 
	begin
		sleep 3
		within all('.pbSubsection')[4] do
			if page.has_select?('00N61000003Y6j3')
				puts"Renewal List Price Currency is a DropDown"
			 else
				writeFailure"Renewal List Price Currency is not a DropDown"
			 end
		end
	rescue Exception=> ex
		writeFailure"Error while verifying the Renewal List Price Currency field"
		writeFailure ex.message
	end

end

And(/^verify labels (.*?) on Asset is required field$/) do |label_text|     
begin
	sleep 10	
	if page.has_xpath?('.//label[text()="'"#{label_text}"'"]/parent::td[contains(@class ,"requiredInput")]')
		puts " #{label_text} field is a Required field"
	else
		writeFailure "#{label_text} field is not required field"
	end
	rescue Exception=> ex
		writeFailure"  Error while verifying the #{label_text} "
		writeFailure ex.message
	end
end

And(/^select 'All Open Opportunities' in the View picklist$/) do       
begin
	sleep 5	
	# This code is for selecting "All Open Opportunities" option from view pick list.
	if  find_field('fcf').find('option[selected]').text == "All Open Opportunities"
		within('.filterOverview') do
			_clickButton("Go!")
			puts "'All Open Opportunities' list opens"			
		end
	else
		select "All Open Opportunities", :from => "fcf"
		puts"'All Open Opportunities' list opens"
	end	
	rescue Exception=> ex
		writeFailure" Error while opening all open opportunity"
		writeFailure ex.message
	end
end


And(/^Click the 'Create Case' button from opportunity detail page$/) do      
begin
	sleep 15
	#This code is to Click the 'Create Case' button from opportunity detail page
	within all('.pbHeader')[0] do
		if find(:button,'Create Case').visible?
			click_on('Create Case')
			puts" 'Select Case Record Type' page opens"
		end
	end
				
	rescue Exception=> ex
		writeFailure" Error while clicking 'Create Case' button "
		writeFailure ex.message
	end
end

And(/^Click the 'Continue' button$/) do     
begin
	sleep 5
	#This code is to click 'Continue' button present over 'create case' page
	within('.pbButtonb') do
		if find(:button,'Continue').visible?
			click_on('Continue')
			puts"   The 'New Case' page opens"
		else 
			writeFailure" The 'New Case' page fails to open"
		end	
		
	end					
	rescue Exception=> ex
		writeFailure"Error while clicking 'Continue' button present over 'create case' page"
		writeFailure ex.message
	end
end

Then(/^Filled data in the required field for Data Update Request case$/) do        
begin
	sleep 5
	#This code is to fill data in 'Description' field
		arg=getDetails("DataUpdateRequestMF")
		if page.has_xpath?('.//label[text()="Description"]/parent::td[contains(@class ,"requiredInput")]')
			find_field('Description').set(arg["Description"])
			puts "Data entered into Description field"
		else 
			writeFailure " Fail to find field 'Description' over the page as a Required field"
		end
	
	rescue Exception=> ex
		writeFailure"  Error while entering data in description field present over 'New Case' page "
		writeFailure ex.message
	end
end


Then(/^Validate the Name in the 'Case Milestones' section as (.*?)$/) do |milestones_name|  #
begin
	sleep 10	
	#This code is to Validate the Case Name in the 'Case Milestones' section over case detail page
	within all('.pbBody')[5] do
		table =all("table")[0]
			@caseMilestoneName=table.all("tr")[1].find("th").find('a').text
			if @caseMilestoneName==milestones_name
				puts " The Name is #{@caseMilestoneName}"
			else 
				writeFailure "  The name of Case Milestones is not showing as #{@caseMilestoneName}"	
			end
	end	
	rescue Exception=> ex
		writeFailure"Error while validating case name in the 'Case Milestones' section"
		writeFailure ex.message
	end
end

And(/^In the 'Case Milestones' section click on the underlined Name (.*?)$/) do |milestones_name| #
begin
	sleep 5
	#This code is to click on the underlined Name '48 Hours' present under 'Case Milestones' section over case detail page
	within all('.pbBody')[5] do
		table =all("table")[0]		
		if table.all("tr")[1].all('a', :text => milestones_name, :visible => true)
			click_link(milestones_name)	
			puts"  'Case Milestone' Details page opens "
		else	
			writeFailure"'Fail to click link #{@milestones_name}"
		end	
	end
	rescue Exception=> ex
		writeFailure"Error while clicking on the underlined Name '48 Hours' present under 'Case Milestones' section"
		writeFailure ex.message
	end
end

Then(/^Validate the 'Milestone' field value as (.*?)$/) do |caseMilestone_Value|  # 
begin
sleep 10	
#This code is to Validate the Case Name in the 'Case Milestones' section over 'Case Milestone Detail' page
	within('.pbSubsection') do
	table = all("tbody")[0]
		if table.all("tr")[1].has_text?(:visible, caseMilestone_Value)
			puts " The 'Milestone' field shows #{caseMilestone_Value} "
		else	
			writeFailure "  The value #{caseMilestone_Value} is not present over the page"	
		end
	end

	rescue Exception=> ex
		writeFailure"Error while validating case name in the 'Case Milestones' section "
		writeFailure ex.message
	end
end

And(/^Click on the 'Record Type of new record' picklist and ensure the correct values are present$/) do   
begin
	sleep 5	
	
	#This code is to compare dropdown option present in 'Record Type of New Record' field  present over 'Create case' page
	
	within('.pbBody') do
			flag=0
			arg=getDetails "CommonData"
			expectedOption=arg["ExpectedOption"]
			if page.has_xpath?('.//select[@name="p3"]/parent::div[contains(@class ,"requiredInput")]')
				optionPresentInTheApplication=find_field('p3').all('option').collect(&:text)				
				resultArray=expectedOption-optionPresentInTheApplication
			else	
				writeFailure " The 'Record Type of new record' dropdown is not present over the page"
			end
			if resultArray.count==0
				puts " 'Appropriate values are visible "
			else	
				writeFailure "  The option not visible are #{@resultArray}"
			end
				
	end	
	rescue Exception=> ex
		writeFailure"  Error while validating 'Record Type of new record' picklist options"
		writeFailure ex.message
	end
end

Then(/^Select (.*?) option from 'Record Type of new record' picklist$/) do |select_option|    
begin
	sleep 5
	#This code is to Select 'Data Update Request' option from 'Record Type of new record' picklist
	within('.data2Col') do
		if page.has_xpath?('.//select[@name="p3"]/parent::div[contains(@class ,"requiredInput")]')
			select select_option, :from => "p3"
			puts"  The #{select_option} value is selected "
		else 
			writeFailure " The field 'Record Type of new record' is not visible over the page"
		end
	end
	rescue Exception=> ex
		writeFailure"Error while selecting #{@select_option} option from 'Record Type of new record' picklist"
		writeFailure ex.message
	end
end

Then(/^Filled data in the required field for Booking Request case$/) do #
begin
	sleep 5
	#This code is to fill data in 'Description' field
	
		arg=getDetails("BookingRequestCaseMF")
		if page.has_xpath?('.//label[text()="Description"]/parent::td[contains(@class ,"requiredInput")]')
			find_field('Description').set(arg["Description"])
			puts "  The required fields are populated"
		else 
			writeFailure " Fail to find field 'Description' over the page as a Required field"
		end
		if page.has_xpath?('.//label[text()="Sub Case Type"]/parent::td[contains(@class ,"requiredInput")]')
			select arg["SubCaseTypeOption"], :from => "Sub Case Type"
			puts "  The required fields are populated"
		else 
			writeFailure " Fail to find field 'Sub Case Type' over the page as a Required field"
		end
		if page.has_xpath?('.//label[text()="Contract Amount"]/parent::*/parent::td[contains(@class ,"requiredInput")]')
			find_field('Contract Amount').set(arg["ContractAmount"])
			puts "  The required fields are populated"
		else 
			writeFailure " Fail to find field 'Contract Amount' over the page as a Required field"
		end
	
	rescue Exception=> ex
		writeFailure"  Error while entering data in description field present over 'New Case' page "
		writeFailure ex.message
	end
end

Then(/^Filled data in the required field for quote request case$/) do     
begin
	sleep 5
	#This code is to fill data in 'Description' field
		arg=getDetails("QuoeRequestCaseMF")
		if page.has_xpath?('.//label[text()="Description"]/parent::td[contains(@class ,"requiredInput")]')
			find_field('Description').set(arg["Description"])
			puts " The required fields are populated"
		else 
			writeFailure "The required field is not present"
		end
		if page.has_xpath?('.//label[text()="Sub Case Type"]/parent::td[contains(@class ,"requiredInput")]')
			select arg["SubCaseTypeOption"], :from => "Sub Case Type"
			puts "   The required fields are populated"
		else 
			writeFailure " Fail to find field 'Sub Case Type'"
		end
		if page.has_xpath?('.//label[text()="Quote Type"]/parent::td[contains(@class ,"requiredInput")]')
			select arg["QuoteTypeOption"], :from => "Quote Type"
			puts "  The required fields are populated"
		else 
			writeFailure " Fail to find field 'Sub Case Type' over the page as a required field"
		end
		
	
	rescue Exception=> ex
		writeFailure"  Error while entering data in description field present over 'New Case' page "
		writeFailure ex.message
	end
end

Then(/^verify if the Client Batch Year is a text field$/) do  
begin
	sleep 2
	if page.has_field?('Client Batch Year', :type => 'text') == true
		puts "Client Batch Year is a text field"
	else
		writeFailure"Client Batch Year is not a text field"
	end
	rescue Exception=> ex
		writeFailure"Error while verifying the Client Batch Year field"
		writeFailure ex.message
	end
end 

And(/^verify the 'PO Submission Date field' field is editable or not$/) do
	begin
		within all('.pbSubsection')[8] do
		table = all("tbody")[0]
			if	table.all('tr')[2].all('td')[1].click == true
				puts "PO Submission Date field is editable "
			else
				puts "PO Submission Date field is not editable"
			sleep 5
			end
		end
		rescue Exception=> ex
			writeFailure"Error while checking PO Submitted Amount is NOT editable"	
			writeFailure ex.message			
	end

end

And (/^verify (.*?) field is mandatory$/) do |po_submission_date| 
begin
	sleep 5
	 #if page.has_xpath?('.//label[contains(text(),"'"#{po_submission_date}"'")]/parent::td[contains(@class ,"requiredInput")]')
	 if page.has_xpath?('.//label[text()="'"#{po_submission_date}"'"]/parent::td[contains(@class ,"requiredInput")]')
		 puts "PO Submission Date is a required field"
	 else
		 puts "PO Submission Date is not required field"
	 end	
		
	rescue Exception=> ex
		writeFailure"Error while verifying the Business Line field"
		writeFailure ex.message
	end
end

And(/^verify the PO Submission Date field type$/) do
	begin
		sleep 3
		within all('.pbSubsection')[8] do
			table = all("tbody")[0]
			if table.all('tr')[2].all('td')[1].has_css?("input[type='text']")==true
				puts "PO Submission Date is Date type"
			else
				puts "PO Submission Date is  not Date type"
			end
		end
	rescue Exception=> ex
		writeFailure"Error while verifying the PO Submission Date"
		writeFailure ex.message
	end

end

Then(/^verify Record Type of new record field$/) do #
begin
	sleep 5
	if page.has_select?('p3')
		puts "Record Type of new record is a DropDown"
	else
		writeFailure"Record Type of new record is not a DropDown"
	end
	rescue Exception=> ex
			writeFailure"Error while verifying Record Type of new record field"	
				writeFailure ex.message
	end

end

Then(/^Open an Opportunity from "All open opportunity" collection$/) do     
begin
	sleep 5
	#This code is to open an Opportunity from "all open opportunity" collection
	within ('.x-grid3-body') do
			table =all("tbody")[0]
			table.all("tr")[0].all("td")[2].find('span').click
			puts "  The Opportunity opens "				
	end		
	rescue Exception=> ex
		puts" Error while Opening opportunity from  'All Open Opportunity' collection"
		puts ex.message
	end
end



When(/^enter Required fields to create an opportunity$/) do
begin
	arg=getDetails "Opportunityvalues"
	
		within all('.pbSubsection')[0] do	
			table = all("tbody")[0]	
			sleep 2	
			OpportunityName=arg["Name"]+ Random.new.rand(1111..9999).to_s
			puts OpportunityName
			#page.find_field("Account Name").set(arg["Account Name"])
			#fill_in	"Opportunity Name",:with=> arg["Name"]
			fill_in	"Opportunity Name",:with=> OpportunityName
			sleep 1
			find(:id, "00N61000003Y6hh").select(arg["BusinessLine"])
			#table.all('tr')[5].all('td')[1].select "WP", :from => "Business Line"
			sleep 2				
			page.find_field('Opportunity Currency').select(arg["OpportunityCurrency"])
			sleep 2		
			find(:id, "opp11").select(arg["stage"])
			sleep 2		
		end
			page.driver.browser.window_handles.first
			find("img[alt='Account Name Lookup (New Window)']").click
			sleep 5
			page.driver.browser.switch_to.window(page.driver.browser.window_handles.last)
			sleep 10
			page.driver.browser.switch_to.frame("resultsFrame")			
			within('.list') do
				tr = first("tbody").all("tr")
				tr.each do |row|
						if row.all("th")[0].text == "testing_acc"
							row.all("th")[0].all('a')[0].click
							break
						end         
				end
			end
			sleep 3
			page.driver.browser.switch_to.window(page.driver.browser.window_handles.first)
			sleep 2
			puts "clicked on lookup"			
		within all('.pbSubsection')[1] do
			sleep 2
			page.find_field("SSI Theatre").select(arg["SSITheatre"])
			sleep 2	
			page.find_field("Client Territory").select(arg["ClientTerritory"])
			sleep 2		
			page.find_field("Client Region").select(arg["ClientRegion"])
			sleep 2		
			page.find_field("Country").select(arg["country"])
			sleep 2			
		end
		within all('.pbSubsection')[9] do
			page.find_field("Close Date").set(arg["CloseDate"])		
			sleep 2		
		end				
		rescue Exception=> ex
			writeFailure"Error when Required fields are populated"	
			writeFailure ex.message
	end
end

And(/^Click the 'Save' button$/) do   # using
begin
	sleep 5
	#This code is to click 'save' button present over 'new case' page
	within('.pbBottomButtons') do		
		if find(:button,'Save').visible?
			click_on('Save')
		end
	end
	sleep 10
	
	if page.has_content? ("Error: Invalid Data.")
		writeFailure"  The save action failed"
	else
		puts "  The Case is saved and the user is returned to the Case Detail page "
	end
	rescue Exception=> ex
		writeFailure" Error while clicking 'save' button present over 'new case' page"
		writeFailure ex.message
	end
end


Then(/^I open existing OpportunityAsset$/) do
begin
    sleep 5
		page.select 'All Opportunity Assets', :from => 'View:'
            if page.has_xpath?('//label[text()="View:"]/following-sibling::span[1]/input[@title="Go!"]')
                page.find(:xpath, '//label[text()="View:"]/following-sibling::span[1]/input[@title="Go!"]').click
            end
            within('.x-grid3-scroller') do
                table =all("table")[0]      
                    if (ENV['UserRole']=="WW Exec")
                        table.all("tr")[0].all("td")[0].find('a').click
                        puts "Existing Opportunity Asset window opens"
                    else 
                        table.all("tr")[0].all("td")[2].find('a').click
                    puts "Existing Opportunity Asset window opens"
                    end
            end
            sleep 5
            if page.has_xpath?('//td[@id="topButtonRow"]/input[@title="Edit"]')
                page.find(:xpath, '//td[@id="topButtonRow"]/input[@title="Edit"]').click
            else
                writeFailure "The Fields are not editable"
            end
    rescue Exception=> ex
        writeFailure"Error while clicking existing Opportunity asset"
        writeFailure ex.message
    end
end

Then(/^click on new Opportunity to verify quote no$/) do
begin
		sleep 5
		within('.pbHeader') do
		sleep 5
		#if page.has_submit?("New")
		click_on "New"
		puts "New Opportunity window opened"
		#else
		end
		#if (ENV['UserRole']=="Sys Admin")
		if page.has_button?('Continue')
		#if find(:button,'Continue').visible?
		click_on('Continue')
		end

		#end
		   

	rescue Exception=> ex
	writeFailure"Error while navigating to New Opportunities"
	writeFailure ex.message
	end
end


Then(/^verify the field Quote Number field is present$/) do
begin
	sleep 5
	within all('.pbSubsection')[7] do	
	if page.has_content? "Quote Number"
	puts "Quote Number field is present" 
	else 
	writeFailure  "Quote Number field is not present"
	end
	end
	rescue Exception=> ex
	writeFailure"Error while verifying the Quote Number"	
	writeFailure ex.message
	end

end

Then(/^verify Quote Number is Editable field$/) do
begin
	sleep 5
	within all('.pbSubsection')[7] do	
	table = all("tbody")[0]
	if	table.all('tr')[0].all('td')[1].has_css?("input") == true
	puts "Quote Number field is editable "
	else
	writeFailure "Quote Number field is not editable"
	sleep 5
	end
	end

	rescue Exception=>ex
	writeFailure "Error while check the Quote Number field is read writeable"
	writeFailure ex.message
	end
end

And(/^verify whether (.*?) is non mandatory field$/) do |quote_num|
begin
	sleep 5
		
	if page.has_xpath?('.//label[contains(text(),"'"#{quote_num}"'")]/parent::span/parent::td[contains(@class ,"requiredInput")]')
	writeFailure "Quote Number field is a required field"
	else
	puts "Quote Number field is not required field"
	end
	sleep 5	
	rescue Exception => ex
	writeFailure "Error while verifying the field Quote Number"
	writeFailure ex.message
	end
end

Then(/^I verify the type of Quote Number$/) do
begin
	sleep 5
	within all('.pbSubsection')[7] do
	if page.has_field?('Quote Number', :type => 'text') == true
	puts "Quote Number is a text field"
	else
	writeFailure"Quote Number is not a text field"
	end
	end
	rescue Exception=> ex
	writeFailure"Error while verifying the Quote Number"
	writeFailure ex.message
	end
end


