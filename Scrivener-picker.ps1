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

try {
  $ScrivenerHandle = (Get-Process Scrivener).MainWindowHandle
  $ref = invoke-expression "curl 'http://localhost:23119/better-bibtex/cayw?format=scannable-cite' -usebasicparsing"   
  [Microsoft.VisualBasic.Interaction]::AppActivate((Get-Process Scrivener).ID)

  $SendKeysSpecialChars = '@','{','}','[',']','~','+','^','%','.','(',')','?'
  $ToEscape = ($SendKeysSpecialChars|%{[regex]::Escape($_)}) -join '|'
  $citation = $ref.Content -replace "($ToEscape)",'{$1}'
  echo "$citation"

  [System.Windows.Forms.SendKeys]::SendWait($citation)
  [Zotero]::SetForegroundWindow($ScrivenerHandle)
  

} catch {
 Write-Error "Failed to get active Window details. More Info: $_"
}
