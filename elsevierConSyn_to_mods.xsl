<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns="http://www.loc.gov/mods/v3"
    xmlns:bam="http://vtw.elsevier.com/data/voc/ns/bam-vtw-1/"
    xmlns:bk="http://www.elsevier.com/xml/bk/schema"
    xmlns:cals="http://www.elsevier.com/xml/common/cals/schema"
    xmlns:ce="http://www.elsevier.com/xml/common/schema"
    xmlns:cja="http://www.elsevier.com/xml/cja/schema"
    xmlns:cp="http://vtw.elsevier.com/data/ns/properties/Copyright-1/"
    xmlns:cps="http://www.elsevier.com/xml/common/consyn-properties/schema"
    xmlns:dct="http://purl.org/dc/terms/"
    xmlns:doc="http://www.elsevier.com/xml/document/schema"
    xmlns:dp="http://www.elsevier.com/xml/common/doc-properties/schema"
    xmlns:f="http://functions"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:ja="http://www.elsevier.com/xml/ja/schema"
    xmlns:mml="http://www.w3.org/1998/Math/MathML"
    xmlns:oa="http://vtw.elsevier.com/data/ns/properties/OpenAccess-1/"
    xmlns:prism="http://prismstandard.org/namespaces/basic/2.0/"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
    xmlns:sa="http://www.elsevier.com/xml/common/struct-aff/schema"
    xmlns:saxon="http://saxon.sf.net/"
    xmlns:sb="http://www.elsevier.com/xml/common/struct-bib/schema"
    xmlns:tb="http://www.elsevier.com/xml/common/table/schema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="bam bk cals ce cja cp cps dct doc dp f fn ja mml oa prism rdf sa saxon sb tb xd xlink xsi xsl">
    
    <xsl:output method="xml" indent="yes" encoding="UTF-8" saxon:next-in-chain="fix_characters.xsl"/>
    <xsl:output method="xml" indent="yes" encoding="UTF-8" name="archive-original"/>

    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Last modified on:</xd:b>February 22, 2022</xd:p>
            <xd:p><xd:b>Original author:</xd:b> Jennifer Gilbert</xd:p>
            <xd:p><xd:b>Modified by:</xd:b> Emily Somach, Amanda Xu and Carlos Martinez</xd:p>
            <xd:p><xd:b>Last edited by:</xd:b>Carlos Martinez</xd:p>
            <xd:p><xd:b>Last edited to:</xd:b>Add template to create mods:accessCondition statements, cm3, 2022-02-22</xd:p>
            <xd:p>This stylesheet was refactored in July 2017.</xd:p>
        </xd:desc>
    </xd:doc>

    <xd:doc scope="component">
        <xd:desc>
            <xd:p>Include external stylesheets.</xd:p>
            <xd:ul>
                <xd:li><xd:b>common.xsl:</xd:b> templates shared across all stylesheets</xd:li>
                <xd:li><xd:b>params.xsl:</xd:b> parameters shared across all stylesheets</xd:li>
                <xd:li><xd:b>functions.xsl: </xd:b>functions shared across all stylesheets</xd:li>
            </xd:ul>
        </xd:desc>
    </xd:doc>
    <xsl:include href="commons/common.xsl"/>
    <xsl:include href="commons/params.xsl"/>
    <xsl:include href="commons/functions.xsl"/>

    <xsl:strip-space elements="*"/>

    <xd:doc>
        <xd:desc>
            <xd:p>Build MODS document</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template  match="/">

        <xsl:result-document method="xml" encoding="UTF-8" indent="yes"
            href="file:///{$workingDir}A-{replace($originalFilename, '(.*/)(.*)(\.xml)', '$2')}_{position()}.xml"
            format="archive-original">
            <xsl:copy-of  select="."/>
        </xsl:result-document>
        <xsl:result-document method="xml" encoding="UTF-8" indent="yes"
            href="file:///{$workingDir}N-{replace($originalFilename, '(.*/)(.*)(\.xml)', '$2')}_{position()}.xml"
            format="archive-original">

            <mods version="3.7">
                <xsl:namespace name="xsi">http://www.w3.org/2001/XMLSchema-instance</xsl:namespace>
                <xsl:attribute name="xsi:schemaLocation" select="normalize-space('http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-7.xsd')"/>

                <xsl:apply-templates select="//doc:document/rdf:RDF[1]/rdf:Description[1]/dct:title[1]"/>

                <!-- Account for variety of author formats -->
                <xsl:apply-templates select="/doc:document/(ja:article | ja:simple-article)/(ja:head | ja:simple-head)/ce:author-group/ce:collaboration/ce:text"/>
                <xsl:apply-templates select="/doc:document/(ja:article | ja:simple-article)/(ja:head | ja:simple-head)/ce:author-group/(. | ce:collaboration/ce:author-group)"/>
                <xsl:apply-templates select="/doc:document/cja:converted-article/cja:head/ce:author-group"/>

                <!-- Default -->
                <typeOfResource>text</typeOfResource>
                <genre>article</genre>

                <xsl:call-template name="modsOriginDate"/>

                <!-- Default language -->
                <language>
                    <languageTerm type="code" authority="iso639-2b">eng</languageTerm>
                    <languageTerm type="text">English</languageTerm>
                </language>
                <xsl:apply-templates select="/doc:document/(ja:article | ja:simple-article)/(ja:head | ja:simple-head)/ce:abstract[@class = 'author']"/>
                <xsl:apply-templates select="/doc:document/cja:converted-article/cja:head/ce:abstract[@class = 'author']"/>
                <xsl:call-template name="admin-note"/>
                <xsl:apply-templates  select="/doc:document/ja:article/ja:head/ce:keywords"/>
                <xsl:apply-templates  select="/doc:document/rdf:RDF/rdf:Description"/>
                <xsl:apply-templates  select="/doc:document/ja:article/ja:item-info"/>

                <xsl:apply-templates  select="/doc:document/rdf:RDF/rdf:Description/cp:licenseLine"/>

                <xsl:call-template name="extension"/>
            </mods>
        </xsl:result-document>

    </xsl:template>


    <xd:doc>
        <xd:desc>
            <xd:p>Get title from RDF block</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template  match="dct:title">
        <titleInfo>
            <title>
                <xsl:value-of select="normalize-space(.)"/>
            </title>
        </titleInfo>
    </xsl:template>




    <xd:doc>
        <xd:desc>
            <xd:p>Add author names and affiliations; set usage attribute to "primary" if it's the
                first author.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="ja:head/ce:author-group | cja:head/ce:author-group | ja:simple-head/ce:author-group">
        <xsl:for-each  select="ce:author">
            <name type="personal">
                <xsl:if  test="position() = 1 and count(../preceding-sibling::ce:author-group) = 0">
                    <xsl:attribute name="usage">primary</xsl:attribute>
                </xsl:if>
                <xsl:call-template name="name-info"/>
            </name>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="ja:head/ce:author-group/ce:collaboration/ce:text | ja:simple-head/ce:author-group/ce:collaboration/ce:text">
        <name type="corporate">
            <xsl:if  test="position() = 1 and not(../../ce:author)">
                <xsl:attribute name="usage">primary</xsl:attribute>
            </xsl:if>
            <namePart>
                <xsl:value-of select="."/>
            </namePart>
            <displayForm>
                <xsl:value-of select="."/>
            </displayForm>
            <role>
                <roleTerm type="text">author</roleTerm>
            </role>
        </name>
    </xsl:template>

    <xsl:template  match="ce:author-group/ce:collaboration/ce:author-group">
        <xsl:for-each  select="ce:author">
            <name type="personal">
                <xsl:call-template name="name-info"/>
            </name>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="name-info">
        <namePart type="given">
            <xsl:value-of select="normalize-space(ce:given-name)"/>
        </namePart>
        <namePart type="family">
            <xsl:value-of select="ce:surname"/>
        </namePart>
        <xsl:apply-templates  select="@orcid"/>
        <displayForm>
            <xsl:value-of select="ce:surname"/>
            <xsl:text>, </xsl:text>
            <xsl:value-of select="normalize-space(ce:given-name)"/>
        </displayForm>
        <!-- Use id to get affiliation  -->
        <xsl:choose>
            <xsl:when  test="ce:cross-ref/@refid">
                <xsl:for-each  select="../ce:affiliation[@id = current()/ce:cross-ref/@refid]">
                    <affiliation>
                        <xsl:apply-templates  select="normalize-space(ce:textfn)" mode="affiliation"/>
                    </affiliation>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each  select="../ce:affiliation">
                    <affiliation>
                        <xsl:value-of select="normalize-space(ce:textfn)"/>
                    </affiliation>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
        <role>
            <roleTerm type="text">author</roleTerm>
        </role>
    </xsl:template>

    <xd:doc scope="component">
        <xd:desc>
            <xd:p>Adds authors' ORCID if provided.</xd:p>
            <xd:p>Turns ORCID into a URI if only the 16-digit number is given.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template  match="@orcid">
        <nameIdentifier type="orcid">
            <xsl:choose>
                <xsl:when  test="contains(., 'orcid.org')">
                    <xsl:value-of select="replace(., 'http:', 'https:')"/>
                </xsl:when>
                <xsl:when  test="string(.)">
                    <xsl:value-of select="concat('https://orcid.org/', .)"/>
                </xsl:when>
            </xsl:choose>
        </nameIdentifier>
    </xsl:template>

    <xd:doc>
        <xd:desc>
            <xd:p>Suppress label and superscript content in affiliations.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template  match="ce:label | ce:sup" mode="affiliation"/>

    <!-- date Issued -->

    <xd:doc>
        <xd:desc>
            <xd:p><xd:b>modsOriginDate:</xd:b> this template sets up the order of precedence when
                choosing a value for originInfo/dateIssued.</xd:p>
            <xd:p>The templates following it construct dateIssued.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template name="modsOriginDate">
        <originInfo>
            <xsl:choose>
                <xsl:when  test="/doc:document/rdf:RDF/rdf:Description/prism:coverDate">
                    <xsl:apply-templates select="/doc:document/rdf:RDF/rdf:Description/prism:coverDate" mode="origin"/>
                </xsl:when>
                <xsl:when  test="/doc:document/rdf:RDF/rdf:Description/prism:coverDisplayDate">
                    <xsl:apply-templates select="/doc:document/rdf:RDF/rdf:Description/prism:coverDisplayDate" mode="origin"/>
                </xsl:when>
                <xsl:when test="/doc:document/(ja:article | ja:simple-article)/(ja:head | ja:simple-head)/ce:date-accepted">
                    <xsl:apply-templates select="/doc:document/(ja:article | ja:simple-article)/(ja:head | ja:simple-head)/ce:date-accepted" mode="origin"/>
                </xsl:when>
                <xsl:when test="/doc:document/(ja:article | ja:simple-article)/ja:item-info/ce:copyright">
                    <xsl:apply-templates select="/doc:document/(ja:article | ja:simple-article)/ja:item-info/ce:copyright" mode="origin"/>
                </xsl:when>
            </xsl:choose>
        </originInfo>
    </xsl:template>

    <xsl:template  match="prism:coverDate" mode="origin">
        <dateIssued encoding="w3cdtf" keyDate="yes">
            <xsl:value-of select="."/>
        </dateIssued>
    </xsl:template>

    <xsl:template  match="prism:coverDisplayDate" mode="origin">
        <xsl:variable name="build-year">
            <xsl:analyze-string select="/doc:document/rdf:RDF/rdf:Description/prism:coverDisplayDate"
                regex="[0-9]{{4}}">
                <xsl:matching-substring>
                    <xsl:value-of select="."/>
                </xsl:matching-substring>
            </xsl:analyze-string>
        </xsl:variable>
        <xsl:variable name="build-month">
            <xsl:analyze-string select="/doc:document/rdf:RDF/rdf:Description/prism:coverDisplayDate"
                regex="[A-Z,a-z]+">
                <xsl:matching-substring>
                    <xsl:value-of select="."/>
                </xsl:matching-substring>
            </xsl:analyze-string>
        </xsl:variable>
        <dateIssued encoding="w3cdtf" keyDate="yes">
            <xsl:value-of select="$build-year"/>
            <xsl:text>-</xsl:text>
            <xsl:choose>
                <xsl:when  test="$build-month != ''">
                    <xsl:value-of select="f:monthNumFromName($build-month)"/>
                </xsl:when>
                <xsl:when  test="month != ''">
                    <xsl:value-of select="f:monthNumFromName(month)"/>
                </xsl:when>
            </xsl:choose>
        </dateIssued>
    </xsl:template>

    <xsl:template  match="ce:date-accepted" mode="origin">
        <dateIssued encoding="w3cdtf" keyDate="yes">
            <xsl:value-of select="concat(./@year, '-', f:checkMonthType(./@month), '-', f:checkTwoDigitDay(./@day))"
            />
        </dateIssued>
    </xsl:template>

    <xsl:template  match="ce:copyright" mode="origin">
        <dateIssued encoding="w3cdtf" keyDate="yes">
            <xsl:value-of select="/doc:document/(ja:article | ja:simple-article)/ja:item-info/ce:copyright/@year"
            />
        </dateIssued>
    </xsl:template>


    <xd:doc>
        <xd:desc>
            <xd:p>Construct the abstract.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="ja:head/ce:abstract[@class = 'author'] | ja:simple-head/ce:abstract[@class = 'author'] | cja:head/ce:abstract[@class = 'author']">
        <abstract>
            <xsl:apply-templates  select="ce:abstract-sec/ce:simple-para"/>
        </abstract>
    </xsl:template>

    <xd:doc>
        <xd:desc>
            <xd:p>Add spaces between ce:simple-para elements; convert sup/sub tag content.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template  match="ce:abstract-sec/ce:simple-para">
        <xsl:variable name="this">
            <xsl:apply-templates/>
        </xsl:variable>
        <xsl:value-of select="normalize-space($this)"/>
        <xsl:text>&#160;</xsl:text>
    </xsl:template>

    <xd:doc>
        <xd:desc>
            <xd:p>Suppress ce:label tags in abstracts.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template  match="ce:list/ce:list-item/ce:label" mode="abstract">
        <xsl:value-of select="replace(., '•', ' ')"/>
    </xsl:template>

    <xd:doc>
        <xd:desc>
            <xd:p>Keywords to topical subjects</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template  match="ce:keywords">
        <xsl:for-each  select="ce:keyword/ce:text">
            <subject>
                <topic>
                    <xsl:value-of select="."/>
                </topic>
            </subject>
        </xsl:for-each>
    </xsl:template>



    <xd:doc>
        <xd:desc>
            <xd:p>The following templates build the <xd:b>relatedItem</xd:b> element.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template  match="rdf:Description">
        <relatedItem type="host">
            <xsl:apply-templates  select="prism:publicationName"/>
            <xsl:apply-templates select="/doc:document/ja:article/ja:item-info/ce:copyright[@type = 'society']"/>
            <xsl:apply-templates select="/doc:document/ja:article/ja:item-info/ce:copyright[@type = 'limited-transfer']"/>
            <xsl:apply-templates  select="dct:publisher"/>
            <xsl:apply-templates  select="prism:issn"/>

            <part>
                <xsl:apply-templates  select="prism:volume"/>
                <xsl:apply-templates  select="prism:number"/>
                <xsl:call-template name="modsDatePart"/>
                <xsl:call-template name="modsPages"/>
            </part>

        </relatedItem>
        <xsl:apply-templates  select="prism:doi"/>
        <xsl:apply-templates  select="prism:url"/>
    </xsl:template>

    <xd:doc>
        <xd:desc>
            <xd:p>Builds start, end, total page tags for relatedItem/part</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template name="modsPages">
        <xsl:variable name="totalEndPages" select="number(substring-before(prism:endingPage, '.')) + number(substring-after(prism:endingPage, 'e'))"/>
        <extent unit="pages">
            <xsl:apply-templates  select="prism:startingPage"/>
            <xsl:apply-templates  select="prism:endingPage"/>
            <xsl:choose>
                <xsl:when  test="contains(prism:endingPage, '.') or contains(prism:endingPage, 'e')">
                    <xsl:sequence  select="f:calculateTotalPgs(prism:startingPage, $totalEndPages)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:sequence  select="f:calculateTotalPgs(prism:startingPage, prism:endingPage)"
                    />
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if  test="(bam:articleNumber and not(prism:startingPage))">
                <start>
                    <xsl:value-of select="bam:articleNumber"/>
                </start>
            </xsl:if>
        </extent>
    </xsl:template>

    <xsl:template  match="prism:startingPage">
        <start>
            <xsl:value-of select="."/>
        </start>
    </xsl:template>

    <xsl:template  match="prism:endingPage">
        <end>
            <xsl:value-of select="."/>
        </end>
    </xsl:template>

    <xsl:template  match="ja:item-info">
        <xsl:apply-templates  select="ce:pii"/>
    </xsl:template>

    <xsl:template  match="prism:volume">
        <detail type="volume">
            <number>
                <xsl:value-of select="."/>
            </number>
            <caption>v.</caption>
        </detail>
    </xsl:template>

    <xsl:template  match="prism:number">
        <detail type="issue">
            <number>
                <xsl:value-of select="."/>
            </number>
            <caption>no.</caption>
        </detail>
    </xsl:template>

    <xd:doc>
        <xd:desc>
            <xd:p>Builds &lt;text&gt; tags for the <xd:b>part</xd:b> element.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template name="modsDatePart">
        <xsl:if  test="prism:coverDisplayDate">
            <text type="display-date">
                <xsl:value-of select="prism:coverDisplayDate"/>
            </text>
        </xsl:if>
        <xsl:if  test="prism:coverDate">
            <xsl:variable name="in"  select="prism:coverDate"/>
            <xsl:variable name="year"  select="substring($in, 1, 4)"/>
            <xsl:variable name="month"  select="substring($in, 6, 2)"/>
            <xsl:variable name="day"  select="substring($in, 9, 2)"/>
            <text type="year">
                <xsl:value-of select="$year"/>
            </text>
            <text type="month">
                <xsl:value-of select="$month"/>
            </text>
            <text type="day">
                <xsl:value-of select="$day"/>
            </text>
        </xsl:if>
        <xsl:if  test="prism:coverDisplayDate and not(prism:coverDate)">
            <xsl:analyze-string select="/doc:document/rdf:RDF/rdf:Description/prism:coverDisplayDate"
                regex="[0-9]{{4}}">
                <xsl:matching-substring>
                    <text type="year">
                        <xsl:value-of select="."/>
                    </text>
                </xsl:matching-substring>
            </xsl:analyze-string>
            <xsl:analyze-string select="/doc:document/rdf:RDF/rdf:Description/prism:coverDisplayDate"
                regex="[A-Z,a-z]+">
                <xsl:matching-substring>
                    <text type="month">
                        <xsl:value-of select="."/>
                    </text>
                </xsl:matching-substring>
            </xsl:analyze-string>
        </xsl:if>
        <xsl:if test="/doc:document/(ja:article | ja:simple-article)/(ja:head | ja:simple-head)/ce:date-accepted and not(prism:coverDisplayDate) and not(prism:coverDate)">
            <text type="year">
                <xsl:value-of select="/doc:document/(ja:article | ja:simple-article)/(ja:head | ja:simple-head)/ce:date-accepted/@year"
                />
            </text>
            <text type="month">
                <xsl:value-of select="f:checkMonthType(/doc:document/(ja:article | ja:simple-article)/(ja:head | ja:simple-head)/ce:date-accepted/@month)"
                />
            </text>
            <text type="day">
                <xsl:value-of select="f:checkTwoDigitDay(/doc:document/(ja:article | ja:simple-article)/(ja:head | ja:simple-head)/ce:date-accepted/@day)"
                />
            </text>
        </xsl:if>
        <xsl:if test="not(prism:coverDisplayDate) and not(prism:coverDate) and not(/doc:document/(ja:article | ja:simple-article)/(ja:head | ja:simple-head)/ce:date-accepted)">
            <text type="year">
                <xsl:value-of select="/doc:document/(ja:article | ja:simple-article)/ja:item-info/ce:copyright/@year"
                />
            </text>
        </xsl:if>
    </xsl:template>

    <xd:doc>
        <xd:desc>
            <xd:p>Show the copyright holder if it's diffrrent from the publisher.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="/doc:document/ja:article/ja:item-info/ce:copyright[@type = 'society'] | /doc:document/ja:article/ja:item-info/ce:copyright[@type = 'limited-transfer']">
        <name type="corporate">
            <namePart>
                <xsl:value-of select="normalize-space(.)"/>
            </namePart>
            <role>
                <roleTerm>Copyright holder</roleTerm>
            </role>
        </name>
    </xsl:template>

    <xsl:template  match="prism:publicationName">
        <titleInfo>
            <title>
                <xsl:value-of select="normalize-space(.)"/>
            </title>
        </titleInfo>
    </xsl:template>

    <xsl:template  match="dct:publisher">
        <originInfo>
            <publisher>
                <xsl:value-of select="."/>
            </publisher>
        </originInfo>
    </xsl:template>

    <xd:doc>
        <xd:desc>
            <xd:p>Constructs identifiers for ISSN, DOI, PII</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template  match="prism:issn | prism:doi | ce:pii">
        <identifier type="{fn:replace(name(), '([a-z]*)(:)([A-z]*)','$3')}">
            <xsl:value-of select="."/>
        </identifier>
    </xsl:template>

    <xsl:template  match="prism:url">
        <location>
            <url>
                <xsl:value-of select="."/>
            </url>
        </location>
    </xsl:template>

    <xd:doc>
        <xd:desc>
            <xd:p>This is a legacy template--can we really be sure that the absence of a volume
                number indicates a pre-press version?</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template name="admin-note">
        <xsl:if  test="not(/doc:document/rdf:RDF/rdf:Description/prism:volume)">
            <note type="admin">
                <xsl:text>Pre-press version</xsl:text>
            </note>
        </xsl:if>
    </xsl:template>

    <!--accessCondition-->
    <xd:doc>
        <xd:desc>
            <xd:p>Constructs NAL AccessCondition Statements for Creative Commons Licensing by dynmamically selecting parts of different nodes from the source metadata.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template  match="cp:licenseLine">
        <xsl:variable name="licenseURL"  select="/doc:document/rdf:RDF/rdf:Description/oa:openAccessInformation/oa:userLicense"/>      
        <xsl:variable name="startDate"  select="/doc:document/rdf:RDF/rdf:Description/oa:openAccessInformation/oa:openAccessEffective"/>
        <xsl:variable name="getVersion"  select="tokenize($licenseURL, '/')[.][last()]"/>
        <xsl:analyze-string  select="normalize-space(.)" regex="(.* CC BY license\.)|(.*CC BY)(\-[A-Z]+)(\slicense\.)|(.*CC BY)(\-[A-Z]+?\-[A-Z]+)(\slicense\.)|(.*)(CC0)(\slicense\.$)">
            <xsl:matching-substring>
                <!--Creative Commons Licenses-->
                <accessCondition type="use and reproduction">
                    <xsl:attribute name="displayLabel">
                        <xsl:choose>
                            <!--CC BY-->
                            <xsl:when  test="regex-group(1)">
                                <xsl:value-of select="concat('Creative Commons Attribution&#160;', $getVersion, '&#160;','Generic (CC BY ', $getVersion,')')"/>
                            </xsl:when>
                            <!--CC BY-SA, CC BY-NC, CC BY-ND--> 
                            <xsl:when  test="regex-group(2) and regex-group(3) and regex-group(4)">
                                <xsl:value-of select="concat('Creative Commons Attribution&#160;', $getVersion, '&#160;', 'Generic (CC BY',regex-group(3),'&#160;' ,$getVersion,')')"/>
                            </xsl:when>
                            <!--CC BY-SA-ND, CC BY-NC-ND-->
                            <xsl:when  test="regex-group(5) and regex-group(6) and regex-group(7)">
                                <xsl:value-of select="concat('Creative Commons Attribution&#160;', $getVersion, '&#160;', 'Generic (CC BY',regex-group(6),'&#160;' ,$getVersion,')')"/>
                            </xsl:when>
                            <!--CC0-->
                            <xsl:when  test="regex-group(8) and regex-group(9) and regex-group(10)">
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
                            <xsl:attribute name="start_date"  select="substring-before($startDate, 'T')"/>
                        </licence_ref>
                        <licence_ref>                           
                            <xsl:value-of select="$licenseURL"/>
                        </licence_ref>
                    </program>
                </accessCondition>
                <!-- NAL Generic Open Access. -->
                <accessCondition type="use and reproduction" displayLabel="Resource is Open Access">
                    <program>
                        <license_ref>http://purl.org/eprint/accessRights/OpenAccess</license_ref>
                    </program>
                </accessCondition>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <!-- NAL Generic Open Access. -->
                <accessCondition type="use and reproduction" displayLabel="Resource is Open Access">
                    <program>
                        <license_ref>http://purl.org/eprint/accessRights/OpenAccess</license_ref>
                    </program>
                </accessCondition>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>

    <xd:doc>
        <xd:desc>
            <xd:p>Extension for PDF file location and vendor name.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template name="extension">
        <extension>
            <vendorName>
                <xsl:value-of select="$vendorName"/>
            </vendorName>
            <archiveFile>
                <xsl:value-of select="$archiveFile"/>
            </archiveFile>
            <originalFile>
                <xsl:value-of select="$originalFilename"/>
            </originalFile>
            <workingDirectory>
                <xsl:value-of select="$workingDir"/>
            </workingDirectory>
        </extension>
    </xsl:template>

</xsl:stylesheet>
