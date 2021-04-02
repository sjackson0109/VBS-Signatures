'############################################################################
' AUTHOR: Simon Jackson (admin@jacksonfamily.me)
' Repository: https://github.com/sjackson0109/Signatures
' Publish-Date: 2021 / 04 / 03  @ 00:39

Const TemplatePath = "Templates"
Const ImagesPath = "Images"
Const StationeryPath = "Stationery"
Const adPersistXML = 1
Const adPersistADO = 1
Const adPersistProviderSpecific = 2
Const ForWriting = 2
Const OverwriteExisting = True
Const preserveWhiteSpaceing = False
Const HKCU = &H80000001 
Const ForAppending = 8
Const LOG_FILE = "SignatureRunner"
Const LOG_FILE_EXTENSION = ".log"
Const LOG_FILE_SEPARATOR = "_"
Const useGlobalCatalogue = True

Dim xml, xsl, fso, file, sImagesPath, sStationeryPath, sTemplatePath, tSignaturePath, tStationeryPath, sAttributes
Dim objShell, objNet, com, Cnxn, sOutputfile, tFileName
'Dim adUser, adPAs, adPA

If WScript.Arguments.Named.Exists("path") Then
	path = WScript.Arguments.Named.Item("path")
	If right(path,1) <> "\" Then
		path = path & "\"
	End If
Else
	Set objShell = CreateObject("Wscript.Shell")
	path = objShell.CurrentDirectory & "\Signatures"
	Set objShell = Nothing	
End If

'Grab the AD User object
If WScript.Arguments.Named.Exists("username") Then
	Set adUser = GetADUser("(samaccountname=" & WScript.Arguments.Named.Item("username") & ")")
	'Msgbox "You are testing email signatures generated for '" & adUser("displayName") & "'"
Else
	Set adUser = GetADUser("(samaccountname=" & username & ")")
End If
'adUser.Save tSignaturePath & "AD_USER_DATA.xml", adPersistADO 


If WScript.Arguments.Named.Exists("development") Then
	DevelopmentSignatures
Else
	ON ERROR RESUME NEXT
	LiveSignatures
End If

'#######################
Sub DevelopmentSignatures
	SetImagesPath(path)
	SetStationeryPath(path)
	SetTemplatesPath(path)
	VerifyOutlookSignaturePath
	VerifyOutlookStationeryPath
	
	Call DisableGridView()										'Fixes a known visual issue with tables vs borders - 31/03/2020
	Call SendPicturesWithDocument()								'Enforces Outlook to always attach embedded images - 28/04/2020
	Call DisableRoamingSignaturesTemporaryToggle()				'Enforce a temporary disable of the use of cloud-signatures - 29/03/2021 
	' https://support.microsoft.com/en-us/office/outlook-roaming-signatures-420c2995-1f57-4291-9004-8f6f97c54d15?ui=en-us&rs=en-us&ad=us
	
	Call EmptySignatureFolder("")
	CopyImagesOut
	CopyStationeryOut

	'PROCESS ALL TEMPLATES FOR EVERYONE IN AD WITH THE SAME COMPANY NAME
	Call ProcessTemplateMatchingCompany("COMPANYNAME")
	'IF YOU DO THIS, YOU MIGHT WANT YOUR OWN EMAIL SIGNAURE APPLIED, LIKE SO:
	Call SetDefaultSignature(adUser("displayname"),"Basic", "", "")

	
	'OR HARD-CODE YOUR OWN LDAP SELECTION FILTER
	'Call ProcessTemplateMatchingFilter( "(&(objectCategory=person)(objectClass=user)(!(userAccountControl:1.2.840.113556.1.4.803:=2))(!(department=Service))(mail=*)(company=COMPANYNAME*))" )
	
	
	'RECOMMENDED: Process the Template name which matches the users COMPANY field within AD
	'Call ProcessTemplate(adUser, sTemplatePath, adUser("company"), "")
	
	'RECOMMENDED: Give all employees a basic signature, so they can toggle away from the full one.
	'Call ProcessTemplate(adUser, sTemplatePath, "Basic", "")
	
	'Call ProcessTemplate(adUser, sTemplatePath, "ALL", "") 'Process Templates by name, maybe "ALL"
	
	'PERSONAL ASSISTANTS: Typically have delegated mailbox permisisons, but this is extremely common. Populate the Directors 'msExchAssistantName' attribute with the 'DisplayName' value of the PA.
	'Call ProcessTemplateForPersonalAssistants(adUser)	'use adUser to process your-own role as a PA
	'Call ProcessTemplateForSpecificPerson("DIRECTOR 1")
	
	'Standard stuff, set the default compose font-family-name, font-size and font-colour.
	Call SetComposeStyle("Arial", "10.0", "Black")
	
	'Set the default email signatures to use (compose, reply, outlook-profile-name, account-name)
	Call SetDefaultSignature(adUser("company"),"Basic", "", "")

	'Call SetDefaultSignature(adUser("company"),adUser("company"), "", "")

End Sub
'#############
Sub LiveSignatures

	Call DisableGridView()											'Fixes a known visual issue with tables vs borders - 31/03/2020
	Call EnableSendPicturesWithDocument()							'Enforces Outlook to always attach embedded images - 28/04/2020
	Call DisableRoamingSignaturesTemporaryToggle()					'Enforce a temporary disable of the use of cloud-signatures - 29/03/2021 

	'Grab the AD User object
	If forceUsername Then
		Set adUser = GetADUser("(samaccountname=" & WScript.Arguments.Named.Item("username") & ")")
		Msgbox "You are testing email signatures generated for '" & ADUser("displayName") & "'"
	Else
		Set adUser = GetADUser("(samaccountname=" & username & ")")
	End If
	
	'############################

	' CONTROL RELEASE PER COMPANY NAME FIELD IN AD
	Select Case ADUser("Company")
	Case "CompanyName 1", "Company 1"
		'## Rollout and formatting as agreed by Tom Peacock - 18/09/2017
		Call EmptySignatureFolder("")
		CopyImagesOut
		CopyStationeryOut
		Call ProcessTemplate(ADUser, sTemplatePath, "Basic", "")
		Call ProcessTemplate(ADUser, sTemplatePath, "Company 1", "")
		Call SetComposeStyle("Arial", "10.0", "Black")
		Call SetDefaultSignature(ADUser("company"),"Basic", "", "")
		'############################

	Case "Company 2"
		Call EmptySignatureFolder("")
		CopyImagesOut
		If right(lcase(ADUser("mail")), len(ADUser("mail")) - instr(ADUser("mail"), "@")) = "company2brand1.com" Then
			Call ProcessTemplate(ADUser, sTemplatePath, "Brand 1", "")
			Call ProcessTemplateForPersonalAssistants(adUser)
		'############################
		Else If right(lcase(ADUser("mail")), len(ADUser("mail")) - instr(ADUser("mail"), "@")) = "company2brand2.com" Then
			Call ProcessTemplate(ADUser, sTemplatePath, "Brand 2", "")

		End If
		Call ProcessTemplate(ADUser, sTemplatePath, "Basic", "")
		Call SetComposeStyle("Calibri", "10.0", "Black")
		Call SetDefaultSignature("Basic","Basic", "", "")
		'############################

	Case Else
		CopyImagesOut
		Call ProcessTemplate(ADUser, sTemplatePath, "Basic", "")
		Call SetComposeStyle("Arial", "10.0", "Black")
		Call SetDefaultSignature("","Basic", "", "")
		'############################
	End Select					
End Sub
Function GetADUser(sFilter) 'As ADODB.Recordset
	Set rsAD = CreateObject("ADODB.Recordset")
	'  'Build the Global Catalog query string (notice the GC prefix)...
	If useGlobalCatalogue Then
		sTransport = "GC://"
	Else
		sTransport = "LDAP://"
	End If
	Set Cnxn = WScript.CreateObject( "ADODB.Connection" )
		Set com = WScript.CreateObject( "ADODB.Command" )
			Cnxn.Provider = "ADSDSOObject"
			Cnxn.Open "Active Directory Provider"
			Set com.ActiveConnection = Cnxn
				sAttributes = "displayname,title,department,company,samaccountname,physicalDeliveryOfficeName,mail,msRTCSIP-PrimaryUserAddress,userPrincipalName,homephone,ipphone,primarytelexnumber,pager,telephonenumber,mobile,streetaddress,st,postOfficeBox,l,postalcode,wWWHomePage,distinguishedName"
				com.CommandText = "<" & sTransport & GetObject(sTransport & "RootDSE").Get("DefaultNamingContext") & ">;" & sFilter & ";" & sAttributes
				com.Properties("Page Size") = 512
				com.Properties("TimeOut") = 30 'seconds
				Set rsAD = com.Execute
				set GetADUser = rsAD
				'msgbox rsAD.RecordCount
				WriteLog("GetADUser: rsAD.RecordCount = " & rsAD.RecordCount)
			Set com.ActiveConnection = Nothing
		Set com = Nothing
	Set Cnxn = Nothing
	Set rsAD = Nothing
End Function
Sub VerifyOutlookSignaturePath
	Set objShell = CreateObject("Wscript.Shell")
		'Lets Save the signature file to disk to the profile - we are aiming for the Outlook signature path
		sAppData = objShell.ExpandEnvironmentStrings("%AppData%")
		WriteLog("VerifyOutlookSignaturesPath: sAppData = " & sAppData)
		tSignaturePath = sAppData & "\Microsoft\Signatures\"
		WriteLog("VerifyOutlookSignaturesPath: tSignaturePath = " & tSignaturePath)
		'If the target folder doesn't exist (new build windows/outlook profile) then we should create the folder
		Set objFSO = CreateObject("Scripting.FileSystemObject")
		If NOT objFSO.FolderExists(tSignaturePath) Then
			WriteLog("VerifyOutlookSignaturesPath: No Signature Folder. Creating a new one")
			objFSO.CreateFolder(tSignaturePath)
		End If
		Set objFSO = Nothing
	Set objShell = Nothing
End Sub
Sub VerifyOutlookStationeryPath
	Set objShell = CreateObject("Wscript.Shell")
		'Lets Save the signature file to disk to the profile - we are aiming for the Outlook signature path
		sAppData = objShell.ExpandEnvironmentStrings("%AppData%")
		WriteLog("VerifyOutlookStationeryPath: sAppData = " & sAppData)
		tStationeryPath = sAppData & "\Microsoft\Stationery\"
		WriteLog("VerifyOutlookStationeryPath: tStationeryPath = " & tStationeryPath)
		'If the target folder doesn't exist (new build windows/outlook profile) then we should create the folder
		Set objFSO = CreateObject("Scripting.FileSystemObject")
		If NOT objFSO.FolderExists(tStationeryPath) Then
			WriteLog("VerifyOutlookStationeryPath: No Stationery Folder. Creating a new one")
			objFSO.CreateFolder(tStationeryPath)
		End If
	Set objShell = Nothing
End Sub
Function EmptySignatureFolder(tName)
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	'Check if the folder exists
	If objFSO.FolderExists(tSignaturePath) Then
		WriteLog("EmptySignatureFolder: folder found = true")
		If tName <> "" Then
			WriteLog("EmptySignatureFolder: filename specified, the file '" & tName & "'needs deleting")
			If objFSO.FileExists( tSignaturePath & "\" & tName & "*") Then
				WriteLog("EmptySignatureFolder: Deleting'" & tSignaturePath & "\" & tName & "*" )
				objFSO.GetFile( tSignaturePath & "\" & tName & "*" ).Delete DeleteReadOnly
			End If
		Else
			'delete all files inside the folder
			Set objFolder = objFSO.GetFolder(tSignaturePath)
			For Each objFile in objFolder.Files
				objFile.Delete DeleteReadOnly	
			Next
		End If
	Else 
		'if the folder doesn't exist, create it
		objFSO.CreateFolder(tSignaturePath)	
	End If
	Set objFSO = Nothing
End Function
Sub CopyImagesOut
	Set objFSO = CreateObject("Scripting.FileSystemObject")
		WriteLog("CopyImagesOut: copying '" & sImagesPath & "\*' to " & tSignaturePath & "\")
		objFSO.CopyFile sImagesPath & "\*", tSignaturePath & "\" , OverwriteExisting
	Set objFSO = Nothing
End Sub
Sub CopyStationeryOut
	Set objFSO = CreateObject("Scripting.FileSystemObject")
		WriteLog("CopyStationeryOut: copying '" & sStationeryPath & "\*' to " & tStationeryPath & "\")
		objFSO.CopyFile sStationeryPath & "\*", tStationeryPath & "\" , OverwriteExisting
	Set objFSO = Nothing
End Sub
Sub SetDefaultSignature(strSigNameA, strSigNameB, strProfile, strAccount)
	Err.Clear
	'INPUT: Compose Sig, Reply Sig, Profile Name (optional), Account Name (optional)
	Set objreg = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\default:StdRegProv")
	
	'#Handle different MAPI Profile Paths:
	profilePathPre2013 		= "Software\Microsoft\Windows NT\CurrentVersion\Windows Messaging Subsystem\Profiles\"
	profilePath2013 		= "Software\Microsoft\Office\15.0\Outlook\Profiles\"
	profilePathPost2016 	= "Software\Microsoft\Office\16.0\Outlook\Profiles\"

	strKeyName = "DefaultProfile"
		
	' get default profile name if none specified
	If strProfile = "" Then
		objReg.GetStringValue HKCU, profilePathPre2013, strKeyName, strProfile
		If IsNull(strProfile) Then
			'Wscript.Echo "NO OUTLOOK DEFAULT PROFILE FOUND."
		End If
	End If
	' build array from signature name
	myCompose = StringToByteArray(strSigNameA, True)
	myReply = StringToByteArray(strSigNameB, True)
	profilePathPre2013 = profilePathPre2013 & strProfile & "9375CFF0413111d3B88A00104B2A6676"
	'msgbox profilePathPre2013
	objReg.EnumKey HKCU, profilePathPre2013, arrProfileKeys
	Dim A2(), U1, i, writepos  
	If IsArray(arrProfileKeys) Then
		For Each subkey In arrProfileKeys
			strsubkeypath = profilePathPre2013 & "\" & subkey
			objReg.GetBinaryValue HKCU, strsubkeypath, "Account Name", arrayHex
			Abytes = arrayHex  
				U1 = UBound(ABytes)  
			Redim A2(U1 \ 2)  
			writepos = 0
			For i = 0 to U1 Step 2  
				If Abytes(i) <> 0 Then
					A2(writepos) = Chr(Abytes(i))
					writepos = writepos + 1
				End If
			Next  
			accountName = Join(A2, "")
			'msgbox "Account Found: " & accountName & vbcrlf & "Name to Match: " & strAccount
			If strAccount= "" or lcase(accountName) = lcase(strAccount) Then	
				objreg.SetBinaryValue HKCU, strsubkeypath, "New Signature", myCompose
				objreg.SetBinaryValue HKCU, strsubkeypath, "Reply-Forward Signature", myReply
			End If
		Next
	Else
		'Wscript.Echo "NO OUTLOOK DEFAULT PROFILE FOUND UNDER THE OLD-SCHOOL REG PATH"
		'#NEW METHOD POST OFFICE 2013!
				
		objReg.GetStringValue HKCU, profilePathPost2016, strKeyName, strProfile
		' Set default profile name if none specified
		If IsNull(strProfile) Then
			strProfile = "Outlook"
		End If
		strsubkeypath = profilePathPost2016 & strProfile & "\9375CFF0413111d3B88A00104B2A6676\00000002"
		'Wscript.Echo strsubkeypath

		objReg.GetStringValue HKCU, strsubkeypath, "Account Name", accountName
		If IsNull(accountName) Then
			'Wscript.Echo "The default outlook profile does not exist."
		Else
			'Wscript.Echo "The registry key exists. (" & accountName & ")"
			'HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Outlook\Profiles\Outlook\9375CFF0413111d3B88A00104B2A6676\00000002
		End If

		' no conversions from signature name
		myCompose = strSigNameA
		myReply = strSigNameB
		' write it
		objreg.SetStringValue HKCU, strsubkeypath, "New Signature", myCompose
		objreg.SetStringValue HKCU, strsubkeypath, "Reply-Forward Signature", myReply
	End If

End Sub
Sub DisableRoamingSignaturesTemporaryToggle()
	Set objreg = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\default:StdRegProv")
		WriteLog("DisableRoamingSignaturesTemporaryToggle: setting 'HKCU\Software\Microsoft\Office\16.0\Outlook\Setup\DisableRoamingSignaturesTemporaryToggle = 1'")
		objreg.SetDWORDValue HKCU, "Software\Microsoft\Office\16.0\Outlook\Setup", "DisableRoamingSignaturesTemporaryToggle", 1
	Set objreg = Nothing
End Sub
Sub DisableGridView()
	Set objreg = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\default:StdRegProv")
		'Handle the GridLines issue with HTML Tables rendering with a dotted border
		WriteLog("DisableGridView: setting 'HKCU\Software\Microsoft\Office\16.0\Word\Options\VisiDrawTableDrs = 0'")
		objreg.SetDWORDValue HKCU, "Software\Microsoft\Office\16.0\Word\Options", "VisiDrawTableDrs", 0
	Set objreg = Nothing
End Sub
Sub SendPicturesWithDocument()
	Set objreg = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\default:StdRegProv")
		'Handles the missing picures issue by embedding them instead, not an issue if images are URL based
		WriteLog("SendPicturesWithDocument: setting 'HKCU\Software\Microsoft\Office\XX.0\Outlook\Options\Mail\Send Pictures With Document = 1'")
		objreg.SetDWORDValue HKCU, "Software\Microsoft\Office\15.0\Outlook\Options\Mail", "Send Pictures With Document", 1
		objreg.SetDWORDValue HKCU, "Software\Microsoft\Office\16.0\Outlook\Options\Mail", "Send Pictures With Document", 1
	Set objreg = Nothing
End Sub
Sub SetComposeStyle(strFontFamily, strFontSize, strFontColour)
  
	Set oRegistry = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\default:StdRegProv") 

	strComposeFontComplex = "<html><head><style> span.PersonalComposeStyle{mso-style-name:'Personal Compose Style'; mso-style-type:personal-compose;mso-style-noshow:yes;mso-style-unhide:no;mso-ansi-font-size:"+strFontSize+"pt;mso-bidi-font-size:"+strFontSize+"pt;font-family:'"+strFontFamily+"','sans-serif';mso-ascii-font-family:'"+strFontFamily+"';mso-hansi-font-family:'"+strFontFamily+"';mso-bidi-font-family:'"+strFontFamily+"';mso-bidi-theme-font:minor-bidi;color:"+strFontColour+";}--></style></head></html>"
	strReplyFontComplex = "<html><head><style> span.PersonalReplyStyle{mso-style-name:'Personal Reply Style';mso-style-type:personal-reply;mso-style-noshow:yes;mso-style-unhide:no;mso-ansi-font-size:"+strFontSize+"pt;mso-bidi-font-size:"+strFontSize+"pt;font-family:'"+strFontFamily+"','sans-serif';mso-ascii-font-family:'"+strFontFamily+"'; mso-hansi-font-family:'"+strFontFamily+"';mso-bidi-font-family:'"+strFontFamily+"'; mso-bidi-theme-font:minor-bidi;color:"+strFontColour+";}--></style></head></html>"
		
	'Convert the data type from a UTF-8 string to an ASCII string
	ascComposeFontComplex 	= 	CONVERT_STRING_TO_ASC(strComposeFontComplex)
	ascReplyFontComplex		=	CONVERT_STRING_TO_ASC(strReplyFontComplex)
	
	
	ascComposeFontSimple	=	CONVERT_STRING_TO_HEX(strFontFamily)
	ascReplyFontSimple		=	CONVERT_STRING_TO_HEX(strFontFamily)
	'msgbox ascComposeFontSimple
	
	'Split the data type into a single valued array
	arrComposeFontComplex 	= 	Split(ascComposeFontComplex,",")
	arrReplyFontComplex		=	Split(ascReplyFontComplex,",")
	
	arrComposeFontSimple	=	ArrayHexToDec(Split("3c,00,00,00,1f,00,00,f8,00,00,00,00,dc,00,00,00,00,00,00,00,ff,ff,00,dd,00,22," + ascComposeFontSimple + ",00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00", ","))
	arrReplyFontSimple		=	ArrayHexToDec(Split("3c,00,00,00,1f,00,00,f8,00,00,00,00,c8,00,00,00,00,00,00,00,1f,49,7d,00,00,22," + ascReplyFontSimple + ",00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00", ","))
	
	ReDim Preserve arrComposeFontSimple(42)
	ReDim Preserve arrReplyFontSimple(42)

	WriteLog("SetComposeStyle: setting 'HKCU\Software\Microsoft\Office\XX.0\Common\MailSettings\ComposeFontComplex [arr]'")
	WriteLog("SetComposeStyle: setting 'HKCU\Software\Microsoft\Office\XX.0\Common\MailSettings\ReplyFontComplex [arr]'")
	WriteLog("SetComposeStyle: setting 'HKCU\Software\Microsoft\Office\XX.0\Common\MailSettings\TextFontComplex [arr]'")
	
	oRegistry.SetBinaryValue HKCU,"Software\Microsoft\Office\16.0\Common\MailSettings", "ComposeFontComplex", arrComposeFontComplex  
	oRegistry.SetBinaryValue HKCU,"Software\Microsoft\Office\16.0\Common\MailSettings", "ReplyFontComplex", arrReplyFontComplex 
	oRegistry.SetBinaryValue HKCU,"Software\Microsoft\Office\16.0\Common\MailSettings", "TextFontComplex", arrComposeFontComplex
	
	
	WriteLog("SetComposeStyle: setting 'HKCU\Software\Microsoft\Office\XX.0\Common\MailSettings\ComposeFontSimple [arr]'")
	WriteLog("SetComposeStyle: setting 'HKCU\Software\Microsoft\Office\XX.0\Common\MailSettings\ReplyFontSimple [arr]'")
	WriteLog("SetComposeStyle: setting 'HKCU\Software\Microsoft\Office\XX.0\Common\MailSettings\TextFontSimple [arr]'")

	oRegistry.SetBinaryValue HKCU,"Software\Microsoft\Office\16.0\Common\MailSettings", "ComposeFontSimple", arrComposeFontSimple
	oRegistry.SetBinaryValue HKCU,"Software\Microsoft\Office\16.0\Common\MailSettings", "ReplyFontSimple", arrReplyFontSimple
	oRegistry.SetBinaryValue HKCU,"Software\Microsoft\Office\16.0\Common\MailSettings", "TextFontSimple", arrReplyFontSimple

	Set oRegistry = Nothing
End Sub
'##################FUNCTIONS BELOW HERE#############################
Function userName
	Set objNet = WScript.CreateObject("WScript.Network")
		userName = objNet.UserName
		WriteLog("userName = '" & userName & "'")
	Set objNet = Nothing
End Function
Function SetImagesPath(path)
	sImagesPath = Left(path, InstrRev(path, "\")) & ImagesPath
	WriteLog("SetImagesPath: sImagesPath = '" & sImagesPath & "'")
End Function
Function SetStationeryPath(path)
	sStationeryPath = Left(path, InstrRev(path, "\")) & StationeryPath
	WriteLog("SetStationeryPath: sStationeryPath = '" & sStationeryPath & "'")
End Function
Function SetTemplatesPath(path)
	sTemplatePath = Left(path, InstrRev(path, "\")) & TemplatePath
	WriteLog("SetTemplatesPath: sTemplatePath = '" & sTemplatePath & "'")
End Function
Function XSLTransform(record, objFile, tFileName)
	'msgbox "Processing file: " & vbCrLf & "objFile.Name: " & objFile.Name & vbCrLf & "tFileName: " & tFileName, vbokonly, "Signature Rollout - ProcessXSL"
	Set xml = CreateObject("Microsoft.XMLDOM")
		record.Save xml, adPersistXML
		
		If NOT (tFileName = objFile.Name or tFileName = "") then
			'Process filenames as they their new name suggests
			Set xsl = CreateObject("Microsoft.XMLDOM")
			xsl.async = False
			'Load the XSL file. in the same path as the script, but it could be stored anywhere. e.g. Webserver
 			xsl.load objFile.Path 
			xsl.preserveWhiteSpace = preserveWhiteSpaceing
			If InStr(objFile.Name,".htm") then ext = ".htm" End If
			If InStr(objFile.Name,".rtf") then ext = ".rtf" End If
			If InStr(objFile.Name,".txt") then ext = ".txt" End If
			sOutputfile = tSignaturePath & tFileName & ext
			'msgbox "objFile: " & objFile & vbCrLf & "sOutputfile: " &  sOutputfile, vbOkOnly, "Signature Rollout - ProcessXSL PA"
			Set fso = CreateObject("Scripting.Filesystemobject")
				Set file = fso.OpenTextFile(sOutputFile,ForWriting,True)
					file.Write xml.transformNode(xsl)
				Set file = Nothing
			Set fso = Nothing
			Set xsl = Nothing	
		Else
			'Process filenames as the template had them
			Set xsl = CreateObject("Microsoft.XMLDOM")
			xsl.async = False
			'Load the XSL file. in the same path as the script, but it could be stored anywhere. e.g. Webserver
 			xsl.load objFile.Path 
			xsl.preserveWhiteSpace = preserveWhiteSpaceing
			sOutputfile = tSignaturePath & Replace(objFile.Name,".xsl","")
			'msgbox "objFile: " & objFile & vbCrLf & "sOutputfile: " & sOutputfile, vbOkOnly, "Signature Rollout - ProcessXSL NORM"
			Set fso = CreateObject("Scripting.Filesystemobject")
				Set file = fso.OpenTextFile(sOutputFile,ForWriting,True)
					file.Write xml.transformNode(xsl)
				Set file = Nothing
			Set fso = Nothing
			Set xsl = Nothing
		End If
	Set xml = Nothing
End Function
Function ProcessTemplate(record, sFolderPath, templateName, outputFileName)
'   Call ProcessTemplate(adUsers, sTemplatePath, adUsers("company"), adUsers("displayname"))	'ProcessTemplateMatchingCompany
	'msgbox "sFolderPath: " & sFolderPath & vbCrLf & "templateName: " & templateName & vbCrLf & "outputFileName: " & outputFileName, vbOkOnly, "Signature Rollout - ProcessTemplate"
	Set oFSO = CreateObject("Scripting.FileSystemObject")  
	Set oFolder = oFSO.GetFolder(sFolderPath) 
	' Process single or multiple files
	If (templateName = "ALL") Then
		For Each oFile In oFolder.Files
			If not oFile.Name = "Thumbs.db" Then
				Call XSLTransform(record, oFile, oFile.Name)
			End If
		Next 
	Else
		For Each oFile In oFolder.Files
		'msgbox Replace(Replace(Replace(oFile.Name,".htm.xsl",""),".rtf.xsl",""),".txt.xsl",""),vbokonly, "here"
			If Replace(Replace(Replace(oFile.Name,".htm.xsl",""),".rtf.xsl",""),".txt.xsl","") = templateName Then
				If ( outputFileName = "" ) Then
					'msgbox "outputFileName: " & outputFileName, vbokonly,"Signature Rollout - ProcessTemplate EMPTY"
					Call XSLTransform(record, oFile, "")
				Else
					'msgbox "outputFileName: " & outputFileName, vbokonly,"Signature Rollout - ProcessTemplate"
					Call XSLTransform(record, oFile, outputFileName)
				End If
			End If
		Next 
	End If
	Set oFolder	= Nothing
	Set oFSO = Nothing
End Function
Function ProcessTemplateForSpecificPerson(name)
	set adPerson = GetADUser( "(&(objectCategory=person)(objectClass=user)(!(userAccountControl:1.2.840.113556.1.4.803:=2))(CN=" & name & "))" ) 'call the function with the necessary ldap filter as the argument
	adPerson.Save tSignaturePath & "AD_PERSON_DATA.xml", adPersistADO 

	If (adPerson.BOF or adPerson.EOF) Then
		Exit Function
	ElseIf adPerson.RecordCount = 0 Then
		Exit Function
	ElseIf adPerson.RecordCount = 1 Then
		Call ProcessTemplate(adPerson, sTemplatePath, adPerson("company"),adPerson("displayname"))
	Else 'adPerson.RecordCount > 1
		adPerson.MoveFirst
		For i = 0 To adPerson.RecordCount
			'msgbox "Processing Signature for: " & adPerson("displayname"), vbOkOnly, "Signature Rollout - Processing PA"
			Set adPerson = GetADUser( "(displayName=" & adPerson("displayname") & ")" )
			Call ProcessTemplate(adPerson, sTemplatePath, adPerson("company"),adPerson("displayname"))
			'Call SetDefaultSignature(adPerson("displayname").value(i),adPerson("displayname"), "" , adPerson("displayname"))
			adPerson.MoveNext
			i = i + 1
		Next
	End If
	Set ProcessTemplateForSpecificPerson = adPerson
End Function
Function ProcessTemplateForPersonalAssistants(adUser)
	set adPAs = GetADUser( "(&(objectCategory=person)(objectClass=user)(!(userAccountControl:1.2.840.113556.1.4.803:=2))(msExchAssistantName=*" & adUser("displayname") & "*))" ) 'call the function with the necessary ldap filter as the argument
	adPAs.Save tSignaturePath & "AD_PA_DATA.xml", adPersistADO 

	If (adPAs.BOF or adPAs.EOF) Then
		Exit Function
	ElseIf adPAs.RecordCount = 0 Then
		Exit Function
	ElseIf adPAs.RecordCount = 1 Then
		Call ProcessTemplate(adPAs, sTemplatePath, adPAs("company"),adPAs("displayname"))
	Else 'adPAs.RecordCount > 1
		adPAs.MoveFirst
		For i = 0 To adPAs.RecordCount
			'msgbox "Processing Signature for: " & adPAs("displayname"), vbOkOnly, "Signature Rollout - Processing PA"
			Set adPA = GetADUser( "(displayName=" & adPAs("displayname") & ")" )
			Call ProcessTemplate(adPA, sTemplatePath, adPA("company"),adPA("displayname"))
			'Call SetDefaultSignature(adPA("displayname").value(i),adPA("displayname"), "" , adPA("displayname"))
			adPAs.MoveNext
			i = i + 1
		Next
	End If
	Set ProcessTemplateForPersonalAssistants = adPAs
End Function
Function ProcessTemplateForDelegates(adUser)
	set adDelegates = GetADUser( "(&(objectCategory=person)(objectClass=user)(!(userAccountControl:1.2.840.113556.1.4.803:=2))(msExchDelegateListLink=" & adUser("distinguishedName") & "))" ) 'call the function with the necessary ldap filter as the argument
	adDelegates.Save tSignaturePath & "AD_DEL_DATA.xml", adPersistADO 

	If (adDelegates.BOF or adDelegates.EOF) Then
		Exit Function
	ElseIf adDelegates.RecordCount = 0 Then
		Exit Function
	ElseIf adDelegates.RecordCount = 1 Then
		Call ProcessTemplate(adDelegates, sTemplatePath, adDelegates("company"),adDelegates("displayname"))
	Else 'adDelegates.RecordCount > 1
		adDelegates.MoveFirst
		For i = 0 To adDelegates.RecordCount
			'msgbox "Processing Signature for: " & adDelegates("displayname"), vbOkOnly, "Signature Rollout - Processing PA"
			Set adDelegate = GetADUser( "(displayName=" & adDelegates("displayname") & ")" )
			Call ProcessTemplate(adDelegate, sTemplatePath, adDelegate("company"),adDelegate("displayname"))
			'Call SetDefaultSignature(adDelegate("displayname").value(i),adDelegate("displayname"), "" , adDelegate("displayname"))
			adDelegates.MoveNext
			i = i + 1
		Next
	End If
	Set ProcessTemplateForDelegates = adPAs
End Function
Function ProcessTemplateMatchingCompany(company)
	set adUsers = GetADUser( "(&(objectCategory=person)(objectClass=user)(!(userAccountControl:1.2.840.113556.1.4.803:=2))(mail=*)(company=" & company & "))" ) 'call the function with the necessary ldap filter as the argument
	'adUsers.Save tSignaturePath & "PA_ALL_USER_DATA.xml", adPersistADO
	'msgbox "Record Count: " & adUsers.RecordCount, vbOkOnly, "Signature Rollout - Processing All Company"
	If (adUsers.BOF or adUsers.EOF) Then
		'msgbox "no users found"
		Exit Function
	ElseIf adUsers.RecordCount = 0 Then
		'msgbox "zero users found"
		Exit Function
	ElseIf adUsers.RecordCount = 1 Then
		'msgbox "one user found" & adUsers("displayname")
		Call ProcessTemplate(adUsers, sTemplatePath, adUsers("company"), adUsers("displayname"))
	Else 'adPAs.RecordCount > 1
		'msgbox "more than one user found"
		adUsers.MoveFirst
		For i = 0 To adUsers.RecordCount
			Set adUser = GetADUser( "(displayname=" & adUsers("displayname") & ")" )
			'msgbox "User found: " & adUser("displayname"), vbOkOnly, "Signature Rollout - Processing All Company, per user"
			Call ProcessTemplate(adUser, sTemplatePath, adUser("company"), adUser("displayname"))
			adUsers.MoveNext
			i = i + 1
		Next
	End If
End Function
Function ProcessTemplateMatchingFilter(ldapfilter)
	set adUsers = GetADUser( ldapfilter ) 'call the function with the necessary ldap filter as the argument
	'adUsers.Save tSignaturePath & "AD_Matching_Filter.xml", adPersistADO
	'msgbox "Record Count: " & adUsers.RecordCount, vbOkOnly, "Signature Rollout - Processing All People Matching LDAP Filter"
	If (adUsers.BOF or adUsers.EOF) Then
		Exit Function
	ElseIf adUsers.RecordCount = 0 Then
		Exit Function
	ElseIf adUsers.RecordCount = 1 Then
		'Msgbox "Only 1x user found: " & adUsers("displayname"), vbOkOnly, "Signature Rollout - Processing All People Matching LDAP Filter, per user"
		Call ProcessTemplate(adUsers, sTemplatePath, adUsers("company"), adUsers("displayname"))
	Else 'adPAs.RecordCount > 1
		adUsers.MoveFirst
		For i = 0 To adUsers.RecordCount
			Set adUser = GetADUser( "(displayname=" & adUsers("displayname") & ")" )
			'msgbox "User found: " & adUser("displayname"), vbOkOnly, "Signature Rollout - Processing All People Matching LDAP Filter, per user"
			Call ProcessTemplate(adUser, sTemplatePath, adUser("company"), adUser("displayname"))
			adUsers.MoveNext
			i = i + 1
		Next
	End If
End Function
Function CONVERT_STRING_TO_HEX(strVariable)	'used
	Dim intStrLen, intLoop, strHex, HexChr
	strVariable = Trim(strVariable)	'not really needed, as they are trimmed anyway
	intStrLen = Len(strVariable)		'read the length to itterate through them character by character
	HexChr = ""
	For intLoop = 1 To intStrLen
		
		HexChr = Right("0" & Hex(Asc(Mid(strVariable, intLoop, 1))), 2)
		If strHex = "" Then	
			strHex = HexChr
		Else
			strHex = strHex & "," & HexChr
		End If
	Next
	'Return the result
	CONVERT_STRING_TO_HEX = strHex
End Function
Function CONVERT_STRING_TO_ASC(strVariable)	'outputs the string given as a Decimal value off the ASCII characters, commma separated
	Dim intStrLen, intLoop, strASC, ASCChr
	strVariable = Trim(strVariable)	'not really needed, as they are trimmed anyway
	intStrLen = Len(strVariable)		'read the length to itterate through them character by character
	ASCChr = ""
	For intLoop = 1 To intStrLen
		
		ASCChr = Right("000" & Asc(Mid(strVariable, intLoop, 1)), 4)
		If strASC = "" Then	
			strASC = ASCChr
		Else
			strASC = strASC & "," & ASCChr
		End If
	Next
	'Return the result
	CONVERT_STRING_TO_ASC = strASC
End Function
Function ArrayHexToDec(arrHex)
  Dim i, arrDec
  ReDim arrDec(UBound(arrHex))
  For i = 0 to UBound(arrHex)
    If arrHex(i) = "00" Then
      arrDec(i) = 0
    Else
      arrDec(i) = CByte("&H" & arrHex(i))
    End If
  Next
  ArrayHexToDec = arrDec
End Function
Function RegistryObjExists (RegistryKey)
    'Try reading the key
    objShell.RegRead RegistryKey
	'msgbox "regread error " & Err
    'Catch the error
    Select Case Err
      'Error Code 0 = 'success'
      Case 0:
        RegistryObjExists = true
      'This checks for the (Default) value existing (but being blank); as well as key's not existing at all (same error code)
      Case &h80070002:
        'Read the error description, removing the registry key from that description
        ErrDescription = Replace(Err.description, RegistryKey, "")
        'Clear the error
        Err.clear
        'Read in a registry key we know doesn't exist (to create an error description for something that doesnt exist)
        objShell.RegRead "HKEY_ERROR\"
        'The registry key exists if the error description from the HKEY_ERROR RegRead attempt doesn't match the error
        'description from our RegistryKey RegRead attempt
        If (ErrDescription <> Replace(Err.description, "HKEY_ERROR\", "")) Then
          'might be non-key object, so read in a non-existent child of existing key
          objShell.RegRead "HKCU\Error"
          If (ErrDescription <> Replace(Err.description, "HKCU\Error", "")) Then
            RegistryObjExists = true
          Else
            RegistryObjExists = False
          End If
        Else
          RegistryObjExists = false
        End If
      'Any other error code is a failure code
      Case Else:
        RegistryObjExists = false
    End Select
    On Error Goto 0
End Function
Function SimpleBinaryToString(Binary)
	'SimpleBinaryToString converts binary data (VT_UI1 | VT_ARRAY Or MultiByte string)
	'to a string (BSTR) using MultiByte VBS functions
	Dim I, S
	For I = 1 To LenB(Binary)
	S = S & Chr(AscB(MidB(Binary, I, 1)))
	Next
	SimpleBinaryToString = S
End Function
Public Function StringToByteArray(Data, NeedNullTerminator)
    Dim strAll
    strAll = StringToHex4(Data)
    If NeedNullTerminator Then
        strAll = strAll & "0000"
    End If
    intLen = Len(strAll) \ 2
    ReDim arr(intLen - 1)
    For i = 1 To Len(strAll) \ 2
        arr(i - 1) = CByte _
                   ("&H" & Mid(strAll, (2 * i) - 1, 2))
    Next
    StringToByteArray = arr
End Function
Public Function StringToHex4(Data)
    on error resume next
	' Input: normal text
    ' Output: four-character string for each character,
    '         e.g. "3204" for lower-case Russian B,
    '        "6500" for ASCII e
    ' Output: correct characters
    ' needs to reverse order of bytes from 0432
    Dim strAll
    For i = 1 To Len(Data)
        ' get the four-character hex for each character
        strChar = Mid(Data, i, 1)
        strTemp = Right("00" & Hex(AscW(strChar)), 4)
        strAll = strAll & Right(strTemp, 2) & Left(strTemp, 2)
    Next
    StringToHex4 = strAll
End Function
Function IsOutlookRunning()
    strQuery = "Select * from Win32_Process where Name = 'Outlook.exe'"
    Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
    Set colProcesses = objWMIService.ExecQuery(strQuery)
    For Each objProcess In colProcesses
        If UCase(objProcess.Name) = "OUTLOOK.EXE" Then
            IsOutlookRunning = True
        Else
            IsOutlookRunning = False
        End If
    Next
End Function
sub WriteLog(message)
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	'Get log file with current date 
	logFile = tSignaturePath & LOG_FILE & LOG_FILE_SEPARATOR & GetCurrentDate() & LOG_FILE_EXTENSION
	'Open log file in appending mode
	Set objLogger = objFSO.OpenTextFile(logFile,ForAppending,True)
	'Prefix timestamp
	message = FormatDateTime(Now(),vbLongDate) & " " & FormatDateTime(Now(),vbLongTime) & " >>> " & message
	'Write log message
	objLogger.WriteLine(message)
	'Close file
	objLogger.Close()
End Sub

'To get current date in ddMMyyyy format. 
'Ex: 09 Apr 2016 wil be returned as 09042016 and 15 Oct 2016 will be returned as 15102016
Function GetCurrentDate()
	timeStamp = Now()
 	d = PrefixZero(Day(timestamp))
    	m = PrefixZero(Month(timestamp))
    	y = Year(timestamp)
    	GetCurrentDate=  d & m &  y
End Function

'Prefix zero if day or month is in single digit
Function PrefixZero(num)
	If(Len(num)=1) Then
		PrefixZero="0"&num
	Else
		PrefixZero=num
	End If
End Function