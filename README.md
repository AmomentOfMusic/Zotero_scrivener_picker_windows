# Zotero/Scrivener picker

This allows you to call up a zotero picker from within Scrivener in Windows 10 using a windowspowershell script by leveraging the framework provided by the Better BibTeX zotero plugin.

... or in other words, it allows you to input a citation without leaving scrivener or touching a mouse! This will input scannable cite citation codes, using [the type of picker you see in word and libreoffice](http://mossiso.com/wp-content/uploads/2012/04/zotero-new-view-find-citation.png), which can later be scanned by Zotero to create live citations.

## Prerequisites
This script has only been tested on Windows 10(x64), using zotero 5 and Scrivener 1 for windows. Will test with Scrivener 3 when released later in 2018

## Instructions
1. Install the [RTF/ODT plugin for zotero](https://zotero-odf-scan.github.io/zotero-odf-scan/). *Note: I had a bit of an issue installing this plugin with Zotero 5. If scannable cite is not showing up in the Zotero preferences [See this forum post]https://forums.zotero.org/discussion/57428/scannable-cite-not-showing-up-in-zotero-standalone for instructions on manually instructing the scannable cite format*

2. Install the [Better BibTeX plugin](https://retorque.re/zotero-better-bibtex/installation/)
*Note: This will automatically change your quick-cite format - fear not! You can easily change it back by going into Zotero preferences*

3. Download the zotpick.7z file from this website.

4. Unzip the folder

5. Place this folder somewhere out of the way (a.k.a somewhere you won't accidentally delete it someday). I suggest leaving it in the Scrivener folder located at C:\Program Files (x86)\Scrivener but it doesn't actually matter, as long as you can find it later

6. In scrivener, open the **Options** window (F12). Under the **general** tab, click on *choose* under the *bibliography/citation Manager* section.

7. Navigate to wherever you previously placed the folder. This will appear empty at first. Click on the dropdown menu to change file type, to display **.lnk** files. 

8. Select the file named **zotpick-pandoc-win - Shortcut.lnk** and press okay. Exit the Options window.

9. Cite away! You should now be able to call the picker by using the keyboard shortcut for bibliogrphy/citation
Search for the source you need by typing in author name or title, as you would using word or libreoffice plugin, and press enter when you are done. Voilà!

*Note: The preset shortcut in Scrivener didn't work for me, I think because there were two key combinations set for somereason. I fixed this problem by changing the keyboard shortcut under tools/options/keyboard. Search for "citations" and edit the keyboard shortcut as you please. I recommend CTR+G*

10. When ready, compile scrivener into an odt file. Scan using Zotero as detailed on [this wepage](https://catherinepope.com/how-to-use-zotero-with-scrivener-part-2/).

## Customizing script

This script is currently set up to output the scannable cite format. In order to change format, open up the scrivener-picker.ps1 in a text editor (will open in notepad by default). Look for this line:

$ref = invoke-expression "curl 'http://localhost:23119/better-bibtex/cayw?format=**scannable-cite**

You can edit the section in bold to any of the format listed [on the Better BibTeX webpage](https://retorque.re/zotero-better-bibtex/cayw/
)

##Acknowledgment
Inspired by  [Dave Smith Zotpick applescript](https://github.com/davepwsmith/zotpick-applescript) using a modified version of the work by [Glfruit](https://gist.github.com/glfruit)
