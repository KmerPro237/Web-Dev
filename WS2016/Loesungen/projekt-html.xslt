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

  <xsl:template match="projekt">
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
        <h1>Protokolle zum <xsl:value-of select="@name"/></h1>
        <xsl:apply-templates select="besprechung"/>     
      </body>
    </html>
  </xsl:template>

  <xsl:template match="besprechung">
    <h2>Besprechung vom <xsl:value-of select="substring-before(@start,'T')"/></h2>
    <table>
      <tr>
        <td>Teilnehmer</td>
        <td>
          <xsl:value-of select="teilnehmer"/>
        </td>
      </tr>
        <tr>
        <td>Beginn</td>
        <td>
          <xsl:value-of select="substring-after(@start,'T')"/>
        </td>
      </tr>
    </table>
    <xsl:apply-templates select="top"/>
  </xsl:template>
  
  <!-- Nur die drei folgenden Templates sind zur Lösung der Aufgabe 3 erforderlich. -->

  <xsl:template match="top">
    
    <xsl:variable name="thema">
      <xsl:choose>
        <xsl:when test="@thema">
          <xsl:value-of select="@thema"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="id(@refTop)/@thema"/>
        </xsl:otherwise>     
      </xsl:choose>      
    </xsl:variable>

    <!-- oder 
    <xsl:variable name="thema">
      <xsl:choose>
        <xsl:when test="@refTop">
          <xsl:value-of select="//top[@id=current()/@refTop]/@thema"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@thema"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    -->
    
    
    <h3>TOP <xsl:number/>: <xsl:value-of select="$thema"/></h3>
      <ul>
        <xsl:apply-templates select="*"/>
      </ul>
  </xsl:template>

  <xsl:template match="aufgabe">
    <li>
      Aufgabe: <xsl:value-of select="."/> (<xsl:value-of select="@zugeteilt"/>)
    </li>
  </xsl:template>
  <xsl:template match="entscheidung">
    <li>
      Entscheidung: <xsl:value-of select="."/>
      <xsl:if test="@refAufgabe">
        (<xsl:value-of select="id(@refAufgabe)"/>)
        <!-- oder 
        (<xsl:value-of  select="//aufgabe[@id=current()/@refAufgabe]"/>)
        -->
      </xsl:if>
    </li>
  </xsl:template>
  
</xsl:stylesheet>
