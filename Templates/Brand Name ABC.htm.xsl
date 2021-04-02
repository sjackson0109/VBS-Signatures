<?xml version='1.0' encoding='utf-8'?>
 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rs="urn:schemas-microsoft-com:rowset" xmlns:z="#RowsetSchema" exclude-result-prefixes="rs z">
<xsl:output method = "text" indent = "yes"/>
 
<xsl:template match="/">
<![CDATA[<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en" xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">
	<head>
		<title>Email Signature</title>
		<meta name="description" content="Email Signatures">
		<meta name="keywords" content="HTML,INLINE-STYLING,XML-TRANSFORMS">
		<meta name="author" content="admin@jacksonfamily.me">
		<meta name="format-detection" content="telephone=no,date=no,address=no,email=no,url=no">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<style type="text/css">
		body
			{font-size:11pt;font-family:Arial;link:gray;vlink:gray;hlink:gray;}
		p
			{color:black;font-family:Arial;align:left;margin-left:0pt;
			margin-right:0pt;text-indent:0pt;margin-top:0.01pt;margin-bottom:1.01pt;}
		</style>
	</head>
	<body>
		<table style="padding:0px 0px 0px 0px;margin:0px 0px 0px 0px;border:none;border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt;width:400px;" cellpadding="0" cellspacing="0">
			<tr>
				<td style="padding:0px 0px 0px 0px;margin:0px 0px 0px 0px;white-space:nowrap;word-break:break-all;">
]]>

	
				<xsl:if test="xml/rs:data/z:row/@displayname">
<![CDATA[			<span style="font-weight:bold;">]]><xsl:value-of select="xml/rs:data/z:row/@displayname"/><![CDATA[</span><br>
]]>
				</xsl:if>
				
				<xsl:if test="xml/rs:data/z:row/@title"><xsl:value-of select="xml/rs:data/z:row/@title"/>
<![CDATA[<br>
]]>
				</xsl:if>
<![CDATA[
				</td>
			</tr>
			<tr>
				<td style="padding:1px 0px 0px 0px;margin:0px 0px 0px 0px;">
					<!-- <img class="logo" src="marcol_logo_black.png" alt="MARCOL" width="110" height="20" style="width:110px;height:20px;"> -->
					<span style="letter-spacing:0.3pt;">City and General</span>
				</td>
			
			</tr>
			<tr>
				<td  style="padding:12px 0px 0px 0px;margin:0px 0px 0px 0px;">
				]]>
				<xsl:if test="xml/rs:data/z:row/@streetaddress">
					<xsl:value-of select="xml/rs:data/z:row/@streetaddress" />
				</xsl:if>
				<xsl:if test="xml/rs:data/z:row/@postOfficeBox">
				<![CDATA[ | ]]><xsl:value-of select="xml/rs:data/z:row/@postOfficeBox" />
				</xsl:if>
				<xsl:if test="xml/rs:data/z:row/@l">
				<![CDATA[<br>]]><xsl:value-of select="xml/rs:data/z:row/@l" />
				</xsl:if>
				<xsl:if test="xml/rs:data/z:row/@st">
				<![CDATA[ | >]]><xsl:value-of select="xml/rs:data/z:row/@st" />
				</xsl:if>
				<xsl:if test="xml/rs:data/z:row/@postalcode">
				<![CDATA[ | ]]><xsl:value-of select="xml/rs:data/z:row/@postalcode" />
				</xsl:if>
<![CDATA[		<br>
]]>
		  <xsl:choose>
			<xsl:when test="xml/rs:data/z:row/@samaccountname = 'Edward.WatkinsWright'"> 
				<![CDATA[MARCOL Switchboard: +44 207 402 0402<br>]]>
			  <xsl:if test="xml/rs:data/z:row/@telephonenumber">
					<![CDATA[<span style="color:#1f4e79;font-size:11pt;">MARCOL Direct Line: ]]><xsl:value-of select="xml/rs:data/z:row/@telephonenumber" /><![CDATA[</span><br>
					]]>
			  </xsl:if>
				<![CDATA[Chelsea Harbour Switchboard: +44 207 225 9100<br>]]>
			  <xsl:if test="xml/rs:data/z:row/@homephone">
					<![CDATA[<span style="color:#1f4e79;font-size:11pt;">Chelsea Harbour Direct Line: ]]><xsl:value-of select="xml/rs:data/z:row/@homephone" /><![CDATA[</span><br>
					]]>
			  </xsl:if>
			</xsl:when>
			<xsl:otherwise>
			  <![CDATA[Switchboard: +44 207 402 0402<br>]]>
			  <xsl:if test="xml/rs:data/z:row/@telephonenumber">
			    <![CDATA[Direct Line: ]]><xsl:value-of select="xml/rs:data/z:row/@telephonenumber" /><![CDATA[<br>
			    ]]>
			  </xsl:if>
			</xsl:otherwise>
		  </xsl:choose>
		  <xsl:if test="xml/rs:data/z:row/@mobile">
			  <![CDATA[Mobile: ]]><xsl:value-of select="xml/rs:data/z:row/@mobile" /><![CDATA[<br>
			  ]]>
		  </xsl:if>
		  
		  <xsl:if test="xml/rs:data/z:row/@mail"> 
		  <![CDATA[<a style="text-decoration:underline;color:black;" href="mailto:]]><xsl:value-of select="translate(xml/rs:data/z:row/@mail, 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')" />
<![CDATA[" target="_new">]]><xsl:value-of select="translate(xml/rs:data/z:row/@mail, 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')" /><![CDATA[</a><br>
		  ]]>
		  </xsl:if>
			<xsl:choose>
			  <xsl:when test="xml/rs:data/z:row/@wWWHomePage"> 
			  <![CDATA[<span style="color:#009cb9;"><a style="text-decoration:underline;color:#009cb9;" href="]]><xsl:value-of select="xml/rs:data/z:row/@wWWHomePage" /><![CDATA[" target="_new">]]><xsl:value-of select="xml/rs:data/z:row/@wWWHomePage" /><![CDATA[</a></span>
			  ]]>
			  </xsl:when>
			  <xsl:otherwise>
			  <![CDATA[<span style="color:#009cb9;"><a style="text-decoration:underline;color:#009cb9;" href="http://marcol.com" target="_new">www.marcol.com</a></span>]]>
			  </xsl:otherwise>
			</xsl:choose>
		  <![CDATA[
			</td>
		</tr>
		</table>
	  <br>
   </body>
</html>]]>
</xsl:template>
</xsl:stylesheet>