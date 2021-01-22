#Create a migwiz@domain account to use when migrating to Office 365
#Ben Stitt, TekSystems
#github.com/galacticdeep, me@benstitt.com
#currently this script is for migrating from 365 to 365 and requires the ability to connect to the MsolService

#variables

$password = " "


#Connect to service
Connect-MsolService 

$url = Read-Host -Prompt "Enter URL of company to migrate"

#For licensing plan name     EXCHANGESTANDARD or EXCHANGEENTERPRISE or O365_BUSINESS_ESSENTIALS or anything that looks like it will give a mailbox as that is required to autodiscover data in Migration Wiz

Get-MsolAccountSku #pulls available licenses
#would be awesome if there was a way to automatically pull from usable licenses and apply instead of manually filling in the license
#some sort of if-then-else

$license = Read-Host -Prompt "Enter license choice"

#Create account

New-MsolUser -DisplayName "MigWiz" -UserPrincipalName "migwiz@$url" -UsageLocation US -LicenseAssignment $license  -Password $password

#Give Exchange Admin

Add-MsolRoleMember -RoleMemberEmailAddress (Get-MsolUser -All | Where DisplayName -eq "MigWiz").UserPrincipalName -RoleName "Exchange Service Administrator"

#that's it, now you can use that admin migwiz to create a project in MigrationWiz and autodiscover the items






