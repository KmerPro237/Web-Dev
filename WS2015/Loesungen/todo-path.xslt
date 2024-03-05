<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="text"/>
  
    <!-- Zum Testen müssen die Datei todo-dtd.xml als Eingabedatei verwendet werden. -->

    <xsl:template match="todo">
      <!-- In der Klausur müssen nur die Werte der select-Attribute angegeben werden. -->
      
      --- a)
      <xsl:apply-templates select="//aufgabe[../@id='Garten' or zusatzkategorie='Garten']"/>
      oder
      <xsl:apply-templates select="//kategorie[@id='Garten']/aufgabe|//aufgabe[zusatzkategorie='Garten']"/>

      --- b)
      <xsl:apply-templates select="//kategorie[aufgabe[@erledigt='ja']]"/>
      oder
      <xsl:apply-templates select="//aufgabe[@erledigt='ja']/.."/>
      oder
      <xsl:apply-templates select="//kategorie[aufgabe/@erledigt='ja']"/>
      oder
      <xsl:apply-templates select="//kategorie[count(aufgabe[@erledigt='ja'])>0]"/>

      --- c)
      <xsl:apply-templates select="id(//aufgabe[@dauer &gt;= 3]/@vorher)"/>
      aber nicht
      <xsl:apply-templates select="//aufgabe[contains(//aufgabe[@dauer &gt;= 3]/@vorher,@id)]"/>

    </xsl:template>

  <!-- Die folgenden Templates sind für die Lösung nicht erforderlich, sondern dienen
   nur dazu, eine sinnvolle Ausgabe zu erzeugen. -->

  <xsl:template match="aufgabe">
    Aufgabe: <xsl:value-of select="@name"/>
  </xsl:template>

  <xsl:template match="kategorie">
    <xsl:value-of select="@id"/>
  </xsl:template>

  
</xsl:stylesheet>
