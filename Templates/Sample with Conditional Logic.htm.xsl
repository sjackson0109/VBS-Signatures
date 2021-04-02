<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rs="urn:schemas-microsoft-com:rowset" xmlns:z="#RowsetSchema" version="1.0" exclude-result-prefixes="rs z">
   <xsl:output method="text" indent="yes" />
   <xsl:template match="/">
      <![CDATA[<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en" xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">
	<head>
		<title>Email Signature</title>
		<meta name="description" content="Email Signatures">
      <meta name="comments" content="If you don't use a HTML and HEADER tags, as well as the BODY tag, then your META 
      related format-detection, CSS stypes and body styling will not apply possibly breaking your email alignment etc. However,
      By adding these HTML header,a nd a new BODY, sometimes email-thread replies don't fully interpret the end of the mail-reply. 
      If this happens, re-validate your HTML code after performing an XML transform of your AD user object.">
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
				<td style="padding:0px 0px 0px 0px;margin:0px 0px 0px 0px;white-space:nowrap;word-break:break-all;">]]>
      <xsl:if test="xml/rs:data/z:row/@displayname">
         <![CDATA[<span style="font-weight:bold;">]]>
         <xsl:value-of select="xml/rs:data/z:row/@displayname" />
         <![CDATA[</span><br>]]>
      </xsl:if>
      <xsl:if test="xml/rs:data/z:row/@title">
         <xsl:value-of select="xml/rs:data/z:row/@title" />
         <![CDATA[<br>]]>
      </xsl:if>
      <![CDATA[</td>
			</tr>
			<tr>
				<td style="padding:1px 0px 0px 0px;margin:0px 0px 0px 0px;">
					<!-- <img class="logo" src="logo_2.png" alt="COMPANY NAME" width="110" height="20" style="width:110px;height:20px;"> -->
					<span style="letter-spacing:0.3pt;">COMPANY NAME GOES HERE</span>
				</td>
			
			</tr>
			<tr>
				<td  style="padding:12px 0px 0px 0px;margin:0px 0px 0px 0px;">]]>
      <xsl:if test="xml/rs:data/z:row/@streetaddress">
         <xsl:value-of select="xml/rs:data/z:row/@streetaddress" />
      </xsl:if>
      <xsl:if test="xml/rs:data/z:row/@postOfficeBox">
         <![CDATA[|]]>
         <xsl:value-of select="xml/rs:data/z:row/@postOfficeBox" />
      </xsl:if>
      <xsl:if test="xml/rs:data/z:row/@l">
         <![CDATA[<br>]]>
         <xsl:value-of select="xml/rs:data/z:row/@l" />
      </xsl:if>
      <xsl:if test="xml/rs:data/z:row/@st">
         <![CDATA[| >]]>
         <xsl:value-of select="xml/rs:data/z:row/@st" />
      </xsl:if>
      <xsl:if test="xml/rs:data/z:row/@postalcode">
         <![CDATA[|]]>
         <xsl:value-of select="xml/rs:data/z:row/@postalcode" />
      </xsl:if>
      <![CDATA[<br>]]>
      <xsl:choose>
         <xsl:when test="xml/rs:data/z:row/@displayname = 'Luke Skywalker'">
            <![CDATA[Force-Switchboard: +44 211 211 2112<br>]]>
            <xsl:if test="xml/rs:data/z:row/@telephonenumber">
               <![CDATA[<span style="color:#1f4e79;font-size:11pt;">Hoth:]]>
               <xsl:value-of select="xml/rs:data/z:row/@telephonenumber" />
               <![CDATA[</span><br>]]>
            </xsl:if>
         </xsl:when>
         <xsl:otherwise>
            <![CDATA[Switchboard: +44 +44 223 223 2332<br>]]>
            <xsl:if test="xml/rs:data/z:row/@telephonenumber">
               <![CDATA[Jedi Council:]]>
               <xsl:value-of select="xml/rs:data/z:row/@telephonenumber" />
               <![CDATA[<br>]]>
            </xsl:if>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="xml/rs:data/z:row/@homephone">
         <![CDATA[<span style="color:#1f4e79;font-size:11pt;">Tattoonie:]]>
         <xsl:value-of select="xml/rs:data/z:row/@homephone" />
         <![CDATA[</span><br>]]>
      </xsl:if>
      <xsl:if test="xml/rs:data/z:row/@mobile">
         <![CDATA[Mobile:]]>
         <xsl:value-of select="xml/rs:data/z:row/@mobile" />
         <![CDATA[<br>]]>
      </xsl:if>
      <xsl:if test="xml/rs:data/z:row/@mail">
         <![CDATA[<a style="text-decoration:underline;color:black;" href="mailto:]]>
         <xsl:value-of select="translate(xml/rs:data/z:row/@mail, 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')" />
         <![CDATA[" target="_new">]]>
         <xsl:value-of select="translate(xml/rs:data/z:row/@mail, 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')" />
         <![CDATA[</a><br>]]>
      </xsl:if>
      <xsl:choose>
         <xsl:when test="xml/rs:data/z:row/@wWWHomePage">
            <![CDATA[<span style="color:#009cb9;"><a style="text-decoration:underline;color:#009cb9;" href="]]>
            <xsl:value-of select="xml/rs:data/z:row/@wWWHomePage" />
            <![CDATA[" target="_new">]]>
            <xsl:value-of select="xml/rs:data/z:row/@wWWHomePage" />
            <![CDATA[</a></span>]]>
         </xsl:when>
         <xsl:otherwise><![CDATA[<span style="color:#009cb9;"><a style="text-decoration:underline;color:#009cb9;" href="http://starwars.com" target="_new">starwars.com</a></span>]]></xsl:otherwise>
      </xsl:choose>
      <![CDATA[</td>
		</tr>]]>
      <xsl:if test="xml/rs:data/z:row/@displayname = 'DARTH VADER'"><![CDATA[<tr><br>
			<td style="padding:0px 0px 0px 0px;margin:0px 0px 0px 0px;white-space:nowrap;word-break:break-all;">
			Alignment: The Dark Side<br>
			Contact: Use the force<br>
			Email: <a style="text-decoration:underline;color:black;" href="mailto:vader@deathstar.com">vader@deathstar.com</a>
			</td>
			</tr>]]></xsl:if>
      <![CDATA[</table>
	  <br>
   </body>
</html>]]>
   </xsl:template>
</xsl:stylesheet>