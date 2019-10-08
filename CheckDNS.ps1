Write-Host "*************************************" -ForegroundColor Yellow
Write-Host "*    	     CheckDNS 			    *" -ForegroundColor Yellow
Write-Host "*************************************" -ForegroundColor Yellow
Write-Host "*         @AlejandroMora            *" -ForegroundColor Yellow
Write-Host "*************************************" -ForegroundColor Yellow


Write-Host "-------------------" -ForegroundColor Green
Write-Host "Check list...      " -ForegroundColor Green
Write-Host "-------------------" -ForegroundColor Green

$count=0
$date=(get-date)
echo "-----------------DNS Report-------------------" >> C:\Users\A743903\Desktop\PWSH\informe.txt
echo $date >> C:\Users\A743903\Desktop\PWSH\informe.txt
echo "----------------------------------------------" >> C:\Users\A743903\Desktop\PWSH\informe.txt

#DNS and Ping report
foreach($name in Get-Content C:\Users\A743903\Desktop\PWSH\lista.txt) {
    $dns=$name+".yoigo.com"
	$respuesta=(Resolve-DnsName $dns)
	$ping=((Test-NetConnection $dns).PingSucceeded)
	if($respuesta -ne $null){
		$salida=$dns+" --> IP:"+$respuesta.IPAddress+" (Ping:"+$ping+")"
		echo "$salida" >> C:\Users\A743903\Desktop\PWSH\informe.txt
		}
	else{
		$salidaf=$dns+" no encontrado (Ping:"+$ping+")"
		echo "$salidaf" >> C:\Users\A743903\Desktop\PWSH\informe.txt
		$count++
	}
}
if($count -gt 0){ 
	$badnames=$count.ToString()+" DNS names not found"
	echo "----------------------------------------------" >> C:\Users\A743903\Desktop\PWSH\informe.txt
	echo "$badnames" >> C:\Users\A743903\Desktop\PWSH\informe.txt
}
Write-Host "-------------------" -ForegroundColor Red
Write-Host "Names not found: " $counter -ForegroundColor Red
Write-Host "-------------------" -ForegroundColor Red


