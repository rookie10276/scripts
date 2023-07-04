# Here we define a variable called 'dirPath'. This is like a label that points to a specific location on your computer.
$dirPath = "C:\directory\folder\example"

# We're defining lists (arrays) of video and image file extensions we'll be looking for. Each file type has a unique extension that comes after the '.' in its name.
$videoExtensions = @('*.mp4', '*.avi', '*.mov', '*.mkv', '*.m4v')
$imageExtensions = @('*.jpg', '*.jpeg', '*.png', '*.gif')

# We're setting up two counters to number our video and image files when we rename them.
$videoCounter = 1
$imageCounter = 1

# This is a print statement. It's used to display a message to the user, letting them know we're starting the video renaming process.
Write-Host "Starting video files renaming process..."

# Now we're going to loop over each video file extension in our list.
foreach ($extension in $videoExtensions) {
    # This print statement lets the user know which extension we're currently processing.
    Write-Host "Processing files with extension $extension"
    # Here we are getting the files with the current extension, sorting them by the time they were last modified, and looping over each file one by one.
    Get-ChildItem -Path $dirPath -Filter $extension -File | Sort-Object LastWriteTime | ForEach-Object {
        # We're creating a new name for each file. The new name includes the date, the counter number, and the old file name.
        $newName = "[2023-05-13 ] " + $videoCounter + " " + $_.Name
        # This print statement shows what the old name was and what it's being renamed to.
        Write-Host "Renaming $($_.Name) to $newName"
        # Now we're actually renaming the file with the new name we've just created.
        Rename-Item -Path $_.FullName -NewName $newName
        # This is where we increase the video counter for each file we process, so that each file gets a unique number.
        $videoCounter++
    }
}

# We're doing exactly the same for image files as we did for video files, but using a different counter and prefix in the new file names.
Write-Host "Starting image files renaming process..."

foreach ($extension in $imageExtensions) {
    Write-Host "Processing files with extension $extension"
    Get-ChildItem -Path $dirPath -Filter $extension -File | Sort-Object LastWriteTime | ForEach-Object {
        $newName = "[2023-05-13] p" + $imageCounter + " " + $_.Name
        Write-Host "Renaming $($_.Name) to $newName"
        Rename-Item -Path $_.FullName -NewName $newName
        $imageCounter++
    }
}
