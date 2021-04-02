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
		<table style="width:600px;border:0px solid black;color:#ff3399;font-family:Arial;font-size:12pt;padding:0px 0px 0px 0px;margin:0px 0px 0px 0px;border:none;border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt;" width="600">
			<tr>
				<td align="left" ]]>
					<xsl:if test="xml/rs:data/z:row/@displayname">
						<![CDATA[<p style="font-weight:bold;">]]><xsl:value-of select="xml/rs:data/z:row/@displayname"/><![CDATA[</p>]]>
					</xsl:if>
					<xsl:if test="xml/rs:data/z:row/@title">
						<![CDATA[<p>]]><xsl:value-of select="xml/rs:data/z:row/@title"/><![CDATA[</p>]]>
					</xsl:if>
						<![CDATA[					
				</td>
			</tr>
			<tr>
				<td width="100%" style="text-align:center;">
					<p>
					<br>
					<img style="display:block;margin-left:auto;margin-right:auto;width:50%;" src="logo-1.jpg" alt="]]><xsl:value-of select="xml/rs:data/z:row/@company"/><![CDATA[">
					<br><br>
					</p>
				</td>
			</tr>
			<tr>
				<td style="color:#1f497d;font-family:Arial;font-size:10pt;align:center;text-transform:uppercase;" align="center">
				<p>THE EXECUTIVE OFFICES
				]]>	<xsl:if test="xml/rs:data/z:row/@streetaddress">
					<![CDATA[ &bull; ]]><xsl:value-of select="translate(xml/rs:data/z:row/@streetaddress, 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ', 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ')" />
					</xsl:if>
					<xsl:if test="xml/rs:data/z:row/@postOfficeBox">
					<![CDATA[ &bull; ]]><xsl:value-of select="translate(xml/rs:data/z:row/@postOfficeBox, 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ', 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ')" />
					</xsl:if>
					<xsl:if test="xml/rs:data/z:row/@l">
					<![CDATA[</p><p>]]><xsl:value-of select="translate(xml/rs:data/z:row/@l, 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ', 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ')" />
					</xsl:if>
					<xsl:if test="xml/rs:data/z:row/@st">
					<![CDATA[ &bull; ]]><xsl:value-of select="translate(xml/rs:data/z:row/@st, 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ', 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ')" />
					</xsl:if>
					<xsl:if test="xml/rs:data/z:row/@postalcode">
					<![CDATA[ &bull; ]]><xsl:value-of select="translate(xml/rs:data/z:row/@postalcode, 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ', 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ')" />
					</xsl:if>
					
		  <xsl:choose>
			<xsl:when test="xml/rs:data/z:row/@telephonenumber"> 
				<xsl:choose>
					<xsl:when test="xml/rs:data/z:row/@mobile">
						<![CDATA[ &bull; TEL: ]]><xsl:value-of select="xml/rs:data/z:row/@telephonenumber" /><![CDATA[ &bull; MOB: ]]><xsl:value-of select="xml/rs:data/z:row/@mobile" />
					</xsl:when>
					<xsl:otherwise>
						<![CDATA[ &bull; TEL: ]]><xsl:value-of select="xml/rs:data/z:row/@telephonenumber" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
			  <xsl:if test="xml/rs:data/z:row/@mobile">
				<![CDATA[ &bull; MOB: ]]><xsl:value-of select="xml/rs:data/z:row/@mobile" />
			  </xsl:if>
			</xsl:otherwise>
		  </xsl:choose>
<![CDATA[			</p>
					<br>
				</td>
			</tr>
			<tr>
				<td style="color:#1f497d;font-family:Arial;font-size:10pt;align:center;" align="center">
				<a style="text-decoration:underline;color:#0000ff;font-family:Arial;font-size:10pt;" href="http://www.dcch.co.uk" target="_new">www.dcch.co.uk</a></td>
			</tr>
		</table>
	</body>
</html>]]>
</xsl:template>

</xsl:stylesheet> 