#  Metadata Structure for Access Conditions to Open Access Journals

## Issue

The repo explains how source metadata may be repurposed to build informative access and reuse policy statements.

The task is to create specific accessCondition statements that are pertinent to a particular work based on information found within the publisher metadata. 
## Description
**Use and Reproduction** 
Informs on the proper use and redistrbution of a work; how that work may be adapted or recreated; and whether the creator of a work needs to be credited. Finally, informs on whether the work may be built upon or altered in any way. 

**Open Access Statement**
NAL intends to provide structured metadata regarding the proper usage and reproduction rights of any work that may be accessed and viewed. on  statement intends to provide a framework to which creators can share their work while still holding on to some of their rights to the work.  

## Resolution 

This example uses metadata files from Elsevier Consyn.

Each file contains a *&lt;cp:licenseLine&gt;* node; the content within each of these nodes is a statement that references a Creative Commons license  the primary information to match for a particular license.

**Example filename:** S2352340922000385
```xml
<cp:licenseLine xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">This is an open
                access article under the CC BY-NC-ND license.</cp:licenseLine>
```
------------------
***Creative Common Licenses***:
 -  Subsequently the appropriate license information is selected from the source metadata, the regex-groups that matched a substring are copied into the **&lt;mods:accessConditon  displayLabel=""&gt;** and into the **&lt;license_ref&gt;** tags. 
 -  Thus programmatically defining the correct license for each work on the fly.  
- Click the link for specific information about  [The Licenses](https://github.com/CarlosMtz3/OpenAccess/wiki/The-Licenses).
### &lt;mods:accessCondition&gt;
This mods element covers the license and access conditions content of the metadata. It is not defined i  and its child required enhancements. elements  to meet NAL MODS standards. NAL structure for metadata not defined by the MODS standard.

#### XSLT Transforamtion


 
```xml
 <xsl:template match="cp:licenseLine">
        <xsl:analyze-string select="." regex="(.* CC BY license\.)|(.*CC BY)(\-[A-Z]+)(\slicense\.)|(.*CC BY)(\-[A-Z]+?\-[A-Z]+)(\slicense\.)|(.*)(CC0)(\slicense\.$)">
                <xsl:matching-substring>
                    <accessCondition type="use and reproduction">
                    <xsl:choose>
                        <xsl:when test="regex-group(1)">
                            <xsl:attribute name="displayLabel">
                                <xsl:text>Creative Commons Attribution 4.0 Generic (CC BY 4.0)</xsl:text>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="regex-group(2) and regex-group(3) and regex-group(4) ">
                                <xsl:attribute name="displayLabel">
                                    <xsl:text>Creative Commons Attribution 4.0 Generic&#160;</xsl:text><xsl:value-of select="concat('(CC BY', regex-group(3), ' 4.0)')"/>
                                </xsl:attribute>
                            </xsl:when>
                        <xsl:when test="regex-group(5) and regex-group(6) and regex-group(7)"> 
                        <xsl:attribute name="displayLabel">
                            <xsl:text>Creative Commons Attribution 4.0 Generic&#160;</xsl:text><xsl:value-of select="concat('(CC BY', regex-group(6), ' 4.0)')"/>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="displayLabel">
                                <xsl:text>Creative Commons Attribution 4.0 Generic (CC BY 4.0)</xsl:text>
                            </xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                                <program xmlns="https://data.crossref.org/schemas/AccessIndicators.xsd">
                                    <xsl:choose>
                                        <xsl:when test="regex-group(1)">
                                            <license_ref>                                               
                                                <xsl:text>https://creativecommons.org/licenses/by/4.0/</xsl:text>
                                            </license_ref>
                                        </xsl:when>
                                        <xsl:when test="regex-group(2) and regex-group(3) and regex-group(4) ">                                         
                                                <xsl:text>https://creativecommons.org/licenses/by</xsl:text>
                                                <xsl:value-of select="concat(lower-case(regex-group(3)),'/4.0')"/>                                            
                                        </xsl:when>
                                        <xsl:when test="regex-group(5) and regex-group(6) and regex-group(7) ">
                                            <xsl:attribute name="displayLabel">
                                                <xsl:text>https://creativecommons.org/licenses/by</xsl:text>
                                                <xsl:value-of select="concat(lower-case(regex-group(6)),'/4.0')"/>
                                            </xsl:attribute>
                                        </xsl:when>
                                    </xsl:choose>
                                </program>
                    </accessCondition>
                </xsl:matching-substring>
                <xsl:non-matching-substring>
                    <accessCondition type="use and reproduction" displayLabel="Creative Commons Attribution 1.0 Generic (CC0)">
                        <program xmlns="https://data.crossref.org/schemas/AccessIndicators.xsd">                
                            <license_ref>https://creativecommons.org/publicdomain/zero/1.0/</license_ref>                
                        </program>
                    </accessCondition>                    
                </xsl:non-matching-substring>
            </xsl:analyze-string>
    </xsl:template>
   ```
##### Creating the **&lt;mods:accessCondition&gt;** template

- Utilizing the  *&lt;xsl:analyze-string&gt;* instruction allows for the examination of the contents found within *&lt;cp:licenseLine&gt;* element at the *@displayLabel* attribute.


- The *&lt;xsl:analyze-string&gt;* instruction allows for the group matches found within the string and referernce that group to produce the result.


- The following licenses are produced by these respectieve regex-groups seen below:

   -   **regex-group(1)**: 
        - if test matches **CC BY License**.
        -  "&lt;mods:accessCondition @displayLabel=&quot;Creative Commons Attribution 4.0 Generic (CC BY 4.0)&quot;
    &gt;
   -   **regex-group(2,3,4)**: 
        -    matches -NC, -ND, -SA. 
        -    The statement is constructed by a string literal containing aquot;Creative Commons Attribution 4.0 Generic 
        -    Then concatenatates "**(CC BY", regex-group(3) , 4.0)**".
    
    -   **regex-group(5,6,7)**: 
        - matches -NC-ND or -NC-SA. 
        - The statement is constructed by a string literal containing "Creative Commons Attribution &quot;4.0 Generic&quot;, 
        - Then concatenates &quot; "**CC BY&quot;, regex-group(6), 4.0**"
-   If none of the aformentioned is match, the conditional statement utilizes "xsl:otherwise" instruction to plugin the general CC BY statement (i.e., referenced by regex-group(1)
    
-   Since the primary instruction allows for the use of
**&lt;matching-substring&gt;** and **&lt;non-matching-substring&gt;**, the latter applies the CC0 license option.
    
-   The same logic is applied to the construction of the Creative Commons URL found in the license_ref tag

