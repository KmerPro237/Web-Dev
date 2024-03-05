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

  <xsl:template match="seminar">
    <!-- DOCTYPE per text ausgeben. Das ist unschön, aber es gibt derzeitig
         keine andere überzeugende Lösung. -->
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html>&#x0a;</xsl:text>

    <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="de" lang="de">
      <head>
        <meta charset="utf-8" />
        <title>
          <xsl:value-of select="@name"/>
        </title>
        <style>
          table, td, th {
          border: 1px solid black;
          }
        </style>
      </head>
      <body>
        <h1>Vortragsplan des Seminars <xsl:value-of select="@name"/></h1>
        <xsl:apply-templates select="vortragsplan"/>     
      </body>
    </html>
  </xsl:template>

  <xsl:template match="vortragsplan">
    <table>
      <thead>
        <tr>
          <td>Datum</td>
          <td>Zeit</td>
          <td>Studierende(r)</td>
          <td>Nr</td>
          <td>Thema</td>
          <td>Prio</td>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="vortrag"/>
      </tbody>
    </table>
  </xsl:template>
  
  <!-- Nur die drei folgenden Templates sind zur Lösung der Aufgabe 3 erforderlich. -->

  <xsl:template match="vortrag">
    <tr>
      <td>
        <xsl:if test="not(@datum=preceding-sibling::vortrag[1]/@datum)">
          <xsl:value-of select="@datum"/>
        </xsl:if>
      </td>
      <td>
        <xsl:value-of select="substring(@uhrzeit,1,5)"/>
      </td>
      <xsl:apply-templates select="id(@matrikel)"/>
      <xsl:apply-templates select="id(@thema)"/>
      <td>
        <xsl:value-of select="id(@matrikel)/wunsch[./@thema=current()/@thema]/@prio"/>
      </td>
    </tr>
  </xsl:template>
  
  <xsl:template match="stud">
    <td>
      <xsl:value-of select="concat(nachname,', ',vorname)"/>
    </td>
  </xsl:template>

  <xsl:template match="thema">
    <td>
      <xsl:value-of select="substring-after(@nr,'t')"/>
    </td>
    <td>
      <xsl:value-of select="."/>
    </td>
  </xsl:template>
     
</xsl:stylesheet>
