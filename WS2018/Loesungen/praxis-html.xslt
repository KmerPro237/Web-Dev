<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
  <xsl:output
    encoding="utf-8"
    indent="yes"
    method="html"
    omit-xml-declaration = "yes"
   />

  <xsl:template match="praxis">
    <!-- DOCTYPE per text ausgeben. Das ist unschön, aber es gibt derzeitig
         keine andere überzeugende Lösung. -->
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html>&#x0a;</xsl:text>

    <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="de" lang="de">
      <head>
        <meta charset="utf-8" />
        <title>
          Therapie
        </title>
        <style>
          table, td, th {
          border: 1px solid black;
          }
        </style>
      </head>
      <body>
        <h1>Behandlungen der <xsl:value-of select="@name"/></h1>
        <xsl:apply-templates select="patienten"/>
      </body>
    </html>
  </xsl:template>

  <!-- Nur die drei folgenden Templates sind zur Lösung der Aufgabe 3 erforderlich. -->

  <xsl:template match="patienten">
    <table>
      <thead>
        <tr>
          <td>Datum</td>
          <td>Kvnr</td>
          <td>Leistung</td>
          <td>Kasse</td>
          <td>Preis</td>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="patient/behandlung[@abgesagt='nein']">
          <xsl:sort  select="../kasse"/>
          <xsl:sort select="@datum"/>
        </xsl:apply-templates>
      </tbody>
    </table>
  </xsl:template>

  <xsl:template match="behandlung">
    <tr>
      <xsl:apply-templates select="@datum"/>
      <td>
        <xsl:value-of select="../@kvnr"/>
      </td>
      <td>
        <xsl:value-of select="id(@art)/@name"/>
      </td>
      <td>
        <xsl:value-of select="../kasse"/>
      </td>
      <td>
        <xsl:value-of select="id(@art)/preis[@kk = current()/../kasse]"/>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="@datum">
    <td>
      <xsl:value-of select="concat(substring(.,9,2),'.',substring(.,6,2),'.')"/>
    </td>
  </xsl:template>
     
</xsl:stylesheet>
