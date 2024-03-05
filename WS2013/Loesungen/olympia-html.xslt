<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
  <xsl:output
    encoding="utf-8"
    indent="yes"
    method="html" 
    omit-xml-declaration = "yes"
   />

  <xsl:template match="olympia">
    <!-- DOCTYPE per text ausgeben. Das ist unschön, aber es gibt derzeitig
         keine andere überzeugende Lösung. -->
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html>&#x0a;</xsl:text>

    <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="de" lang="de">
      <head>
        <meta charset="utf-8" />
        <title>Olympische Winterspiele</title>
        <style>
          table {
            border-collapse:collapse;
          }
          table, th, td {
            border: 1px solid black;
            padding: 2px;
          }
        </style>
      </head>
      <body>
        <h1>Wettkämpfe</h1>
        <xsl:apply-templates select="wettkämpfe/wettkampf">
          <xsl:sort select="@datum"/>
          <xsl:sort select="@geschlecht" order="descending"/>
        </xsl:apply-templates>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="wettkampf">
    <h2>
      <xsl:value-of select="@sportart"/>
      <xsl:if test="@geschlecht='w'"> (Damen) </xsl:if>
      <xsl:if test="@geschlecht='m'"> (Herren) </xsl:if>
      <xsl:value-of select="@datum"/>
    </h2>

    <table>
      <thead>
        <tr>
          <th>Rang</th>
          <th>Land</th>
          <th>Name</th>
          <th>Zeit/Punkte</th>
        </tr>
      </thead>
      <tbody>
    <xsl:apply-templates select="ergebnis"/>
      </tbody>
    </table>
  </xsl:template>

  <xsl:template match="ergebnis">
    <tr>
    <td>
      <xsl:choose>
        <xsl:when test="position()=1">Gold</xsl:when>
        <xsl:when test="position()=2">Silber</xsl:when>
        <xsl:when test="position()=3">Bronze</xsl:when>
        <xsl:otherwise>
          <xsl:number format="1."/>
        </xsl:otherwise>
      </xsl:choose>
    </td> 
    <!-- Das XML-Dokument muss die DTD verwenden, sonst funktioniert id() nicht. -->
    <xsl:apply-templates select="id(@sid)"/> 
    <!-- oder
          <xsl:value-of select="//sportler[@sid=current()/@sid]/@land"/>
          und analog für name, vorname
    -->
    <td>
      <xsl:value-of select="zeit|punkte"/>
    </td>
    </tr>
  </xsl:template>

  <xsl:template match="sportler">
    <td>
      <xsl:value-of select="@land"/>
    </td>
    <td>
      <xsl:value-of select="name"/>, <xsl:value-of select="vorname"/>
    </td>
  </xsl:template>

</xsl:stylesheet>
