### VBScript designed to automate MS Outlook email signatures in a corporate environment - by Simon Jackson 2010-2021  

### Purpose
To programatically set the following Outlook Settings for employees; including the following 'features':
*   Generate multiple Email Signatures based on selection criteria (see 'LiveSignatures' sub within the code below) [merges user AD-Data with templates to generate Signature HTML/RTF/TXT files]
*   Disable HTML number based format detection (email viewers may change the styles associated with numbers if we don't) *
*	Automatically import images to be referenced within signature templates [<img src=filename.png>]. **
*	Default Compose Styles (font-family name, font-size, font-colour) ***
*	Disable 'Table Grid View' (Outlook ignores html.table.border properties when reading emails, without this)
*	Enable 'Send Pictures with Email' (PNG/JPG images will be stripped during submission, without this)
*   Automatically set the 'default compose' and 'default reply' signature name based on the logged on mailbox, delegate mailboxes etc ***


* 	This permits the use of a html style tag surrounding html anchors [<a style="xxx">link</a>]
** 	Images require a value of 96DPI. Also the height and width should be exact; no client/browser level resizing should take place. support for this cannot be guaranteed by the client
***	These settings will apply once outlook is re-opened


This email signature generation script connects directly from their PC's to the machine's NT Domain (using root DSE discovery). So no need to hard-code the NT domain FQDN.
The code retrieves the users AD record; with a filtered set of included attributes. Then extracts that data to an XML document held within memory.
The XML document is then merged against a series of XSL templates using the standard XML Transform method.
The output of these transforms are a series of HTML/RTF/TXT compliant email signatures; capable of being easily selected from Outlook's Compose email view (Signatures dropdown menu).

This script can also set the Default COMPOSE and REPLY signature file-name (consider using file-names linked to AD attributes, like COMPANYNAME)

The vbscript will ONLY run on a windows domain-joined machine, that MUST be connected to the corporate network somehow (LAN/VPN etc), or it will not be able to retrieve any data.

Without additional arguments passed to the script; a simple double click on the VBS will use the currently logged on users session to communicate with AD. With a locked out user account, the signature generation will fail.
The XML Transforms can..
  ...be called in quick succession (generating multiple signatures, one per template, or many users all of the same template)
  ...perform conditional logic in either the VBS, or inside the template (XSL:IF, XSL:CHOOSE/WHEN and even regex, and even perform a simple lowercase). There are plenty of examples to get you thinking.


### FOLDER STRUCTURE
Parent Directory: 
    Child Directories	Explaination:
    /Templates 			XML Stylesheets with HTML/RTF or TXT content inside (aka XSL)
    /Images				General Image area. All content here is copied out automatically dependant upon the code-base
    /Stationery			Deploy pre-formatted emails. Useful for sales/customer services departments (themed emails aka Stationery)


### Usage Instructions
'	The following (windows only) command line syntax is as follows:
```
wscript <signaturerollout.vbs> [/path:<path to installation folder> /username:test.account /development:true /logging:true]
```
A couple of examples:
```
# Generate signatures for the samaccountname=sjackson0109, and log what happened to %appdata%\microsoft\signatures\
wscript.exe %userprofile%\Documents\vscode\Signatures\SignaturesRollout.vbs /username:sjackson0109 /logging:true
#
# The development:true argument can bypass the 'on error resume next' section acting as a safty net for the LiveSection, but be prepared for some errors that will likely require troubleshooting.
wscript.exe \\ntdomain\netlogon\Signatures\SignaturesRollout.vbs /development:true /username:luke.skywalker
#
# Generate signatures for the currently logged on windows user:
wscript.exe \\ntdomain\netlogon\Signatures\SignaturesRollout.vbs
```


### Preparation Instructions
The main script (SignaturesRollout.vbs) needs to be stored on a network-accessible-share. EG: \\NTDomainName\NETLOGON\Signatures
The extracted folder structure (explained below) should also exist.
Keep the following files in the '/Templates' folder:
```
* Basic.html.xlt
* Basic.rtf.xlt
* Basic.txt.xlt
```

### Writing your own XSL templates (HTM, RTF and or TXT)
Before you delve into this; do some reading on XML within XSLT.
Then work out how to embed HTML into your XSLT files (file-extension should be xlt for this project).

If you need help writing your own HTML.. have a look here: https://github.com/EDMdesigner/modern-html-email-tutorial