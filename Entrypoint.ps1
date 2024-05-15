Write-Host "Windows Event Generator"

function LogIfNotEmpty() {
    param (
        $logFile
    )
    $fileSize = (Get-Item -Path $logFile).Length
    if ($fileSize -ne 0) {
        Write-Host "START $logFile"
        Get-Content $logFile
        Write-Host "END $logFile"
    }
}

$eventList = @(
    [PSCustomObject]@{name = "SAM Read"; cmd="esentutl.exe"; args="/y /vss %SystemRoot%/system32/config/SAM_ps /d %temp%/SAM_ps"}
    [PSCustomObject]@{name = "Clear Windows Event Log"; cmd="powershell"; args="Clear-EventLog -LogName System"}
    [PSCustomObject]@{name = "Encoded Powershell Execution"; cmd="powershell"; args="-enc bABzAA=="}
    [PSCustomObject]@{name = "Enumerate Logged-on Users"; cmd="powershell"; args="query user"}
)

$stdoutFile = "Output.txt"
$stderrFile = "Error.txt"

while ($true) {
    foreach ( $event in $eventList ) {
        Write-Host "Running" $event.name

        $processOptions = @{
            ArgumentList = $event.args
            FilePath = $event.cmd
            NoNewWindow = $true
            RedirectStandardOutput = $stdoutFile
            RedirectStandardError = $stderrFile
        }
        Start-Process @processOptions

        LogIfNotEmpty($stdoutFile)
        LogIfNotEmpty($stderrFile)

        Start-Sleep 10

        Remove-Item Output.txt
        Remove-Item Error.txt

        Write-Host "**********************************************"
    }
}
