<?xml version='1.0' encoding='utf-8'?>
 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rs="urn:schemas-microsoft-com:rowset" xmlns:z="#RowsetSchema" exclude-result-prefixes="rs z">
<xsl:output method = "text" indent = "yes"/>
 
<xsl:template match="/">
<![CDATA[<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
	<head>
		<title>Email Signature</title>
		<meta name="description" content="Email Signature">
		<meta name="keywords" content="HTML,INLINE-STYLING,XML-TRANSFORMS">
		<meta name="author" content="admin@jacksonfamily.me">
		<meta name="format-detection" content="telephone=no,date=no,address=no,email=no,url=no">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	</head>
	<body style="font-family:sans-serif;">
		<table style="width:528px;padding:0px 0px 0px 0px;margin:0px 0px 0px 0px;border:none;border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt;">
			<tr>
				<td style="padding:0px 5px 0px 5px;margin:0px 0px 0px 0px;text-align:center;">
					<img src="logo-4.jpg" alt="]]><xsl:value-of select="xml/rs:data/z:row/@company" /><![CDATA[">
					<br>&nbsp;&nbsp;&nbsp;<img src="bab_iso27001_2020_100x100.png" alt="ISO 27001 Information Security Certification 2017-2020" height="82" width="82">
					&nbsp;&nbsp;&nbsp;<img src="CEplus_83x70.png" height="83" width="70" alt="Cyber Essentials Plus Certification and Cyber Essentials 2019-2020, certificate number: IASME-CE-000000">
				</td>
				<td style="border-right:2px solid #de007b;padding:0px 0px 0px 0px;height:90px;margin:2px 0px 5px 0px"></td>
				<td style="padding:0px 5px 0px 5px;margin:0px 0px 0px 0px;margin-bottom:2px;">]]>
					<xsl:if test="xml/rs:data/z:row/@displayname">
					<![CDATA[<span style="color:#000000;font-weight:bold;font-size=100%;">]]><xsl:value-of select="xml/rs:data/z:row/@displayname"/><![CDATA[</span><br>]]>
					</xsl:if>
					<xsl:if test="xml/rs:data/z:row/@title">
					<![CDATA[<span style="color:#de007b;font-size=90%;">]]><xsl:value-of select="xml/rs:data/z:row/@title"/><![CDATA[</span><br><br>]]>
					</xsl:if>
					<xsl:if test="xml/rs:data/z:row/@telephonenumber">
					<![CDATA[<span style="color:#de007b;font-size: 80%;">]]><xsl:value-of select="xml/rs:data/z:row/@telephonenumber" /><![CDATA[</span><br>]]>
					</xsl:if>
					<xsl:if test="xml/rs:data/z:row/@mobile">
					<![CDATA[<span style="color:#de007b;font-size: 80%;">]]><xsl:value-of select="xml/rs:data/z:row/@mobile" /><![CDATA[</span><br>]]>
					</xsl:if>
					<xsl:if test="xml/rs:data/z:row/@company">
					<![CDATA[<br><span style="font-size: 80%;color:#000000;">]]><xsl:value-of select="xml/rs:data/z:row/@company" />
					</xsl:if>
					<xsl:if test="xml/rs:data/z:row/@streetaddress">
					<![CDATA[<span style="color:#de007b;"> | </span>]]><xsl:value-of select="xml/rs:data/z:row/@streetaddress" />
					</xsl:if>
					<xsl:if test="xml/rs:data/z:row/@postOfficeBox">
					<![CDATA[<span style="color:#de007b;"> | </span>]]><xsl:value-of select="xml/rs:data/z:row/@postOfficeBox" />
					</xsl:if>
					<xsl:if test="xml/rs:data/z:row/@l">
					<![CDATA[<span style="color:#de007b;"> | </span>]]><xsl:value-of select="xml/rs:data/z:row/@l" />
					</xsl:if>
					<xsl:if test="xml/rs:data/z:row/@st">
					<![CDATA[<span style="color:#de007b;"> | </span>]]><xsl:value-of select="xml/rs:data/z:row/@st" />
					</xsl:if>
					<xsl:if test="xml/rs:data/z:row/@postalcode">
					<![CDATA[<span style="color:#de007b;"> | </span>]]><xsl:value-of select="xml/rs:data/z:row/@postalcode" />
					</xsl:if>
					<![CDATA[<span style="color:#de007b;"> | +44 207 225 9119</span><br>
					<table style="padding:0px 0px 0px 0px;margin:0px 5px 0px 5px;width:100%;">
					<tr>
					<td style="vertical-align:middle;">
					]]>
					<xsl:if test="xml/rs:data/z:row/@wWWHomePage">
					<![CDATA[<a style="text-decoration:none;color:#de007b;" href="https://]]><xsl:value-of select="xml/rs:data/z:row/@wWWHomePage" /><![CDATA[" target="_new"><img style="padding-right:5px;" src="link.png" alt="visit us online">]]><xsl:value-of select="xml/rs:data/z:row/@company" />
					<![CDATA[</a>]]>
					</xsl:if>					
					</td>
					<td style="vertical-align:middle;">
					<a style="text-decoration:none;color:#de007b;" href="https://www.linkedin.com/company/123" target="_new">
					<img style="padding-right:5px;" src="linkedin.png" alt="visit us online">LinkedIn</a>
					</td>
					</tr>
					</table>
				</td>
			</tr>
			<tr><td colspan="3" style="border-bottom:4px solid #de007b;"></td></tr> 
		</table>
	</body>
</html>]]>
</xsl:template>

</xsl:stylesheet> 