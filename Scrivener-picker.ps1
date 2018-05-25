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
  
  [Microsoft.VisualBasic.Interaction]::AppActivate((Get-Process zotero).ID)
  [Microsoft.VisualBasic.Interaction]::AppActivate((Get-Process Scrivener).ID)

  $ref = invoke-expression "curl 'http://localhost:23119/better-bibtex/cayw?format=scannable-cite'-usebasicparsing"
  
  $ScrivenerHandle = (Get-Process Scrivener).MainWindowHandle

  $SendKeysSpecialChars = '@','{','}','[',']','~','+','^','%','.','(',')','?','.',':'
  $ToEscape = ($SendKeysSpecialChars|%{[regex]::Escape($_)}) -join '|'
  $citation = $ref.Content -replace "($ToEscape)",'{$1}'
  echo "$citation"

  [Zotero]::SetForegroundWindow($ScrivenerHandle)
  Show-AU3WinActivate($ScrivenerHandle)
  Wait-AU3WinActive($ScrivenerHandle)

  [System.Windows.Forms.SendKeys]::SendWait($citation)
  
  
} catch {
 Write-Error "Failed to get active Window details. More Info: $_"
}
