require 'rubygems'
require 'rspec/expectations'
require 'Capybara'


def getCredentialInfo
    yamlinput = "./features/support/test_data/Login.yml"
    myoptions = YAML.load_file(yamlinput)
    myoptions['Credentials']
end

def getOpportunityAssetInfo
    yamlinput = "./feature/support/test_data/OpportunityAsset.yml"
    myoptions = YAML.load_file(yamlinput)
    myoptions['OpportunityAssetvalues1']
	myoptions['OpportunityAssetvalues2']
	myoptions['Opportunityvalues']
	
end

def getDetails(yamlInfo)
	yamlinput = "./feature/support/test_data/OpportunityAsset.yml"
	myoptions = YAML.load_file(yamlinput)
	myoptions[yamlInfo]
end

def writeFailure(data)
puts "<span style='color:red'>#{data}</span>"
end
