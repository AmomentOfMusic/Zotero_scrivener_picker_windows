[CmdletBinding()]
Param(
)

Add-Type @"
  using System;
  using System.Runtime.InteropServices;
  public class Zotero {
    [DllImport("user32.dll")]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static extern bool SetForegroundWindow(IntPtr hWnd);
}
"@

add-type -AssemblyName microsoft.VisualBasic
import-module .\AutoItX.psd1

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
            $probe = Invoke-expression "invoke-webrequest 'http://localhost:23119/better-bibtex/cayw?probe=true' -usebasicparsing -userAgent 'USER'"
            echo $probe.Content
        }

        catch 
        { 
            echo "waiting" 
        }
    }
 }
 
# Activate Zotero to ensure picker comes to the front
[Microsoft.VisualBasic.Interaction]::AppActivate((Get-Process Zotero).ID)

# Call CAYW picker
$ref = invoke-expression "curl 'http://localhost:23119/better-bibtex/cayw?format=scannable-cite' -usebasicparsing -userAgent 'USER'"

# Set Scrivener as foreground window
[Microsoft.VisualBasic.Interaction]::AppActivate((Get-Process Scrivener).ID)
$ScrivenerHandle = (Get-Process Scrivener).MainWindowHandle

[Zotero]::SetForegroundWindow($ScrivenerHandle)
Show-AU3WinActivate($ScrivenerHandle)
Wait-AU3WinActive($ScrivenerHandle)

# Send result to Scrivener window
Send-AU3Key -key $ref -mode 2
