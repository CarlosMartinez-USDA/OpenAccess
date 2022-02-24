<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <xsl:    
    <xsl:param name="publisher-licensing-info"/>
    <xsl:variable name="licenseURL" select="/doc:document/rdf:RDF/rdf:Description/oa:openAccessInformation/oa:userLicense"/>      
    <xsl:variable name="startDate" select="/doc:document/rdf:RDF/rdf:Description/oa:openAccessInformation/oa:openAccessEffective"/>
    <xsl:variable name="getVersion" select="tokenize($licenseURL, '/')[.][last()]"/>
    
   
    <xsl:template name="accessConditions">
        <xsl:analyze-string select="normalize-space(.)" regex="(.* CC BY license\.)|(.*CC BY)(\-[A-Z]+)(\slicense\.)|(.*CC BY)(\-[A-Z]+?\-[A-Z]+)(\slicense\.)|(.*)(CC0)(\slicense\.$)">
            <xsl:matching-substring>
                <!--Creative Commons Licenses-->
                <accessCondition type="use and reproduction">
                    <xsl:attribute name="displayLabel">
                        <xsl:choose>
                            <!--CC BY-->
                            <xsl:when test="regex-group(1)">
                                <xsl:value-of select="concat('Creative Commons Attribution&#160;', $getVersion, '&#160;','Generic (CC BY ', $getVersion,')')"/>
                            </xsl:when>
                            <!--CC BY-SA, CC BY-NC, CC BY-ND--> 
                            <xsl:when test="regex-group(2) and regex-group(3) and regex-group(4)">
                                <xsl:value-of select="concat('Creative Commons Attribution&#160;', $getVersion, '&#160;', 'Generic (CC BY',regex-group(3),'&#160;' ,$getVersion,')')"/>
                            </xsl:when>
                            <!--CC BY-SA-ND, CC BY-NC-ND-->
                            <xsl:when test="regex-group(5) and regex-group(6) and regex-group(7)">
                                <xsl:value-of select="concat('Creative Commons Attribution&#160;', $getVersion, '&#160;', 'Generic (CC BY',regex-group(6),'&#160;' ,$getVersion,')')"/>
                            </xsl:when>
                            <!--CC0-->
                            <xsl:when test="regex-group(8) and regex-group(9) and regex-group(10)">
                                <xsl:value-of select="concat('Creative Commons Attribution&#160;', $getVersion, '&#160;', 'Generic (',regex-group(9),')')"/>    
                            </xsl:when>
                            <!--Default CC BY license (most common)-->
                            <xsl:otherwise>
                                <xsl:value-of select="concat('Creative Commons Attribution&#160;', $getVersion, '&#160;','Generic (CC BY ', $getVersion,')')"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    <program xmlns="https://data.crossref.org/schemas/AccessIndicators.xsd">
                        <licence_ref>
                            <xsl:attribute name="applies_to">reuse</xsl:attribute>
                            <xsl:attribute name="start_date" select="substring-before($startDate, 'T')"/>
                        </licence_ref>
                        <licence_ref>                           
                            <xsl:value-of select="$licenseURL"/>
                        </licence_ref>
                    </program>
                </accessCondition>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <!-- NAL Generic Open Access. -->
                <accessCondition type="use and reproduction" displayLabel="Resource is Open Access">	
                    <program xmlns="https://data.crossref.org/schemas/AccessIndicators.xsd">                	
                        <license_ref>http://purl.org/eprint/accessRights/OpenAccess</license_ref>                	
                    </program>	
                </accessCondition>	
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
</xsl:stylesheet>