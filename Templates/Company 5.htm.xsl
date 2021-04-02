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
	<body style="font-family:Calibri,Arial;">
		<table style="width:460px;" width="460">
			<tr>
				<td align="right" width="120" style="padding:5px;">
					<img style="width:115px;height:105px;float:left;" width="115" height="105" src="logo-3.jpg" alt="]]><xsl:value-of select="xml/rs:data/z:row/@company"/><![CDATA[">
				</td>
				<td align="left" style="margin:5px;padding:5px;">
					<table width="100%" style="width:100%;margin:0px;padding:0px;">]]>
						<xsl:if test="xml/rs:data/z:row/@displayname">
						<![CDATA[
						<tr>
							<td colspan=2 style="color:#333e48;font-family:Calibri,Arial;font-weight:bold;font-size:10pt;width:100%;">]]><xsl:value-of select="xml/rs:data/z:row/@displayname"/><![CDATA[</td>
						</tr>
						]]>
						</xsl:if>
						<xsl:if test="xml/rs:data/z:row/@title">
						<![CDATA[
						<tr>
							<td colspan=2 style="color:#333e48;font-family:Calibri,Arial;font-weight:bold;font-size:10pt;">]]><xsl:value-of select="xml/rs:data/z:row/@title"/><![CDATA[</td>
						</tr>]]>
						</xsl:if>
						<![CDATA[
						<tr >
							<td colspan=2 height="14" style="height:12px;" ></td>
						</tr>]]>
						<![CDATA[
						<tr>
							<td width="30%" style="color:#333e48;font-family:Calibri,Arial;font-size:10pt;width:30%;">Switchboard:</td>
							<td style="color:#333e48;font-family:Calibri,Arial;font-size:10pt;">+44 207 402 0402</td>
						</tr>]]>
						<xsl:if test="xml/rs:data/z:row/@telephonenumber">
						<![CDATA[
						<tr>
							<td width="30%" style="color:#333e48;font-family:Calibri,Arial;font-size:10pt;width:30%;">DDI:</td>
							<td style="color:#333e48;font-family:Calibri,Arial;font-size:10pt;">]]><xsl:value-of select="xml/rs:data/z:row/@telephonenumber" /><![CDATA[</td>
						</tr>]]>
						</xsl:if>
						<xsl:if test="xml/rs:data/z:row/@mobile">
						<![CDATA[
						<tr>
							<td width="30%" style="color:#333e48;font-family:Calibri,Arial;font-size:10pt;width:30%;">MOB:</td>
							<td style="color:#333e48;font-family:Calibri,Arial;font-size:10pt;">]]><xsl:value-of select="xml/rs:data/z:row/@mobile" /><![CDATA[</td>
						</tr>]]>
						</xsl:if>
						<![CDATA[
					</table>
				</td>
			</tr>
			<tr>
				<td align="right" style="padding:5px;"> <img style="height:21px;width:100px;float:left;" height="21" width="100" src="a_marcol_company.png" alt="A Marcol Company"></td>
				<td style="margin:5px;padding-left:10px;padding-top:5px;padding-bottom:5px;padding-right:5px;"><a style="text-decoration:underline;color:#B21A17;font-family:Calibri,Arial;font-size:10pt;" href="http://www.isecgroup.uk" target="_new">www.isecgroup.uk</a></td>
			</tr>
		</table>
	</body>
</html>]]>
</xsl:template>

</xsl:stylesheet> 