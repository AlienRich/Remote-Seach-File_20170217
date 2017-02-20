#####	設定需要搜尋的檔案格式，前後務必以雙引號標註
$FindFileName="*adduser*"

#####	將所需要掃描的IP、HOSTNAME放入_@_IP-List.txt內
$SubNetList = ".\_@_IP-List.txt"

#####	發動執行，會產生_FileFilePath-All.txt(撈取到的完整路徑)、_IP-Path-Err.log(無法連入的IP)
Get-Content -Path $SubNetList | Foreach-Object { $ComputerName = $_
	if (Test-PATH "\\$ComputerName\c$") {
		$DeviceID =((Get-WmiObject -Class Win32_LogicalDisk -computername $ComputerName | Where-Object {$_.DriveType -ne 5}).DeviceID).Replace(":","$")
		$DeviceID | Foreach-Object { $DeviceIDPath = $_
			$FindFile = Get-ChildItem -path \\$ComputerName\$DeviceIDPath -recurse -include $FindFileName | ForEach-Object { $_.FullName } | out-file ".\_FileFilePath-All.txt" -append -encoding utf8
			$DeviceID = "NoMsg"
			}
			$ComputerName = "NoMsg"
			$DeviceIDPath = "NoMsg"
			$FindFile = "NoMsg"
	}
	else
	{
	write-host "$ComputerName,NoPath,無此IP、非微軟系統。或帳號：$LoginID 無權限！C無法連入！！" -ForegroundColor Yellow
	"$ComputerName,NoPath,無此IP、非微軟系統。或帳號：$LoginID 無權限！C無法連入！！" | Out-File -Append -FilePath ".\_IP-Path-Err.log"
	$ComputerName = "NoMsg"
	}
	}