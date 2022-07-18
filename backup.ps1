. .\shared.ps1

$CommitMessage = $args[0]
$BackupDestination = $args[1]

$DumpFileName = "router.tar.gz"

$process = Start-Process -PassThru -NoNewWindow -RedirectStandardOutput $DumpFileName -Wait -FilePath ssh -ArgumentList @('root@router.foxden.network', 'sysupgrade -b -')
if ($process.ExitCode -ne 0) {
    throw ("Error obtaining router backup")
}

Remove-Item -Path ".\data" -Recurse -Force
New-Item -Path ".\data" -ItemType Directory

Exec { tar -xzf $DumpFileName -C ".\data" }

function Do-Redact-Option($OptionKey, $RelativeFile) {
    $File = "./data$RelativeFile"
    ((Get-Content -Path "$File" -Raw) -Replace "$OptionKey.*","$OptionKey 'REMOVED'") | Set-Content -Path "$FILE" -NoNewline
}

Do-Redact-Option 'option private_key' /etc/config/network
Do-Redact-Option 'option password' /etc/config/ddns

git add -A
git commit -a -m "$CommitMessage"

$BackupFile = "$BackupDestination/$DumpFileName"
Remove-Item -Path "$BackupFile" -Force
Copy-Item -Path $DumpFileName -Destination "$BackupFile"
