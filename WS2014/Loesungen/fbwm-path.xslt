<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="text"/>

    <xsl:template match="fbwm">
      <!-- In der Klausur müssen nur die Werte der select-Attribute angegeben werden. -->
      --- a)
      <xsl:apply-templates select="//spiel[substring(@datum,6,2)='07']"/>
      <xsl:apply-templates select="//spiel[contains(@datum,'-07-')]"/>

      --- b)
      <xsl:apply-templates select="//spiel[@mannschaft1='Deutschland' or @mannschaft2='Deutschland']"/>

      --- c)
      <xsl:apply-templates select="//spieler[spieleinsatz/tor[@elfmeter='ja']]/@name" />
      <xsl:apply-templates select="//spieler[spieleinsatz/tor/@elfmeter='ja']/@name" />
      <xsl:apply-templates select="//spieler[spieleinsatz[tor[@elfmeter='ja']]]/@name" />
      <xsl:apply-templates select="//spieler/spieleinsatz/tor[@elfmeter='ja']/../../@name" />
      <xsl:apply-templates select="//spieler[count(spieleinsatz/tor[@elfmeter='ja'])>=1]/@name" />

      --- d)
      <xsl:apply-templates select="//spieleinsatz[(laufleistung/@einheit='m' and laufleistung>=10000) or (laufleistung/@einheit='km' and laufleistung >= 10)]"/>
      <xsl:apply-templates select="//spieleinsatz[laufleistung[@einheit='m' and text()>=10000 or @einheit='km' and text() >= 10]]"/>
      <xsl:apply-templates select="//spieleinsatz[laufleistung[@einheit='m'][text()>=10000] or laufleistung[@einheit='km'][text() >= 10]]"/>
      <xsl:apply-templates select="//spieleinsatz[laufleistung[@einheit='m']>=10000 or laufleistung[@einheit='km']>= 10]"/>
      <xsl:apply-templates select="//spieleinsatz[laufleistung>=10000 or laufleistung[@einheit='km']>= 10]"/>

    </xsl:template>

  <!-- Die folgenden Templates sind für die Lösung nicht erforderlich, sondern dienen
   nur dazu, eine sichtbare Ausgabe zu erzeugen. -->

  <xsl:template match="spiel">
    Spiel <xsl:value-of select="@mannschaft1"/>-<xsl:value-of select="@mannschaft2"/>
  </xsl:template>

  <xsl:template match="spieleinsatz">
    <xsl:value-of select="laufleistung"/> <xsl:value-of select="laufleistung/@einheit"/>
    <xsl:text> </xsl:text>
  </xsl:template>
</xsl:stylesheet>
