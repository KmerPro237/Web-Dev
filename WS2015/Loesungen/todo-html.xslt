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

  <xsl:template match="todo">
    <!-- DOCTYPE per text ausgeben. Das ist unschön, aber es gibt derzeitig
         keine andere überzeugende Lösung. -->
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html>&#x0a;</xsl:text>

    <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="de" lang="de">
      <head>
        <meta charset="utf-8" />
        <title>Aufgaben</title>
        <style>
          .erledigt {
          font-style: italic
          }
          table, td, th {
          border: 1px solid black;
          }
        </style>
      </head>
      <body>
        <h1>Aufgaben</h1>
        <table>
          <thead>
            <th>Kategorie</th>
            <th>Aufgabe</th>
          </thead>
          <xsl:apply-templates select="kategorie">
            <xsl:sort select="@id"/>
          </xsl:apply-templates>
        </table>
      </body>
    </html>
  </xsl:template>

  <!-- Die beiden folgende Templates genügen als Lösung. -->

  <xsl:template match="kategorie">
    <tbody>
      <xsl:choose>
        <xsl:when test="count(aufgabe)=0">
          <tr>
            <td>
              <xsl:value-of select="@id"/>
            </td>
            <td>keine Aufgaben</td>
          </tr>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="aufgabe"/>
        </xsl:otherwise>
      </xsl:choose>   
    </tbody>
  </xsl:template>

  <xsl:template match="aufgabe">
    <tr>
      <xsl:if test="position()=1">
        <td rowspan="{count(../aufgabe)}">
          <xsl:value-of select="../@id"/>
        </td>
      </xsl:if>

      <td>
        <xsl:if test="@erledigt='ja'">
          <xsl:attribute name="class">
            <xsl:text>erledigt</xsl:text>
          </xsl:attribute>
        </xsl:if>
        <xsl:value-of select="@name"/>
      </td>
    </tr>
  </xsl:template>
  
</xsl:stylesheet>
