<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
  <xsl:output method="text"/>

  <xsl:template match="projekt">
    <!-- In der Klausur müssen nur die Werte der select-Attribute angegeben werden. -->
    a)
    <xsl:apply-templates select="//top[count(entscheidung)>1]"/>

    b)
    <xsl:apply-templates select="//besprechung[contains(@dauer,'H')]"/>

    c)
    <xsl:apply-templates select="id(//entscheidung/@refAufgabe)"/>

    d)
    <xsl:apply-templates select="//aufgabe[not(contains(../../teilnehmer,@zugeteilt))]"/>
  
  </xsl:template>

  <!-- Die folgenden Templates sind für die Lösung nicht erforderlich, sondern dienen
   nur dazu, eine sinnvolle Ausgabe zu erzeugen. -->

  <xsl:template match="top">
    <xsl:variable name="thema">
      <xsl:if test="string-length(@thema)>0">
        <xsl:value-of select="@thema"/>
      </xsl:if>
      <xsl:if test="string-length(@thema)=0">
        <xsl:value-of select="id(@refid)/@thema"/>
      </xsl:if>
    </xsl:variable>  
      TOP <xsl:number/>: <xsl:value-of select="$thema"/>
  </xsl:template>

  <xsl:template match="besprechung">
    Besprechung vom <xsl:value-of select="substring-before(@start,'T')"/>
  </xsl:template>

  <xsl:template match="entscheidung">
    Entscheidung: <xsl:value-of select="."/>
  </xsl:template>
</xsl:stylesheet>
