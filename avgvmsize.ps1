## Average VM Calculator for PoweredOn VMs
## by Torben Jaster
## me@torben.hamburg
## torben.hamburg

$vCenter = "myvCenterURL.torben.hamburg"

Connect-VIServer $vCenter 

$OverallMemory = 0
$OverallCPUs = 0
$OverallHD = 0
$VMCounter = 0

## Get all VMs

$AllVMs = Get-VM


	ForEach ($VM in $AllVMs)
		{
		if ($VM.PowerState -eq "PoweredOn")
			{
			$VMCounter++
			$OverallMemory = $OverallMemory + $VM.MemoryGB
			$OverallCPUs = $OverallCPUs + $VM.NumCpu
			$HDs = Get-HardDisk -VM $VM
				ForEach ($HD in $HDs)
					{
					$OverallHD = $OverallHD + $HD.CapacityGB
					}
			}
		else {}
		}


## 3DArt

Write-Host "  +------+"
Write-Host " /|     /|"
Write-Host "+-+----+ |"
Write-Host "| |    | | AVG VM Size"
Write-Host "| +----+-+"
Write-Host "|/     |/"
Write-Host "+------+"
Write-Host ""
		
## Average Calculations
		
$AvgMemory = [math]::Round(($OverallMemory/$VMCounter),0)
$AvgCPUs = [math]::Round(($OverallCPUs/$VMCounter),0)
$AvgStorage = [math]::Round(($OverallHD/$VMCounter),0)

Write-Host "Number VMs: "$VMCounter
Write-Host "Memory: "$AvgMemory" GB"
Write-Host "CPU: "$AvgCPUs
Write-Host "Storage: "$AvgStorage" GB"
		
Disconnect-VIServer -Confirm:$false
