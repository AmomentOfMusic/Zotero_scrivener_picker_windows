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
add-type -AssemblyName System.Windows.Forms

if ((get-process "zotero" -ErrorAction SilentlyContinue) -eq $Null)
   {
        Start-Process -filepath zotero.exe -windowstyle Minimized
    }

else
    { 
        echo "Process is running" 
     }
   
$probe = Invoke-Expression "curl 'http://localhost:23119/better-bibtex/cayw?probe=true' -usebasicparsing"
echo $probe
 
 while ($probe -notmatch "ready") {
        start-sleep -Seconds 2
        $probe = invoke-expression "curl 'http://localhost:23119/better-bibtex/cayw?probe=true' -usebasicparsing'"
    }
    
try {
  
  [Microsoft.VisualBasic.Interaction]::AppActivate((Get-Process zotero).ID)
  $ref = invoke-expression "curl 'http://localhost:23119/better-bibtex/cayw?format=scannable-cite'-usebasicparsing"
  
  [Microsoft.VisualBasic.Interaction]::AppActivate((Get-Process Scrivener).ID)

  $SendKeysSpecialChars = '@','{','}','[',']','~','+','^','%','.','(',')','?','.',':'
  $ToEscape = ($SendKeysSpecialChars|%{[regex]::Escape($_)}) -join '|'
  $citation = $ref.Content -replace "($ToEscape)",'{$1}'
  echo "$citation"

 $ScrivenerHandle = (Get-Process Scrivener).MainWindowHandle

  [Zotero]::SetForegroundWindow($ScrivenerHandle)
  Show-AU3WinActivate($ScrivenerHandle)
  Wait-AU3WinActive($ScrivenerHandle)

  [System.Windows.Forms.SendKeys]::SendWait($citation)
  
} catch {
 Write-Error "Failed to get active Window details. More Info: $_"
}
