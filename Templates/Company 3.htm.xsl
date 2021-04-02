<?xml version='1.0' encoding='utf-8'?>
 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rs="urn:schemas-microsoft-com:rowset" xmlns:z="#RowsetSchema" exclude-result-prefixes="rs z">
<xsl:output method = "text" indent = "yes"/>
 
<xsl:template match="/">
<![CDATA[<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>Email Signature</title>
		<meta name="description" content="Email Signatures">
		<meta name="keywords" content="HTML,INLINE-STYLING,XML-TRANSFORMS">
		<meta name="author" content="admin@jacksonfamily.me">
		<meta name="format-detection" content="telephone=no,date=no,address=no,email=no,url=no">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	</head>
	<body style="font-family:Arial;">
		<table style="width:500px;" width="500">
			<tr>
				<td colspan="2" align="left" width="100%" style="padding-top:0px;padding-bottom:5px;padding-left:10px;padding-right:10px;width:100%;">
					<img style="float:left;" src="logo-2.jpg" alt="]]><xsl:value-of select="xml/rs:data/z:row/@company" /><![CDATA[">
					<br>
					<hr size="1" noshade>
				</td>
			</tr>
			<tr>
				<td width="230" align="left" valign="top" style="padding-left:10px;padding-right:10px;">
					]]>
						<xsl:if test="xml/rs:data/z:row/@displayname">
						<![CDATA[<span style="color:black;font-family:Arial;font-weight:bold;font-size:9pt;">]]><xsl:value-of select="xml/rs:data/z:row/@displayname"/><![CDATA[</span><br>]]>
						</xsl:if>
						<xsl:if test="xml/rs:data/z:row/@title">
						<![CDATA[<span style="color:black;font-family:Arial;font-weight:bold;font-size:9pt;">]]><xsl:value-of select="xml/rs:data/z:row/@title"/><![CDATA[</span><br>]]>
						</xsl:if>
						<![CDATA[<br><span style="color:black;font-family:Arial;font-size:8pt;">TYPE YOUR FULL OFFICE ADDRESS IN HERE</span>]]>
					<![CDATA[
				</td>
				<td width="270" align="right" style="align:right;">]]>
						<xsl:if test="xml/rs:data/z:row/@mobile">
						<![CDATA[<span style="color:black;font-family:Arial;font-size:8pt;">Mobile: ]]><xsl:value-of select="xml/rs:data/z:row/@mobile" /><![CDATA[</span><br>]]>
						</xsl:if>
						<xsl:if test="xml/rs:data/z:row/@telephonenumber">
						<![CDATA[<span style="color:black;font-family:Arial;font-size:8pt;">Landline: ]]><xsl:value-of select="xml/rs:data/z:row/@telephonenumber" /><![CDATA[</span><br>]]>
						</xsl:if>
						<xsl:if test="xml/rs:data/z:row/@mail"> 
						<![CDATA[<span style="color:black;font-family:Arial;font-size:8pt;">Email: <a href="mailto:]]><xsl:value-of select="translate(xml/rs:data/z:row/@mail, 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')" /><![CDATA[">
						]]><xsl:value-of select="translate(xml/rs:data/z:row/@mail, 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')" /><![CDATA[</a></span><br>
						]]><!-- NOTE THE EMAIL ADDRESS HERE IS CONVERTED TO LOWERCASE WITH THE STRING TRANSLATE (REPLACE) FUNCTION-->
						</xsl:if>
						<![CDATA[
						<br>
						<a style="text-align:center;text-decoration:underline;color:blue;font-family:Arial;font-size:8pt;" href="http://TYPEYOURWEBSITEHERE" target="_new">TYPEYOURWEBSITEHERE</a>
						]]>
						<![CDATA[
				</td>
			</tr>
			<tr>
				<td align="right" colspan="2" style="padding-top:0px;padding-bottom:0px;padding-left:10px;padding-right:10px;font-family:Verdana,Arial;font-size:7pt;">
					<hr size="2">
					<img style="float:right;" src="leaf.png" alt="DO NOT PRINT">&nbsp;<span style="color:#9ACD32;">Please consider the environment before printing this email</span>
				</td>
			</tr>
		</table>
	</body>
</html>]]>
</xsl:template>

</xsl:stylesheet> 