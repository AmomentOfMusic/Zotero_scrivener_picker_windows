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
        
    {    Start-Process -filepath zotero.exe -WindowStyle Minimized

         $probe = "starting"
  
         while ($probe -notmatch "ready") 
         {  start-sleep -Seconds 1

            try { $probe = Invoke-expression "invoke-webrequest 'http://localhost:23119/better-bibtex/cayw?probe=true' -usebasicparsing -userAgent 'USER'"
                  echo $probe.Content
                }
            catch { echo "waiting" 
                  }

         }
     }

else { 
        echo "Zotero is running" 
     }
 
# Activate Zotero to ensure picker comes to the front
[Microsoft.VisualBasic.Interaction]::AppActivate((Get-Process Zotero).ID)

# Call CAYW picker
$ref = invoke-expression "curl 'http://localhost:23119/better-bibtex/cayw?format=pandoc&brackets=true' -usebasicparsing -userAgent 'USER'"

# Set Obsidian as foreground window
[Microsoft.VisualBasic.Interaction]::AppActivate((Get-Process Obsidian).ID)
$ObsidianHandle = (Get-Process Obsidian).MainWindowHandle

[Zotero]::SetForegroundWindow($ObsidianHandle)
Show-AU3WinActivate($ObsidianHandle)
Wait-AU3WinActive($ObsidianHandle)

# Send result to Obsidian window
Send-AU3Key -key $ref -mode 2