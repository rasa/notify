# Set path in volatile directory (delete on reboot)
$vhdfile = "$env:TEMP\ramdisk_32mb.vhdx"

# Create dynamic virtual disk up to 32MB
New-VHD -Path $vhdfile -Dynamic -SizeBytes 32MB

# Mount it
Mount-VHD -Path $vhdfile

# Get the disk object (CimInstance)
$disk = Get-Disk | Where-Object PartitionStyle -Eq 'RAW'

# Initialize, partition, and format
Initialize-Disk -InputObject $disk -PartitionStyle GPT -PassThru |
  New-Partition -UseMaximumSize -DriveLetter 'R' |
  Format-Volume -FileSystem NTFS -NewFileSystemLabel "RAMDISK.32M" -Confirm:$false
  
