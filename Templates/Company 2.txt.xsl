<?xml version='1.0' encoding='utf-8'?>
 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rs="urn:schemas-microsoft-com:rowset" xmlns:z="#RowsetSchema" exclude-result-prefixes="rs z">
<xsl:output method = "text" indent = "yes"/>
 
<xsl:template match="/">
<xsl:value-of select="xml/rs:data/z:row/@displayname"/>
<![CDATA[ | ]]><xsl:value-of select="xml/rs:data/z:row/@title"/>
<xsl:if test="xml/rs:data/z:row/@telephonenumber">
<![CDATA[ | ]]><xsl:value-of select="xml/rs:data/z:row/@telephonenumber" />
</xsl:if>
<xsl:if test="xml/rs:data/z:row/@mobile">
<![CDATA[ | ]]><xsl:value-of select="xml/rs:data/z:row/@mobile" />
</xsl:if>
<![CDATA[ | 
]]>
<![CDATA[ENTER YOUR OFFICE ADDRESS HERE
AND YOUR WEBSITE | A XXXXXX Company]]>
</xsl:template>
</xsl:stylesheet> 