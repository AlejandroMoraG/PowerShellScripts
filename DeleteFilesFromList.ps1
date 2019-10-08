Write-Host "*************************************" -ForegroundColor Yellow
Write-Host "*    DeleteFilesFromList Script     *" -ForegroundColor Green
Write-Host "*************************************" -ForegroundColor Yellow
Write-Host "*         @AlejandroMora            *" -ForegroundColor Green
Write-Host "*************************************" -ForegroundColor Yellow


$path=(Read-Host "Please, indicate the path to compare")
$pathtolist=(Read-Host "Please, indicate the path of the list(full path)") 
$pathbackup=(Read-Host "Please, indicate the path for create a backup directory")

#Create a directory for move the deleted files
New-Item -Path $pathbackup -Name "deleted-files" -ItemType "directory"
$counter=0
Write-Host "-------------------" -ForegroundColor Green
Write-Host "Check list...      " -ForegroundColor Green
Write-Host "-------------------" -ForegroundColor Green

foreach($file in Get-Content $pathtolist) {
    $report=(test-path -path $path\$file)
        if($report -eq $True){
            Move-Item -Path $path\$file -Destination  $pathbackup\deleted-files\$file
            Write-Host $file "delete" -ForegroundColor Green
            #echo $file " delete" >> $pathbackup\logDeletedFiles.txt
            $counter++
         }    
        else{
            Write-Host $file " not found in $path" -ForegroundColor Red
            #echo $file " not found in $path" >> $pathbackup\logDeletedFiles.txt

        }
} 
Write-Host "-------------------" -ForegroundColor Green
Write-Host "Files deleted: " $counter -ForegroundColor Yellow
Write-Host "-------------------" -ForegroundColor Green
Write-Host "Please, check that files in the backup directory:" $pathbackup\deleted-files -ForegroundColor Yellow

