[CmdletBinding()]
Param(
)


add-type -AssemblyName microsoft.VisualBasic
import-module $PsScriptRoot\AutoItX.psd1

#Get handle of active window (Scrivener)
$Activewindow = Get-AU3WinHandle -Title ''

# Check if Zotero is running. If not, launch the program and wait until BBT plugin is ready  
if ((get-process "zotero" -ErrorAction SilentlyContinue) -eq $Null) 
{    
    Start-Process -filepath zotero.exe -WindowStyle Minimized

    $probe = "starting"
  
    while ($probe -notmatch "ready") 
    {
        start-sleep -Seconds 1

        try 
        {
            $probe = invoke-webrequest 'http://localhost:23119/better-bibtex/cayw?probe=true' -usebasicparsing -userAgent 'USER'
            echo $probe.Content
        }

        catch 
        { 
            echo "waiting" 
        }
    }
 }

else 
{ 
    echo "Zotero is running" 
}
 

# Activate Zotero to ensure picker comes to the front
[Microsoft.VisualBasic.Interaction]::AppActivate((Get-Process Zotero).ID)


# Call CAYW picker
$ref = invoke-webrequest 'http://localhost:23119/better-bibtex/cayw?format=scannable-cite' -usebasicparsing -userAgent 'USER'


# Set Scrivener as foreground window
Show-AU3WinActivate($Activewindow)
Wait-AU3WinActive($Activewindow)

echo $ref

# Send result to Scrivener window
Send-AU3Key -key $ref -mode 2
