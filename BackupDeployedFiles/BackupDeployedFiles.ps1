Write-Host "**SCRIPT FOR BACKUP THE DEPLOYED FILES**"

# input

$deployPath = Read-Host "Path of deployed files"

$backupPath= Read-Host "Path to backup"

Write-Host "----------------------------------------"

Write-Host "The path of the deployed files is: $deployPath"

Write-Host "The path of the backup is: $backupPath"

Write-Host "----------------------------------------"

$confirmation= Read-Host "Are you sure you want to proceed (y/n)"

#var

$counter= 0

if($confirmation -eq "y") {
    # Proceed
    if ((Test-Path $deployPath)) {

		Get-ChildItem -Path $backupPath -Recurse -Force -File | foreach-object {

            $object= (Get-ChildItem -Path $backupPath -Force -Recurse -File -Name | Select-Object -index $counter)

            Copy-Item $deployPath\$object -Destination $backupPath -recurse -Force

            $counter=($counter+1) }

		Write-Host "----------------------------------------"

		Write-Host "$counter copied files"

		Write-Host "----------------------------------------"

    }
}
else {
Write-Host = "Process canceled"
}
