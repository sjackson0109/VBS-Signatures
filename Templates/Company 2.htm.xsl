<?xml version='1.0' encoding='utf-8'?>
 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rs="urn:schemas-microsoft-com:rowset" xmlns:z="#RowsetSchema" exclude-result-prefixes="rs z">
<xsl:output method = "text" indent = "yes"/>
 
<xsl:template match="/">
<![CDATA[<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
	<head>
		<title>Email Signature</title>
		<meta name="description" content="Email Signatures">
		<meta name="keywords" content="HTML,INLINE-STYLING,XML-TRANSFORMS">
		<meta name="author" content="admin@jacksonfamily.me">
		<meta name="format-detection" content="telephone=no,date=no,address=no,email=no,url=no">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<style>
			table tbody tr td {  white-space: nowrap; -webkit-text-size-adjust: none}
		</style>
	</head>	
	<body style="font-family:sans-serif;">
		<table style="color:#7a7a7a;padding:0px 5px 0px 5px;margin:0px 0px 0px 0px;width:600px;white-space:nowrap;">
			<tr>
				<td style="padding:0px 5px 0px 5px;margin:0px 0px 0px 0px;width:110px;">
					<img src="company-3.jpg" alt="]]><xsl:value-of select="xml/rs:data/z:row/@title"/><![CDATA[" width="100px" height="100px">
				</td>
				<td style="padding:0px 5px 0px 5px;margin:0px 0px 0px 0px;margin-bottom:2px;font-size=100%;min-width:490px;word-break:normal;border-collapse:collapse !important;">
				
				]]>
					<xsl:if test="xml/rs:data/z:row/@displayname">
					<![CDATA[<span style="font-weight:bold;color:black;">]]><xsl:value-of select="xml/rs:data/z:row/@displayname"/><![CDATA[</span>]]>
					</xsl:if>
					<xsl:if test="xml/rs:data/z:row/@title">
					<![CDATA[ | ]]><xsl:value-of select="xml/rs:data/z:row/@title"/>
					</xsl:if>
					<xsl:choose>
					  <xsl:when test="xml/rs:data/z:row/@telephonenumber" >
							<xsl:choose>
							  <xsl:when test="xml/rs:data/z:row/@mobile" >
								<![CDATA[<br><span style="white-space: nowrap;">]]><xsl:value-of select="xml/rs:data/z:row/@telephonenumber" />
								<![CDATA[ | ]]><xsl:value-of select="xml/rs:data/z:row/@mobile" />
							  </xsl:when>
							  <xsl:otherwise>
								<![CDATA[ | ]]><xsl:value-of select="xml/rs:data/z:row/@telephonenumber" />
							  </xsl:otherwise>
							</xsl:choose>
					  </xsl:when>
					  <xsl:otherwise>
							<xsl:choose>
							  <xsl:when test="xml/rs:data/z:row/@mobile" >
								<![CDATA[<br>]]><xsl:value-of select="xml/rs:data/z:row/@mobile" />
							  </xsl:when>
							  <xsl:otherwise>
							  </xsl:otherwise>
							</xsl:choose>
					  </xsl:otherwise>
					</xsl:choose>
					<![CDATA[<br>
					<span style="white-space:nowrap;">TYPE YOUR FULL OFFICE ADDRESS HERE, OR USE THE LDAP VARIABLES TO AUTO-POPULATE THEM (MORE AD DATA MAINTENANCE)</span><br>
					<xsl:if test="xml/rs:data/z:row/@wWWHomePage">
					<![CDATA[<a style="text-decoration:none;color:#de007b;" href="https://]]><xsl:value-of select="xml/rs:data/z:row/@wWWHomePage" /><![CDATA[" target="_new"><img style="padding-right:5px;" src="link.png" alt="visit us online">]]><xsl:value-of select="xml/rs:data/z:row/@company" />
					<![CDATA[</a>]]>
					</xsl:if> | A XXXX Company
				</td>
			</tr>
		</table>
	</body>
</html>]]>
</xsl:template>

</xsl:stylesheet> 