Write-Host "KMNDIT - Knowledge Management Native Directory Info Tool"
$Date = Get-Date
$TargetDir = Read-Host -Prompt 'What is the full path of the directory do you want to gather information from? This could be copied from the explorer window.'
$OutputDir = Read-Host -Prompt 'What is the full path of the directory do you want to sent the info to? This could be copied from the explorer window.'
$DateOutputDir = $OutputDir + $Date + ".csv"
Get-ChildItem -Path $TargetDir -Recurse |`
foreach{
$Item = $_
$Type = $_.Extension
$Path = $_.FullName
$Folder = $_.PSIsContainer
$Age = $_.CreationTime
$Path | Select-Object `
   @{n="Name";e={$Item}},`
   @{n="Created";e={$Age}},`
   @{n="filePath";e={$Path}},`
   @{n="Extension";e={if($Folder){"Folder"}else{$Type}}}`
}| Export-Csv $OutputDir -NoTypeInformation