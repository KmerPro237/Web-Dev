<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="text"/>

    <xsl:template match="olympia">
      <!-- In der Klausur müssen nur die Werte der select-Attribute angegeben werden. -->
      --- a)
      <xsl:apply-templates select="//wettkampf[@geschlecht='w']" />
  
      --- b)
      <xsl:apply-templates select="//sportler[@land='Deutschland' and contains(olympiateilnahmen,2010)]" />
      oder
      <xsl:apply-templates select="//sportler[@land='Deutschland'][contains(olympiateilnahmen,2010)]" />
      oder
      <xsl:apply-templates select="//sportler[@land='Deutschland' and olympiateilnahmen[contains(text(),2010)]]" />


      --- c)
      <xsl:apply-templates select="//wettkampf/ergebnis[2]/@sid"/>
      oder
      <xsl:apply-templates select="//ergebnis[position()=2]/@sid"/>
      oder
      <xsl:apply-templates select="//ergebnis[count(preceding-sibling::ergebnis)=1]/@sid"/>
      oder
      <xsl:apply-templates select="//sportler[@sid=//ergebnis[2]/@sid]/@sid"/>

      --- d)
      <!-- Das XML-Dokument muss die DTD verwenden, sonst funktioniert id() nicht. -->
      <xsl:apply-templates select="//wettkampf[id(ergebnis/@sid)[@land='Schweiz']]"/>
      <xsl:apply-templates select="//wettkampf[id(ergebnis/@sid)/@land='Schweiz']"/>
      <xsl:apply-templates select="//wettkampf[ergebnis[id(@sid)/@land='Schweiz']]"/>
      <xsl:apply-templates select="//wettkampf[count(id(ergebnis/@sid)[@land='Schweiz'])>=1]"/>
      <xsl:apply-templates select="//wettkampf[count(ergebnis[@sid=//sportler[@land='Schweiz']/@sid])>=1]"/>
      <xsl:apply-templates select="//wettkampf[ergebnis/@sid=//sportler[@land='Schweiz']/@sid]"/>
      <xsl:apply-templates select="//wettkampf[ergebnis/@sid=//sportler/@sid[../@land='Schweiz']]"/>
      <xsl:apply-templates select="//ergebnis[@sid=//sportler[@land='Schweiz']/@sid]/.."/>
      aber nicht
      <xsl:apply-templates select="//wettkampf[ergebnis[//sportler[@sid=current()/@sid and @land='Schweiz']]]"/>

    </xsl:template>

  <!-- Die folgenden Templates sind für die Lösung nicht erforderlich, sondern dienen
   nur dazu, eine sichtbare Ausgabe zu erzeugen. -->
  
  <xsl:template match="wettkampf">
    Name <xsl:value-of select="@sportart"/>
  </xsl:template>
  <xsl:template match="sportler">
    <xsl:value-of select="name"/>, <xsl:value-of select="vorname"/>
  </xsl:template>
  <xsl:template match="ergebnis">
    Ergebnis: <xsl:value-of select="*"/>
  </xsl:template>
  <xsl:template match="@sid">
    <xsl:value-of select="."/>
    <xsl:text> </xsl:text>
  </xsl:template>
 
</xsl:stylesheet>
