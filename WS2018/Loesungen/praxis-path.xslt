<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
  

  <xsl:output method="text"/>

  <xsl:template match="praxis">
    <!-- In der Klausur müssen nur die Werte der select-Attribute angegeben werden. -->

    a)
    <xsl:apply-templates select="//patient[behandlung[@abgesagt='ja']]"/>
    <xsl:apply-templates select="//patient[behandlung/@abgesagt='ja']"/>
    <xsl:apply-templates select="//patient[count(behandlung[@abgesagt='ja'])>=1]"/>
    <xsl:apply-templates select="//behandlung[@abgesagt='ja']/.."/>

    b)
    <xsl:apply-templates select="//patient[starts-with(@geboren,'2011')]/behandlung"/>
    <xsl:apply-templates select="//patient[substring-before(@geboren,'-')='2011']/behandlung"/>
    <xsl:apply-templates select="//behandlung[starts-with(../@geboren,'2011')]"/>
    <xsl:apply-templates select="//behandlung[substring(../@geboren,1,4)='2011']"/>

    c)
    <xsl:apply-templates select="//leistung[not(@lkz=//behandlung/@art)]"/>
    
    falsch:
    <xsl:apply-templates select="//leistung[not(//behandlung[@art=current()/@lkz])]"/>
    <xsl:apply-templates select="//leistung[count(//behandlung[@art=./@lkz])=0]"/>
    <xsl:apply-templates select="//leistung[count(//behandlung[@art=current()/@lkz])=0]"/>
    
  </xsl:template>

  <!-- Die folgenden Templates sind für die Lösung nicht erforderlich, sondern dienen
   nur dazu, eine sinnvolle Ausgabe zu erzeugen. -->


  <xsl:template match="patient">
    Name: <xsl:value-of select="vorname"/><xsl:text> </xsl:text><xsl:value-of select="nachname"/>
  </xsl:template>

  <xsl:template match="behandlung">
    Behandlung <xsl:value-of select="@art"/> am <xsl:value-of select="@datum"/> von <xsl:value-of select="../@kvnr"/>
  </xsl:template>

  <xsl:template match="leistung">
    Leistung <xsl:value-of select="@name"/>
  </xsl:template>

</xsl:stylesheet>
