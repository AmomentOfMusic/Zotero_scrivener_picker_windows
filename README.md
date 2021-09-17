# Zotero/Scrivener picker

This allows you to call up a zotero picker from within Scrivener in Windows 10 using a windowspowershell script by leveraging the framework provided by the Better BibTeX zotero plugin.

... or in other words, it allows you to input a citation without leaving scrivener or touching a mouse! This will input scannable cite citation codes, using [the type of picker you see in word and libreoffice](http://mossiso.com/wp-content/uploads/2012/04/zotero-new-view-find-citation.png), which can later be scanned by Zotero to create live citations. It takes a bit set-up but is well worth the effort when you are done!

This script is written in such a way that it should also work with other plaintext editors that give you the option to trigger a script, as it checks for the current active window when launched, but has not been tested.

## Prerequisites
This script has only been tested on Windows 10(x64), using zotero 5 and both Scrivener 1 and 3 for Windows. Instructions below are for Scrivener 3 - for Scrivener 1, the instructions are more or less the same except that the options menu is located under tools menu, not file. 

In order to scan the citations, you will also need to already have installed LibreOffice, as well as the LibreOffice Zotero plugin. 

The script runs off of powershell, which comes with all modern Windows machines. This script also requires the Autoit cmdlet functions. This is to get around a Zotero bug in which the picker does not always appear on top when first called - unfortunately none of the in-built powershell commands did the trick. For ease of use, I have included the necessary files in the zipped folder. Just leave the files in the folder, and everything should work fine. If you prefer, however, you can move the 5 autoitx files to a folder entitled "AutoItX" in the directory C:\Program Files (x86)\WindowsPowerShell\Modules\ - this is however, not necessary.

## Instructions
1. Install the [RTF/ODT plugin for zotero](https://zotero-odf-scan.github.io/zotero-odf-scan/)

2. Install the [Better BibTeX plugin](https://retorque.re/zotero-better-bibtex/installation/)

3. Download the **zotpick.7z file** from this website

4. Unzip the folder

5. Place this folder somewhere out of the way (a.k.a somewhere you won't accidentally delete it someday). I suggest leaving it in the Scrivener folder located at C:\Program Files (x86)\Scrivener but it doesn't actually matter, as long as you can find it later

6. In scrivener, navigate to **file > Option**. Under the **General** tab, click *citations* in the side bar. Click on *choose*

7. Navigate to wherever you previously placed the folder. This will appear empty at first. Click on the dropdown menu to change file type, to display **.lnk** files. 

8. Select the file named **zotpick-scannablecite - Shortcut.lnk** and press okay. Exit the Options window. 

9. Cite away! You should now be able to call the picker by using the keyboard shortcut for bibliogrphy/citation set by Scrivener. If Zotero is not already open, this script will launch the application in a minimized window. The picker will launch once the betterbibtex plugin is fully loaded, which might take a couple of seconds. You can check what the keyboard shortcut preset is by clicking the **Format** menu and seeing what is listed next to **bibliography/citations.** Search for the source you need by typing in author name or title, as you would using word or libreoffice plugin. You can also add a colon and a number to include the page number. Press enter when you are done. Voilà! 

> *Note: The preset shortcut in Scrivener didn't work for me, I think because there were two key combinations set for some reason... I fixed this problem by changing the keyboard shortcut under **File > Options > Keyboard**. Search for "citations" and edit the keyboard shortcut as you please. I use CTR+G*

10. When ready, compile scrivener into an odt file. Scan using Zotero as detailed in [this video](https://youtu.be/WO116kjtUow?t=357).

## Customizing script

This script is currently set up to output the scannable cite format. In order to change format, open up the scrivener-picker.ps1 file in a text editor (will open in notepad by default). Look for this line:

`$ref = invoke-expression "curl 'http://localhost:23119/better-bibtex/cayw?format=scannable-cite'"`

You can edit the section which says "scannable-cite" to any of the formats listed [on the Better BibTeX webpage](https://retorque.re/zotero-better-bibtex/cayw/
)

I have had some issues with formatted-citation (which outputs whatever style you have set as quick-cite in Zotero) not outputting italics (such as in book titles). I suspect this has to do with the encoding that Better BibTeX outputs, but I'm not 100% sure. Other styles that do not require rich text encoding should be fine. If you are able to solve the issue with italics, please let me know!

## Issues

If you having issues with this script, please let me know in the issues tab on this page. I only have basic level programming skills, so I can't promise an instant fix, but I might be able to address some concerns, or at the very least point you in the right direction.

One common issue is that the link file doesn't work. If you are having trouble with this script, first try deleting the link file. Right click on the bat file and click *create shortcut.* Once created, right click on the link file and go to properties. Next to *run* select from the drop down menu *minimized* and press okay. Set the link file as the bibliography/citation program in Scrivener.

The other common problem is with faulty installation of the ODF scannable cite plugin. This has been an ongoing problem with the plugin since the update to Zotero 5. First, to check whether or not this is the issue, in Zotero go to *edit>preferences>export*. Check the dropdown menu under "default format" to see if **scannable cite** is one of the available options. If it is not, then follow the instruction in [this forum post to perform a manual installation](https://forums.zotero.org/discussion/57428/scannable-cite-not-showing-up-in-zotero-standalone).

## Contributions

Please feel free to contribute to this project if you feel that you can help.

## Acknowledgment
Inspired by  [Dave Smith Zotpick applescript](https://github.com/davepwsmith/zotpick-applescript) using a modified version of the work by [Glfruit](https://gist.github.com/glfruit)

Includes the files for the [AutoIt cmdlet function](https://www.autoitconsulting.com/site/scripting/autoit-cmdlets-for-windows-powershell/)
