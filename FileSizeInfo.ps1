Write-Host "*************************************" -ForegroundColor Yellow
Write-Host "*       FileSizeInfo Script         *" -ForegroundColor Yellow
Write-Host "*************************************" -ForegroundColor Yellow
Write-Host "*         @AlejandroMora            *" -ForegroundColor Yellow
Write-Host "*************************************" -ForegroundColor Yellow

$path=(Read-Host "Please, indicate the path from which to analyze file size")
$reportpath= (Test-Path -path $path)
$date=(get-date)
if($reportpath -eq $true){
    #function for convert the size value for the files
    Function Format-FileSize() {
        Param ([int]$size)
            If ($size -gt 1TB) {[string]::Format("{0:0.00} TB", $size / 1TB)}
            ElseIf ($size -gt 1GB) {[string]::Format("{0:0.00} GB", $size / 1GB)}
            ElseIf ($size -gt 1MB) {[string]::Format("{0:0.00} MB", $size / 1MB)}
            ElseIf ($size -gt 1KB) {[string]::Format("{0:0.00} kB", $size / 1KB)}
            ElseIf ($size -gt 0) {[string]::Format("{0:0.00} B", $size)}
            Else {"0 KB"}
    }
    #define a path for the report file and check if exist
    $outputfilepath=(Read-Host "Path for save the report in .txt format")
    if (Test-Path -Path $outputfilepath) {
        Write-Host "Scaning..." 
        $reportinfo=(Get-ChildItem -r -Path $path\*.* | sort -descending -property length | Select-Object FullName, @{Name="Size";Expression={Format-FileSize($_.Length)}})
        $numficheros=([string]($reportinfo.count))+" Files found"
        echo "-----------------File Report-------------------" >> $outputfilepath\FileSizeReport.txt
        echo $date >> $outputfilepath\FileSizeReport.txt
        echo "Parent directory: $path" >> $outputfilepath\FileSizeReport.txt
        echo $numficheros  >> $outputfilepath\FileSizeReport.txt
        echo "-----------------------------------------------" >> $outputfilepath\FileSizeReport.txt
        echo "SIZE:                                     FILE:" >> $outputfilepath\FileSizeReport.txt
        #echo $reportinfo >> $outputfilepath\FileSizeReport.txt
        $counter=0
        $reportinfo | ForEach-Object{
            $name=($reportinfo.FullName)[$counter]
            $name=($name.Replace($path,""))
            $size=($reportinfo.Size)[$counter]
            echo " $size  ->  $name" >> $outputfilepath\FileSizeReport.txt
            Clear-Variable -Name name -Force
            clear-Variable -Name size -Force
            $counter++
        }
        $report=(test-path -path $outputfilepath\FileSizeReport.txt)
        if($report -eq $true){
            Write-Host "-------------------" -ForegroundColor Green
            Write-Host "- Report complete -" -ForegroundColor Green
            Write-Host "-------------------" -ForegroundColor Green
        }
        else {
            Write-Host "Error creating report file" -ForegroundColor Red
            Write-Debug "Exit..."
            Exit
        }
    }
    else{
        Write-Host "The path not exist. Exit ..." -ForegroundColor Red
        Exit
    }
}
else{
    Write-Host "The path '$path' not exist" -ForegroundColor Red
    Write-Host "Exit....."
    Exit
}