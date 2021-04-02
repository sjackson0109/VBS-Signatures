<?xml version='1.0' encoding='utf-8'?>
 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rs="urn:schemas-microsoft-com:rowset" xmlns:z="#RowsetSchema" exclude-result-prefixes="rs z">
<xsl:output method = "text" indent = "yes"/>
 
<xsl:template match="/">
<![CDATA[{\rtf1\ansi\ansicpg1252\deff0\deflang2057{\fonttbl{\f0\fnil\fcharset0 Calibri;}}
\viewkind4\uc1\pard\sa200\sl276\slmult1\lang9\f0\fs22\par
]]>
<xsl:value-of select="xml/rs:data/z:row/@displayname"/>
<![CDATA[\par
}
]]>
</xsl:template>

</xsl:stylesheet> 