# This script permits to enable and disable machines in a active directory domain
###
## V. 1.0
## Melky Dueñas - 17/03/2016

# Import AD module that allows to handle AD classes
Import-Module ActiveDirectory

## Get domain machines of a OU, ordened by Name
# Change the -SearchBase argument according to your need
$computers = Get-ADComputer -Filter * -SearchBase "OU=sell, OU=money, OU=computers, DC=xpto, DC=com" | Sort Name

## Function to disable machines of a OU
function disable_all{
	$name = $i.Name
	foreach($i in $computers){
		Set-ADComputer $i -Enabled $False
		echo "Computer $name disabled"
	}
}

## Function to enable machines of a OU
function enable_all{
	foreach($i in $computers){
		$name = $i.Name
		Set-ADComputer $i -Enabled $True
		echo "Computer $name enabled"
	}
}

## Function to disable specific machine of a OU
function machine-disable{
	$compname = Read-Host "Type the computer name to disable"
	foreach($i in $computers){
		$name = $i.Name
		if($i.Name -eq $compname){
			Set-ADComputer $i -Enabled $False
			echo "$name is disabled"
		}
	}
}

## Function to enable specific machine of a OU
function machine-enable{
	$compname = Read-Host "Type computer name to enable"
	foreach($i in $computers){
		$name = $i.Name
		if($i.Name -eq $compname){
			Set-ADComputer $i -Enabled $True
			echo "$name is enable"
		}
	}
}

## Show computer status
function status{
	Write-Output $computers | FT Name, Enabled -Autosize
}

## Option screen
echo '1 - Enable all'
echo '2 - Disable all'
echo '3 - Enable specific computer'
echo '4 - Disable specific computer'
echo '5 - Show computer´s status'
echo ''

$op = Read-Host "Choose a option"
switch($op){
	'1' { enable_all }
	'2' { disable-all }
	'3' { enable_machine }
	'4' { disable_machine }
	'5' { status }
	Default { "Select options between 1-5 !!"}
}