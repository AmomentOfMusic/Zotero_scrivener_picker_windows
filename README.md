# Zotero/Scrivener picker

This allows you to call up a zotero picker from within Scrivener in Windows 10 using a windowspowershell script by leveraging the framework provided by the Better BibTeX zotero plugin.

... or in other words, it allows you to input a citation without leaving scrivener or touching a mouse! This will input scannable cite citation codes, using [the type of picker you see in word and libreoffice](http://mossiso.com/wp-content/uploads/2012/04/zotero-new-view-find-citation.png), which can later be scanned by Zotero to create live citations. It takes a bit set-up but is well worth the effort when you are done!

## Prerequisites
This script has only been tested on Windows 10(x64), using zotero 5 and Scrivener 1 for windows. Will test with Scrivener 3 when released later in 2018. It runs off of powershell, which comes with all modern Windows machines.

This script also requires that you install autolt (see link below). This is to get around a Zotero bug in which the picker does not always appear on top when first called - unfortunately none of the in-built powershell commands did the trick. I will probably remove these elements in the future if this Zotero bug is fixed.

## Instructions
1. Install the [RTF/ODT plugin for zotero](https://zotero-odf-scan.github.io/zotero-odf-scan/).

2. Install the [Better BibTeX plugin](https://retorque.re/zotero-better-bibtex/installation/)

3. Install [Autolt](https://www.autoitscript.com/site/autoit/downloads/). As this script only requires the Cmdlet functions this installs, you might prefer to do a manual install, by [grabing the necessary files](https://www.autoitconsulting.com/site/scripting/autoit-cmdlets-for-windows-powershell/) and placing them in the the directory C:\Program Files (x86)\WindowsPowerShell\Modules\AutoItX, so that you don't install the extras that come with the installer. For the easiest route, however, just grab the full installer from the first link.

3. Download the **zotpick.7z file** from this website.

4. Unzip the folder

5. Place this folder somewhere out of the way (a.k.a somewhere you won't accidentally delete it someday). I suggest leaving it in the Scrivener folder located at C:\Program Files (x86)\Scrivener but it doesn't actually matter, as long as you can find it later

6. In scrivener, open the **Options** window (F12). Under the **general** tab, click on *choose* under the *bibliography/citation Manager* section.

7. Navigate to wherever you previously placed the folder. This will appear empty at first. Click on the dropdown menu to change file type, to display **.lnk** files. 

8. Select the file named **zotpick-scannablecite - Shortcut.lnk** and press okay. Exit the Options window.

9. Cite away! You should now be able to call the picker by using the keyboard shortcut for bibliogrphy/citation set by Scrivener. If Zotero is not already open, this script will launch the application in a minimized window. The picker will launch once the betterbibtex plugin is fully loaded, which might take a couple of seconds. You can check what the keyboard shortcut preset is by clicking the **Format** menu and seeing what is listed next to **bibliography/citations.** Search for the source you need by typing in author name or title, as you would using word or libreoffice plugin. You can also add a colon and a number to include the page number. Press enter when you are done. Voilà! 

> *Note: The preset shortcut in Scrivener didn't work for me, I think because there were two key combinations set for some reason... I fixed this problem by changing the keyboard shortcut under **tools/options/keyboard**. Search for "citations" and edit the keyboard shortcut as you please. I recommend CTR+G*

10. When ready, compile scrivener into an odt file. Scan using Zotero as detailed on [this wepage](https://catherinepope.com/how-to-use-zotero-with-scrivener-part-2/).

## Customizing script

This script is currently set up to output the scannable cite format. In order to change format, open up the scrivener-picker.ps1 file in a text editor (will open in notepad by default). Look for this line:

`$ref = invoke-expression "curl 'http://localhost:23119/better-bibtex/cayw?format=scannable-cite'"`

You can edit the section which says "scannable-cite" to any of the formats listed [on the Better BibTeX webpage](https://retorque.re/zotero-better-bibtex/cayw/
)

I have had some issues with formatted-citation (which outputs whatever style you have set as quick-cite in Zotero) not outputting italics (such as in book titles). I suspect this has to do with the encoding that Better BibTeX outputs, but I'm not 100% sure. Other styles that do not require rich text encoding should be fine. If you are able to solve the issue with italics, please let me know!

## Issues

If you having issues with this script, please let me know in the issues tab on this page. I only have basic level programming skills, so I can't promise an instant fix, but I might be able to address some concerns, or at the very least point you in the right direction.

## Contributions

Please feel free to contribute to this project if you feel that you can help.

## Acknowledgment
Inspired by  [Dave Smith Zotpick applescript](https://github.com/davepwsmith/zotpick-applescript) using a modified version of the work by [Glfruit](https://gist.github.com/glfruit)
