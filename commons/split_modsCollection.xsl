<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.loc.gov/mods/v3"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    exclude-result-prefixes="xs xd"
    version="2.0">
    <xsl:include href="../fix_characters.xsl"/>
    <xsl:include href="params.xsl"/>
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Sep 12, 2017</xd:p>
            <xd:p><xd:b>Original author:</xd:b> Rachel Donahue</xd:p>
            <xd:p><xd:b>Modified on:</xd:b> October 18, 2018</xd:p>
            <xd:p><xd:b>Modified by:</xd:b>Emily Somach</xd:p>
            <xd:p>Splits a modsCollection file into individual MODS files; also runs fix_characters.xsl</xd:p>
            <xd:p>Assigns a priority of "5" to the root template so as to avoid an ambiguous match warning</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:template match="/" priority="5">
        <xsl:for-each select="modsCollection/mods">
            <xsl:result-document method="xml" encoding="UTF-8" indent="yes" href="{*:extension/*:workingDirectory}N-{replace(*:extension/*:originalFile, '(.*/)(.*)(\.xml)', '$2')}_{position()}.xml">
            <mods version="3.7">
                <xsl:namespace name="xlink">http://www.w3.org/1999/xlink</xsl:namespace>
                <xsl:namespace name="xsi">http://www.w3.org/2001/XMLSchema-instance</xsl:namespace>
                <xsl:attribute name="xsi:schemaLocation">http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-7.xsd</xsl:attribute>
                <xsl:apply-templates/>
            </mods>
        </xsl:result-document>
        </xsl:for-each>
    </xsl:template>    

</xsl:stylesheet>