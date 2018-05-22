<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs xd tei"
    version="2.0">
    <!-- The XML output method is chosen so that the editor (Oxygen) stays within the XML ecosystem
        and doesn't mark valid HTML as faulty. The output HTML contains an XML declaration but is usable for
        testing purposes. -->
    <xsl:output method="xml"/>
    
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> May 22, 2018</xd:p>
            <xd:p><xd:b>Author:</xd:b> Artjom Balabanov</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    
    <!-- TRANSFORMATION -->
    
    <xsl:variable name="display">normalized</xsl:variable>
    <xsl:variable name="abbreviation">full</xsl:variable>
    
    <xsl:template match="/">
        <html>
            <head/>
            <body>
                <p>
                    <xsl:apply-templates/>
                </p>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="tei:teiHeader"/>
    
    <xsl:template match="tei:w//text()">
        <xsl:choose>
            <xsl:when test="contains($display, 'normalized')">
                <xsl:value-of select="translate(., ' ', '')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:choice">
        <xsl:choose>
            <xsl:when test="contains($abbreviation, 'full')">
                <xsl:apply-templates select="tei:expan"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="tei:abbr"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:hi">
        <xsl:choose>
            <xsl:when test="@rend='a'">
                <i>
                    <xsl:apply-templates/>
                </i>
            </xsl:when>
            <xsl:otherwise>
                <b>
                    <xsl:apply-templates/>
                </b>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>