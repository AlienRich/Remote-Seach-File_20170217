#####	�]�w�ݭn�j�M���ɮ׮榡�A�e��ȥ��H���޸��е�
$FindFileName="*adduser*"

#####	�N�һݭn���y��IP�BHOSTNAME��J_@_IP-List.txt��
$SubNetList = ".\_@_IP-List.txt"

#####	�o�ʰ���A�|����_FileFilePath-All.txt(�����쪺������|)�B_IP-Path-Err.log(�L�k�s�J��IP)
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
	write-host "$ComputerName,NoPath,�L��IP�B�D�L�n�t�ΡC�αb���G$LoginID �L�v���IC�L�k�s�J�I�I" -ForegroundColor Yellow
	"$ComputerName,NoPath,�L��IP�B�D�L�n�t�ΡC�αb���G$LoginID �L�v���IC�L�k�s�J�I�I" | Out-File -Append -FilePath ".\_IP-Path-Err.log"
	$ComputerName = "NoMsg"
	}
	}