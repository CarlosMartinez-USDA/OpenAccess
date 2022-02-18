<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"      
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns="http://www.loc.gov/mods/v3"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:xlink="http://www.w3.org/1999/xlink" 
    exclude-result-prefixes="fn xlink"
>
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" media-type="text/xml"/>
    <xsl:strip-space elements="*"/>
  
  <xsl:template match="/">
      <xsl:result-document method="xml" encoding="UTF-8" indent="yes" href="file:///{//*:workingDirectory}N-{replace(//*:originalFile, '(.*/)(.*)(\.xml)', '$2')}_{position()}.xml">
          <mods version="3.7">
              <xsl:namespace name="xlink">http://www.w3.org/1999/xlink</xsl:namespace>
              <xsl:namespace name="xsi">http://www.w3.org/2001/XMLSchema-instance</xsl:namespace>
              <xsl:attribute name="xsi:schemaLocation">http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-7.xsd</xsl:attribute>
              <xsl:for-each select="node()">
                  <xsl:apply-templates select="node()" />
              </xsl:for-each>
          </mods>
      </xsl:result-document>
      
  </xsl:template>


    <xsl:template match="node()|@*">
      <xsl:copy>
            <xsl:apply-templates select="node()[normalize-space()]|@*[normalize-space()]"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="text()" priority="3">
        <xsl:variable name="work" select="."/>                               <!-- HEX DUMP       -->
        
        <xsl:variable name="work" select="fn:replace( $work, 'â', '–')"/>  <!-- \xE2 \x80 \x93 -->        
        <xsl:variable name="work" select="fn:replace( $work, 'â', '‘')"/>  <!-- \xE2 \x80 \x98 -->
        <xsl:variable name="work" select="fn:replace( $work, 'â', '’')"/>  <!-- \xE2 \x80 \x99 -->
        <xsl:variable name="work" select="fn:replace( $work, 'â', '“')"/>  <!-- \xE2 \x80 \x9c -->
        <xsl:variable name="work" select="fn:replace( $work, 'â', '”')"/>  <!-- \xE2 \x80 \x9d -->
        <xsl:variable name="work" select="fn:replace( $work, 'â¢', '™')"/>  <!-- \xE2 \x84 \xA2 -->       
        <xsl:variable name="work" select="fn:replace( $work, 'â', '∙')"/>  <!-- \xE2 \x88 \x99 --> 
        <xsl:variable name="work" select="fn:replace( $work, 'â', '⌀')"/>  <!-- \xE2 \x8C \x80 --> 
        <xsl:variable name="work" select="fn:replace( $work, 'â¤', '≤')"/>  <!-- \xE2 \x89 \xA4 -->
        <xsl:variable name="work" select="fn:replace( $work, 'â€™', '’')"/>  <!-- source issue   -->        
        <xsl:variable name="work" select="fn:replace( $work, 'â„ƒ', '?')"/>  <!-- source issue   -->
        <xsl:variable name="work" select="fn:replace( $work, 'â¥', '≥')"/>  <!-- source issue   -->
        <xsl:variable name="work" select="fn:replace( $work, 'â¢', '.')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'â²', '′')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'â', '≈')"/>        
        <xsl:variable name="work" select="fn:replace( $work, 'â†', 'Δ')"/>
        
        <xsl:variable name="work" select="fn:replace( $work, 'â&#x88;&#x86;', 'Δ')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'â&#x88;&#x9a;', 'V')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'â&#x82;&#x83;', '₃')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'â&#x81;»', '⁻')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'â&#x80;&#x94;', '—')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'â&#x82;¬', '€')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'â&#x81;µ', '⁵')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'â&#x82;&#x82;', '₂')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'â&#x88;&#x92;', '−')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'â&#x81;º', '+')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'â&#x82;&#x84;', '₄')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'â&#x81;¶', '⁶')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'â&#x81;´', '⁴')"/>
        
        <xsl:variable name="work" select="fn:replace( $work, 'â&#x99;&#x80;', '♀')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'â&#x99;&#x82;', '♂')"/>



        <xsl:variable name="work" select="fn:replace( $work, 'Â°', '°')"/>  <!-- \xC2 \xB0 -->
        <xsl:variable name="work" select="fn:replace( $work, 'Â®', '®')"/>  <!-- \xC2 \xAE -->
        <xsl:variable name="work" select="fn:replace( $work, 'Â¬', '¬')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'Â­', '­')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'Â»', '»')"/>
        
        
        <xsl:variable name="work" select="fn:replace( $work, 'Ã©', 'é')"/>  <!-- \xC3 \x81 -->
        <xsl:variable name="work" select="fn:replace( $work, 'Ã³', 'ó')"/>  <!-- \xC3 \xB3 -->
        <xsl:variable name="work" select="fn:replace( $work, 'Ã', '×')"/>  <!-- \xC3 \x97 -->        
        <xsl:variable name="work" select="fn:replace( $work, 'Ã¡', 'á')"/>  <!-- \xC3 \xA1 -->
        <xsl:variable name="work" select="fn:replace( $work, 'Ã­', 'í')"/> 
        <xsl:variable name="work" select="fn:replace( $work, 'Ã±', 'ñ')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'Ã§', 'ç')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'Ã£', 'ã')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'Ã', 'É')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'Ãª', 'ê')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'Ã¢', 'â')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'Ã¤', 'ä')"/>        
        <xsl:variable name="work" select="fn:replace( $work, 'Ã¶', 'ö')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'Ã«', 'ë')"/>        
        <xsl:variable name="work" select="fn:replace( $work, 'Ã½', 'ý')"/>        
        <xsl:variable name="work" select="fn:replace( $work, 'ÃŸ', '.')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'Ã·', '÷')"/>        
        <xsl:variable name="work" select="fn:replace( $work, 'Ã—', '—')"/> <!-- fix source issue -->
        <xsl:variable name="work" select="fn:replace( $work, 'Ã-', '-')"/> <!-- fix source issue -->
        <xsl:variable name="work" select="fn:replace( $work, 'Ã´', '´')"/> <!-- fix source issue -->
        <xsl:variable name="work" select="fn:replace( $work, 'Ã¨', 'è')"/> <!--  -->
        <xsl:variable name="work" select="fn:replace( $work, 'Ãº', 'ú')"/> <!--  -->
        <xsl:variable name="work" select="fn:replace( $work, 'Ã¼', 'ü')"/> <!--  -->
        <xsl:variable name="work" select="fn:replace( $work, 'Ã ', 'à')"/> <!--  -->
        <xsl:variable name="work" select="fn:replace( $work, 'Ã¯', 'ï')"/> <!--  -->
        <xsl:variable name="work" select="fn:replace( $work, 'Ã¥', 'å')"/> <!--  -->
        <xsl:variable name="work" select="fn:replace( $work, 'Ã¸', 'ø')"/> <!--  -->
        <xsl:variable name="work" select="fn:replace( $work, 'Ã&#x87;', 'Ç')"/> <!--  -->
        
        
        
        <xsl:variable name="work" select="fn:replace( $work, 'Ä±', 'ı')"/>  <!-- \xC4 \xB1 -->       
        <xsl:variable name="work" select="fn:replace( $work, 'Ä', 'ć')"/>  <!-- \xC4 \x87 -->
        <xsl:variable name="work" select="fn:replace( $work, 'Ä', 'ą')"/>  <!-- \xC4 \x85 -->
        <xsl:variable name="work" select="fn:replace( $work, 'Ä&#x90;', 'Đ')"/>  <!-- \xC4 \x90 -->
        <xsl:variable name="work" select="fn:replace( $work, 'Ä;', 'Đ')"/>  <!-- \xC4 \x90 -->
        <xsl:variable name="work" select="fn:replace( $work, 'Ä°', 'İ')"/>
        
        
        <xsl:variable name="work" select="fn:replace( $work, 'Å', 'ł')"/>  <!-- \xC5 \x82 -->
        <xsl:variable name="work" select="fn:replace( $work, 'Å', 'ņ')"/>  <!-- \xC5 \x86 -->
        <xsl:variable name="work" select="fn:replace( $work, 'Å', 'ş')"/>  <!-- \xC5 \x9F -->
        <xsl:variable name="work" select="fn:replace( $work, 'Å', 'Ş')"/>  <!-- \xC5 \x9E -->
        <xsl:variable name="work" select="fn:replace( $work, 'Å‘', 'ő')"/>  <!-- \xC5      -->        
        <xsl:variable name="work" select="fn:replace( $work, 'Å&#x91;', 'ő')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'Å¡', 'š')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'Å&#x93;', 'œ')"/>
        
        
        <xsl:variable name="work" select="fn:replace( $work, 'Ã&#x9f;', '.')"/>
 
        <xsl:variable name="work" select="fn:replace( $work, 'Î¼', 'μ')"/>  <!-- \xCE \xBC -->       
        <xsl:variable name="work" select="fn:replace( $work, 'Î¨', 'Ψ')"/>  <!-- \xCE \xA8 -->
        <xsl:variable name="work" select="fn:replace( $work, 'Î³', 'γ')"/>  <!-- \xCE      -->
        <xsl:variable name="work" select="fn:replace( $work, 'Î²', 'β')"/>  <!-- \xCE      -->
        <xsl:variable name="work" select="fn:replace( $work, 'Î±', 'α')"/>  <!-- \xCE      -->        
        <xsl:variable name="work" select="fn:replace( $work, 'Î´', 'δ')"/>  <!-- \xCE      -->
        <xsl:variable name="work" select="fn:replace( $work, 'Î¸', 'θ')"/>  <!-- \xCE      -->
        <xsl:variable name="work" select="fn:replace( $work, 'Î', 'Δ')"/>  <!-- \xCE \x94 -->
        <xsl:variable name="work" select="fn:replace( $work, 'Î»', 'λ')"/>  <!-- \xCE      -->
        <xsl:variable name="work" select="fn:replace( $work, 'Î§', 'Χ')"/>  <!-- \xCE      -->
        <xsl:variable name="work" select="fn:replace( $work, 'Îµ', 'e')"/>  <!-- \xCE      -->
        <xsl:variable name="work" select="fn:replace( $work, 'Îµ', 'e')"/>  <!-- \xCE      -->
        
        <xsl:variable name="work" select="fn:replace( $work, 'Î&#x87;', '·')"/>  <!-- \xCE      -->
        <xsl:variable name="work" select="fn:replace( $work, 'Î', '·')"/>  <!-- \xCE      -->
        <xsl:variable name="work" select="fn:replace( $work, 'Îº', 'κ')"/>  <!-- \xCE      -->
        
        <xsl:variable name="work" select="fn:replace( $work, 'Ì&#x80;', '`')"/>  <!-- -->
        
        
         <xsl:variable name="work" select="fn:replace( $work, 'Ï&#x87;', 'χ')"/>  <!--      -->       
        
        <xsl:variable name="work" select="fn:replace( $work, 'ï¬', 'fi')"/>  <!-- \xEF \xAC \x81 -->
        <xsl:variable name="work" select="fn:replace( $work, 'ï&#x82;', '')"/>  <!-- -->
        

        <xsl:variable name="work" select="fn:replace( $work, 'Âµ', 'µ')"/> <!-- \xC2 \xB5 -->
        <xsl:variable name="work" select="fn:replace( $work, 'Â±', '±')"/> <!-- \xC2  -->
        <xsl:variable name="work" select="fn:replace( $work, 'Âº', 'º')"/> <!-- \xC2  --> 
        <xsl:variable name="work" select="fn:replace( $work, 'Â²', '²')"/> <!-- \xC2  -->
        <xsl:variable name="work" select="fn:replace( $work, 'Â£', '£')"/> <!-- \xC2  -->        
        <xsl:variable name="work" select="fn:replace( $work, 'Â³', '³')"/> <!-- \xC2  -->
        <xsl:variable name="work" select="fn:replace( $work, 'Â½', '½')"/>  
        <xsl:variable name="work" select="fn:replace( $work, 'Â·', '·')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'Â¹', '¹')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'Â´', '´')"/>

        <xsl:variable name="work" select="fn:replace( $work, 'É', 'α')"/>
        <xsl:variable name="work" select="fn:replace( $work, 'É¸', 'φ')"/>
        
        <xsl:variable name="work" select="fn:replace( $work, 'Ï&#x84;', 'τ')"/>
        
        <xsl:variable name="work" select="fn:replace( $work, '&#xA;', ' ')"/>
        <xsl:variable name="work" select="fn:replace( $work, '&#xD;', ' ')"/>
        <xsl:variable name="work" select="fn:replace( $work, '&#xE5F8;', '&#x2014;')"/>
        <xsl:variable name="work" select="fn:replace( $work, '&#xe5fc;', '&#x2261;')"/>
        <xsl:variable name="work" select="fn:replace( $work, '&#xe5fb;', '&#x2550;')"/>
        <xsl:value-of select="$work"/>
    </xsl:template>

</xsl:stylesheet>
