<?xml version='1.0' encoding='utf-8'?>
 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rs="urn:schemas-microsoft-com:rowset" xmlns:z="#RowsetSchema" exclude-result-prefixes="rs z">
<xsl:output method = "text" indent = "yes"/>
 
<xsl:template match="/">
<xsl:if test="xml/rs:data/z:row/@displayname">
<xsl:value-of select="xml/rs:data/z:row/@displayname"/><![CDATA[
]]>
</xsl:if>
<xsl:if test="xml/rs:data/z:row/@title">
<xsl:value-of select="xml/rs:data/z:row/@title"/><![CDATA[
]]>
</xsl:if>  
<![CDATA[City and General
]]>
<![CDATA[
]]>
<xsl:if test="xml/rs:data/z:row/@streetaddress">
<xsl:value-of select="xml/rs:data/z:row/@streetaddress" />
</xsl:if>
<xsl:if test="xml/rs:data/z:row/@postOfficeBox">
<![CDATA[, ]]><xsl:value-of select="xml/rs:data/z:row/@postOfficeBox" />
</xsl:if>
<![CDATA[
]]>
<xsl:if test="xml/rs:data/z:row/@l">
<![CDATA[]]><xsl:value-of select="xml/rs:data/z:row/@l" />
</xsl:if>
<xsl:if test="xml/rs:data/z:row/@st">
<![CDATA[, ]]><xsl:value-of select="xml/rs:data/z:row/@st" />
</xsl:if>
<xsl:if test="xml/rs:data/z:row/@postalcode">
<![CDATA[, ]]><xsl:value-of select="xml/rs:data/z:row/@postalcode" /><![CDATA[
]]>
</xsl:if>
<xsl:if test="xml/rs:data/z:row/@telephonenumber">
<![CDATA[Tel: ]]><xsl:value-of select="xml/rs:data/z:row/@telephonenumber" /><![CDATA[
]]>
</xsl:if>
<xsl:if test="xml/rs:data/z:row/@mobile">
<![CDATA[Mob: ]]><xsl:value-of select="xml/rs:data/z:row/@mobile" /><![CDATA[
]]>
</xsl:if>
<xsl:if test="xml/rs:data/z:row/@mail"> 
<xsl:value-of select="translate(xml/rs:data/z:row/@mail, 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')" /><![CDATA[
]]>
</xsl:if>
<![CDATA[www.marcol.com]]>
</xsl:template>
</xsl:stylesheet> 