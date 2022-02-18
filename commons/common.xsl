<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0" xmlns="http://www.loc.gov/mods/v3"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:ce="http://www.elsevier.com/xml/common/schema"
    exclude-result-prefixes="xs xd">

    <xd:doc>
        <xd:desc>
            <xd:p>Fixes for super-and-subscript in content/</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="sub | subscript | inf | ce:sub | ce:inf">
        <xsl:value-of
            select="
                translate(.,
                '0123456789+-−=()aehijklmnoprstuvxəβγρφχ',
                '₀₁₂₃₄₅₆₇₈₉₊₋₋₌₍₎ₐₑₕᵢⱼₖₗₘₙₒₚᵣₛₜᵤᵥₓₔᵦᵧᵨᵩᵪ')"
        />
    </xsl:template>

    <xsl:template match="sup | superscript | ce:sup">
        <xsl:value-of
            select="
                translate(.,
                '0123456789+-−=()abcdefghijklmnoprstuvwxyzABDEGHIJKLMNOPRTUVWαβγδεθɩφχ',
                '⁰¹²³⁴⁵⁶⁷⁸⁹⁺⁻⁻⁼⁽⁾ᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖʳˢᵗᵘᵛʷˣʸᶻᴬᴮᴰᴱᴳᴴᴵᴶᴷᴸᴹᴺᴼᴾᴿᵀᵁⱽᵂᵅᵝᵞᵟᵋᶿᶥᵠᵡ')"
        />
    </xsl:template>


    <xd:doc>
        <xd:desc>
            <xd:p>Add a space at the end of content within paragraph tags.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="p">
        <xsl:variable name="this">
            <xsl:apply-templates/>
        </xsl:variable>
        <xsl:value-of select="concat($this, ' ')"/>
    </xsl:template>  
    
    <xd:doc>
        <xd:desc>
            <xd:p>The following two templates make it possible to copy elements without getting extraneous namespaces.</xd:p>
            <xd:p>Instead of using <xd:b>xsl:copy-of</xd:b>, use <xd:b>xsl:apply-templates mode="copy-no-namespaces.</xd:b></xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:template match="*" mode="copy-no-namespaces">
        <xsl:element name="{local-name()}">
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="node()" mode="copy-no-namespaces"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="comment()| processing-instruction()" mode="copy-no-namespaces">
        <xsl:copy/>
    </xsl:template>

</xsl:stylesheet>
