# This script connects your device wirelessly using scrcpy and adb
# Make sure your device and PC are on the same network and can see each other
# Make sure your adb server and client versions match
# Make sure your firewall or antivirus is not blocking the connection
# Change the variables below to match your device IP address and port
$DEVICE_IP = "192.168.1.3"
$DEVICE_PORT = "5555"
# Get the current directory of the script
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
# Change the working directory to the scrcpy folder
Set-Location "$ScriptDir"
# Stop any existing adb server
.\adb.exe kill-server
# Switch to USB mode
.\adb.exe usb
# Switch to TCP/IP mode and listen on port 5555
.\adb.exe tcpip $DEVICE_PORT
# Connect to the device wirelessly
$connectionResult = .\adb.exe connect "$DEVICE_IP`:$DEVICE_PORT"
if ($connectionResult -notmatch "connected to") {
    Write-Host "Connection failed. Please enter the device IP address: "
    $DEVICE_IP = Read-Host
    .\adb.exe connect "$DEVICE_IP`:$DEVICE_PORT"
    # Modify the PowerShell script file with the correct IP address
    $scriptContent = Get-Content $MyInvocation.MyCommand.Definition
    $scriptContent -replace '(?<=\$DEVICE_IP = "192.168.1.3")', $DEVICE_IP | Set-Content $MyInvocation.MyCommand.Definition
}
# Confirm that the device is connected
.\adb.exe devices
# Start mirroring the device screen
.\scrcpy.exe
# options for scrcpy.exe for bandwidth,resolution,fps: -b 1M -m 800 --max-fps=10