# Get the current user's environment variables
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

# Open the user folder in Windows Explorer
Start-Process explorer.exe -ArgumentList $env:USERPROFILE
