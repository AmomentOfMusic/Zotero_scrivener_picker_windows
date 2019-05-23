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
     
    {    Start-Process -filepath zotero.exe -windowstyle minimized
         $probe = Invoke-Expression "curl 'http://localhost:23119/better-bibtex/cayw?probe=true' -usebasicparsing" 
         
         while ($probe -notmatch "ready") 
         {  start-sleep -Seconds 1
         
            try { $probe = Invoke-expression "curl 'http://localhost:23119/better-bibtex/cayw?probe=true' -usebasicparsing"
                  echo $probe.content
                }
            catch { write-host "waiting" 
                  }

    }

else { 
        echo "Zotero is running" 
     }

# Activate Zotero to ensure picker comes to the front
[Microsoft.VisualBasic.Interaction]::AppActivate((Get-Process Zotero).ID)

# Call CAYW picker
$ref = invoke-expression "curl 'http://localhost:23119/better-bibtex/cayw?format=scannable-cite' -usebasicparsing"

# Set Scrivener as foreground window
[Microsoft.VisualBasic.Interaction]::AppActivate((Get-Process Scrivener).ID)
$ScrivenerHandle = (Get-Process Scrivener).MainWindowHandle

[Zotero]::SetForegroundWindow($ScrivenerHandle)
Show-AU3WinActivate($ScrivenerHandle)
Wait-AU3WinActive($ScrivenerHandle)

# Send result to Scrivener window
Send-AU3Key -key $ref -mode 2
