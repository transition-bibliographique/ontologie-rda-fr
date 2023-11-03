<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    xmlns:dct="http://purl.org/dc/terms/"
    xmlns:owl="http://www.w3.org/2002/07/owl#"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="html" indent="no"/>
    <xsl:strip-space elements="*"/>
    
   <xsl:template match="/">
       <xsl:text># Vocabulaires contrôlés&#10;&#10;</xsl:text>
       
       <xsl:call-template name="liste-vocab"/>

       <xsl:text>&#10;&#10;</xsl:text> 
       <xsl:comment>Ce fichier est généré automatiquement. Il ne doit pas être édité manuellement.</xsl:comment>
   </xsl:template>

    <xsl:template name="liste-vocab">
        <xsl:for-each select="/rdf:RDF/rdf:Description[rdf:type/@rdf:resource='http://www.w3.org/2004/02/skos/core#ConceptScheme' and skos:hasTopConcept ]">
            <xsl:variable name="filename">
                <xsl:value-of select="substring-after(@rdf:about, 'https://rdafr.fr/vocabulary/')"/>    
            </xsl:variable>
            
            <xsl:variable name="title">
                <xsl:value-of select="concat('[', substring-after(./dct:title/text(), 'Ontologie RDA-FR - Vocabulaires contrôlés : '), '](', $filename,'.html)' )"/>
            </xsl:variable>
            
            <xsl:variable name="date">
                <xsl:value-of select="format-dateTime(./dct:modified, '[D01]/[M01]/[Y0001]')"/>
            </xsl:variable>
            
            <xsl:value-of select="concat('* **', $title, '**', ' ', $date, '&#10;')"/>            
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
