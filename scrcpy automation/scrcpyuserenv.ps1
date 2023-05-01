# Section 1 Get the current user's environment variables
$userenv = [System.Environment]::GetEnvironmentVariable("Path", "User")

# Define the path to the scrcpy-win64-v2.0 folder
$pathToAdd = "$env:USERPROFILE\scrcpy-win64-v2.0"

# Check if the path is already in the user's path variables
if ($userenv -notlike "*$pathToAdd*") {
    # If it's not in the path variables, add it to the end of the list
    [System.Environment]::SetEnvironmentVariable("Path", "$userenv;$pathToAdd", "User")
}

# Display a message confirming that the path was added
Write-Host "The path '$pathToAdd' has been added to your user path variables."

# Section 2 Define the target for the shortcut
$targetPath = "$env:windir\System32\WindowsPowerShell\v1.0\powershell.exe"
$arguments = '-ExecutionPolicy Bypass -File "%USERPROFILE%\scrcpy-win64-v2.0\scrcpywifilaunch.ps1"'

# Define the path for the shortcut
$shortcutPath = "$env:USERPROFILE\scrcpy-win64-v2.0\ScrcpyWifiLaunch.lnk"

# Create a WScript Shell object
$shell = New-Object -ComObject WScript.Shell

# Create the shortcut
$shortcut = $shell.CreateShortcut($shortcutPath)

# Set the target and arguments for the shortcut
$shortcut.TargetPath = $targetPath
$shortcut.Arguments = $arguments

# Save the shortcut
$shortcut.Save()

# Display a message confirming that the shortcut was created
Write-Host "The shortcut '$shortcutPath' has been created."

# Section 3 Open the user folder in Windows Explorer
Start-Process explorer.exe -ArgumentList $env:USERPROFILE
