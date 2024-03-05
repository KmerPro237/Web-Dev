<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
  

  <xsl:output method="text"/>

  <xsl:template match="seminar">
    <!-- In der Klausur müssen nur die Werte der select-Attribute angegeben werden. -->

    a)
    <xsl:apply-templates select="//stud[count(wunsch)=1]"/>
    <!--
    falsch
    <xsl:apply-templates select="//wunsch[count(following-sibling::*)=0]/.."/>
    -->


    b)
    <xsl:apply-templates select="//vortrag[not(@datum) and not(@uhrzeit)]"/>
    oder
    <xsl:apply-templates select="//vortrag[not(@datum or @uhrzeit)]"/>
    oder
    <xsl:apply-templates select="//vortrag[count(@datum)=0 and count(@uhrzeit)=0]"/>
    oder
    <xsl:apply-templates select="//vortrag[not(contains(@datum,'-')) and not(contains(@uhrzeit,':'))]"/>
    <!-- falsch
    <xsl:apply-templates select="//vortrag[@datum='' and @uhrzeit='']"/>
    -->

    c)
    <xsl:apply-templates select="//thema[not(@nr=//vortrag/@thema)]"/>
    <!-- falsch
    <xsl:apply-templates select="//thema[@nr!=//vortrag/@thema]"/>
    <xsl:apply-templates select="//thema[count(//vortrag[@thema=@nr])=0]"/>
    -->

  </xsl:template>

  <!-- Die folgenden Templates sind für die Lösung nicht erforderlich, sondern dienen
   nur dazu, eine sinnvolle Ausgabe zu erzeugen. -->


  <xsl:template match="stud">
    Name: <xsl:value-of select="vorname"/><xsl:text> </xsl:text><xsl:value-of select="nachname"/>
  </xsl:template>

  <xsl:template match="thema">
    Thema: <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="wunsch">
    Prio:<xsl:value-of select="@prio"/>
    Thema:<xsl:value-of select="@thema"/>
  </xsl:template>

  <xsl:template match="vortrag">
    <xsl:apply-templates select="id(@thema)"/>
  </xsl:template>

</xsl:stylesheet>
