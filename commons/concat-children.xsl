<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    exclude-result-prefixes="xs fn"
    version="2.0">
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    
    <!--From https://www.oxygenxml.com/archives/xsl-list/200503/msg01219.html-->
    <xsl:template name="clean-concat-with-comma">
        <xsl:variable name="this">
            <xsl:call-template name="join-them"/>
        </xsl:variable>
        <xsl:variable name="this"><xsl:value-of select="$this"/></xsl:variable>
        <xsl:variable name="this" select="fn:replace( $this, '(,){2,}', ',')" as="xs:string"/>
        <xsl:variable name="this" select="fn:replace( $this, '(, ){2,}', ', ')" as="xs:string"/>
        <xsl:variable name="this" select="fn:replace( $this, ', ; ', ', ')" as="xs:string"/>        
        <xsl:variable name="this" select="fn:replace( normalize-space($this), '(; and( ){0,},)$', '')" as="xs:string"/>
        <xsl:variable name="this" select="fn:replace( normalize-space($this), '[,.;]$', ' ')"/>
        <xsl:variable name="this" select="fn:replace( $this, 'e-mail:, ', 'e-mail: ')" as="xs:string"/>
        <xsl:variable name="this" select="fn:replace( $this, ', \.', '')" as="xs:string"/>
        
        
        
        <xsl:value-of select="normalize-space($this)"/>
        
    </xsl:template>
    
    <xsl:template name="join-them">
        <xsl:variable name="concatted">
            <xsl:apply-templates mode="text-and-children"/>
        </xsl:variable>
        
        <xsl:value-of select="$concatted"/>
    </xsl:template>
    
    <xsl:template match="
        text()[preceding-sibling::node() and
        following-sibling::node()]" mode="text-and-children">
        <xsl:variable name="ns" select="normalize-space(concat('x', ., 'x'))"/>
        <xsl:value-of select="normalize-space(substring($ns, 2, string-length($ns) - 2))"/>
        <xsl:text>, </xsl:text>
    </xsl:template>
    
    <xsl:template match="
        text()[preceding-sibling::node() and
        not(following-sibling::node())]" mode="text-and-children">
        <xsl:variable name="ns" select="normalize-space(concat('x', .))"/>
        <xsl:value-of select="normalize-space(substring($ns, 2, string-length($ns) - 1))"/>
        <xsl:text>, </xsl:text>
    </xsl:template>
    
    <xsl:template match="
        text()[not(preceding-sibling::node()) and
        following-sibling::node()]" mode="text-and-children">
        <xsl:variable name="ns" select="normalize-space(concat(., 'x'))"/>
        <xsl:value-of select="normalize-space(substring($ns, 1, string-length($ns) - 1))"/>
        <xsl:text>, </xsl:text>
    </xsl:template>
    
    <xsl:template match="
        text()[not(preceding-sibling::node()) and
        not(following-sibling::node())]" mode="text-and-children">
        <xsl:value-of select="normalize-space(.)"/>
        <xsl:text>, </xsl:text>
    </xsl:template>
    
</xsl:stylesheet>