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

  <xsl:template match="fbwm">
    <!-- DOCTYPE per text ausgeben. Das ist unschön, aber es gibt derzeitig
         keine andere überzeugende Lösung. -->
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html>&#x0a;</xsl:text>

    <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="de" lang="de">
      <head>
        <meta charset="utf-8" />
        <title>Fußballweltmeisterschaft 2014</title>
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
        <h1>Spiele</h1>
        <xsl:apply-templates select="spiele/spiel">
          <xsl:sort select="@datum"/>
        </xsl:apply-templates>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="spiel">
    <h2>
      <xsl:value-of select="concat(@mannschaft1,'-',@mannschaft2,' ',@datum)"/>
    </h2>

    <xsl:variable name="tore" select="//spieleinsatz[@sid=current()/@id]/tor"/>
    
    <!-- oder
    <xsl:variable name="currentId" select="@id"/>
    <xsl:variable name="tore" select="//spieleinsatz[@sid=$currentId]/tor"/>
    -->
    

    <xsl:choose>
      <xsl:when test="count($tore) = 0">
        <h3>torlos</h3>
      </xsl:when>
      <xsl:otherwise>
        <h3>Tore</h3>
        <table>
          <thead>
            <tr>
              <th>Minute</th>
              <th>Land</th>
              <th>Spieler</th>
            </tr>
          </thead>
          <tbody>
            <xsl:apply-templates select="$tore">
              <xsl:sort select="@minute" data-type="number"/>
            </xsl:apply-templates>
          </tbody>
        </table>
      </xsl:otherwise>
    </xsl:choose>

    
  </xsl:template>

  <xsl:template match="tor">
    <tr>
      <td>
        <xsl:value-of select="@minute"/>
      </td>
      <td>
        <xsl:value-of select="../../../@name"/>
      </td>
      <td>
        <xsl:apply-templates select="../.."/>
        <xsl:if test="@elfmeter = 'ja'">
          <xsl:text> </xsl:text>(Elfmeter)
        </xsl:if>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="spieler">
      <xsl:value-of select="@vorname"/>
    <xsl:text> </xsl:text> <xsl:value-of select="@name"/>
  </xsl:template>

</xsl:stylesheet>
