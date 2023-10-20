# Powershell Commands

```ps1 linenums="1"
Get-Location  # Gets information about the current working location or a location stack
Set-Location -Path <path>  # change current working directory to specified path (DEFAULTs to ~)
Get-ChildItem  -Path <path>  # Gets the items and child items in one or more specified locations.
Get-Content -Path <file>  # Gets the content of the item at the specified location

Write-Output # Send specified objects to the next command in the pipeline. If the command is the last in the pipeline, the objects are displayed in the console
Write-Host  # Writes customized output to a host.
Clear-Host  # clear shell output

New-Item -ItemType File -Path filename.ext  # create empty file
New-Item -Path folder_name -Type Folder  # create a folder
New-Item -ItemType SymbolicLink -Path .\link -Target .\Notice.txt  # create a symlink

Move-Item -Path <source> -Destination <target>  # move and/or rename files and folders
Copy-Item -Path <source> -Destination <target>  # copy (and rename) files and folders

Test-Path "path" -PathType Container  # check if the existing path exists and is a folder
Test-Path "path" -PathType Leaf  # check if the existing path exists and is a file

# start, list , kill processes
Start-Process -FilePath <file>  # open a file with the default process/program
Get-Process  # Gets the processes that are running on the local computer
Stop-Process [-Id] <System.Int32[]> [-Force] [-Confirm]  # Stops one or more running processes

# network
Get-NetIPConfiguration  # Gets IP network configuration
Test-NetConnection <ip> # Sends ICMP echo request packets, or pings, to one or more computers

# compressing into archive
Compress-Archive -LiteralPath <PathToFiles> -DestinationPath <PathToDestination>  # destination can be a folder or a .zip file
Compress-Archive -Path <PathToFiles> -Update -DestinationPath <PathToDestination>  # update existing archive

# extraction from archive
Expand-Archive -LiteralPath <PathToZipFile> -DestinationPath <PathToDestination>
Expand-Archive -LiteralPath <PathToZipFile>  # extract archive in folder named after the archive in the root location

# filtering stdout/stder
Select-String -Path <source> -Pattern <pattern>  # Finds text in strings and files
```
