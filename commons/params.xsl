<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0" xmlns="http://www.loc.gov/mods/v3"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:saxon="http://saxon.sf.net/"
    exclude-result-prefixes="xs xd saxon xlink">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Jun 19, 2017</xd:p>
            <xd:p><xd:b>Author:</xd:b> rdonahue</xd:p>
            <xd:p>Pulled out in June 2017 as part of the refactoring project</xd:p>
        </xd:desc>
    </xd:doc>
        
    <xd:doc>
        <xd:desc>
            <xd:p>Name of source vendor and filename being processed.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:param name="vendorName"/>
    <xsl:param name="archiveFile"/>
    <xsl:param name="originalFilename" select="saxon:system-id()"/>
    <xsl:param name="workingDir"/>
</xsl:stylesheet>
