# A Zotero / Obsidian Picker Until Obsidian Comes with an Integrated Solution

Insert citations into Obsidian without leaving Obsidian or ever touching your mouse. This will input scannable cite citation codes, using [the type of picker you see in word and libreoffice](http://mossiso.com/wp-content/uploads/2012/04/zotero-new-view-find-citation.png), which can later be scanned by Zotero to create live citations. It takes a bit set-up but is well worth the effort when you are done!

Not a programmer, so forgive any inefficiencies. This script is rather slow so I look forward to native support for Zotero in Obsidian as fast as it's done in [Zettlr](https://www.zettlr.com/).

Works with Windows 10 only since is based on WindowsPowershell and AutoIt Cmdlets.

## Short Manual

The required steps are briefly as follows, more details below:

1. Install Zotero and launch.
2. Install [Better BibText plugin](https://retorque.re/zotero-better-bibtex/) and configure as per instruction.
3. Install this script and assign a hotkey as per below instruction.
4. In Obsidian, press the assigned hotkey. Zotero picker appears letting you search through your Zotero library instantly.
5. Select the item required for citation. Add any necessary suffixes or prefixes.
6. Press Enter to insert it into your Obsidian note in bracketed Pandoc format (which you can alter in the script if necessary to use with RTF/ODF Scan, for example).
7. Once done with writing, export to whatever format required with Pandoc or your other faavorite converter (e.g. RTF/ODF-Scan).

## Prerequisites

This script has only been tested on Windows 10 x64, Zotero 5 and Obsidian 0.6.7.

In order to scan the citations and produce bibliography, you will also need to already have installed pandoc or LibreOffice, as well as the LibreOffice Zotero plugin, depending on which convertor your prefer.

This script also requires the Autoit cmdlet functions. This is to get around a Zotero bug in which the picker does not always appear on top when first called - unfortunately none of the in-built powershell commands did the trick. For ease of use, I have included the necessary files in the zipped folder. Just leave the files in the folder, and everything should work fine. If you prefer, however, you can move the 5 autoitx files to a folder entitled "AutoItX" in the directory C:\Program Files (x86)\WindowsPowerShell\Modules\ - this is however, not necessary.

## Detailed Instructions

1. Install [Pandoc](https://pandoc.org/installing.html) or the [RTF/ODT plugin for zotero](https://zotero-odf-scan.github.io/zotero-odf-scan/).
2. Install the [Better BibTeX plugin](https://retorque.re/zotero-better-bibtex/installation/) and set up automatic export to a local file: `Zotero`  → `File` → `Export Library` → `Better BibLaTeX` and mark `Keep updated`. Make sure to choose a safe location for this file, e.g. in a `ref` subfolder of your project.
3. Download the **zotpick+obsidian.7z file** from this website
4. Unzip the folder and place its contents somewhere you won't accidentally delete it someday. I suggest leaving it in the Documents folder located at `C:\Users\%UserName%\Documents\` but it doesn't actually matter, as long as you can find it later
5. Edit the properties of the file named **zotpick+obsidian-biblatex-win - Shortcut.lnk** by right-clicking it and selecting properties. You have to specify the full path to the batch file in `Target` field as well as the containing folder path in `Start In` field.
6. Assign a shortcut in the `Shortcut key` field. Close the preferences window by clicking `Ok`. Move the batch file to your desktop, otherwise the shortcut will not work. 
7. Cite away! You should now be able to call the picker by using the chosen keyboard shortcut. If Zotero is not already open, this script will launch the application in a minimized window. The picker will launch once the Better BibTeX plugin is fully loaded, which might take a couple of seconds. Search for the source you need by typing in author name or title, as you would using Word or LibreOffice plugin. You can also click on the entry to edit suffix and/or prefix, e.g. to include a page number. Press `Enter` when you are done. Voilà! 

> *Note: Some shortcuts will not work probably due to those keys being assigned to other Windows commands. Try different keyboard combinations if the picker doesn’t show up*

10. When done editing, compile a Word or a PDF using [Pandoc](https://pandoc.org/installing.html) or the [RTF/ODT plugin for zotero](https://zotero-odf-scan.github.io/zotero-odf-scan/). I’ve included a sample Pandoc batch file in the zip archive, please use Pandoc manual for more information.

## Customizing script

This script is currently set up to output the `pandoc` format. In order to change format, open up the Obsidian-picker.ps1 file in a text editor (will open in notepad by default). Look for this line:

`$ref = invoke-expression "curl 'http://localhost:23119/better-bibtex/cayw?format=pandoc'"`

You can edit the section to say "scannable-cite" or any of the formats listed [on the Better BibTeX webpage](https://retorque.re/zotero-better-bibtex/cayw/
)

## Issues

One common issue is that the link file doesn't work. If you are having trouble with this script, first try deleting the link file. Right click on the bat file and click *create shortcut.* Once created, right click on the link file and go to properties. Next to *run* select from the drop down menu *minimized* and press okay.

## Contributions

Please feel free to contribute to this project if you feel that you can help.

## Acknowledgments

- Thanks to [Emilie](https://github.com/AmomentOfMusic) for her [Zotero/Scrivener Picker](https://github.com/AmomentOfMusic/Zotero_scrivener_picker_windows) for which this script is a quick-n-dirty fork.
  - Inspired by   using a modified version of the work by [Glfruit](https://gist.github.com/glfruit)
  - Includes the files for the [AutoIt cmdlet function](https://www.autoitconsulting.com/site/scripting/autoit-cmdlets-for-windows-powershell/)
- Thanks to Emiliano Heyns, the creator of [Better BibTeX plugin for Zotero](https://retorque.re/zotero-better-bibtex/sponsoring/) and the community around it for this extremely helpful addition to Zotero.
- Thanks to the creators of Zettelkasten / PIM / Writer app [Obsidian](https://obsidian.md/) for the fasscinating product that's just scratching the surface but promises a lot.
