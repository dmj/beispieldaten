<xsl:transform version="3.0"
               xmlns:tei="http://www.tei-c.org/ns/1.0"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/">
    
    <!-- Alle in Frage kommenden Textknoten des Dokuments im ersten
         Schritt in einer Variable gespeichert. -->
    <xsl:variable name="textContent">
      <xsl:apply-templates/>
    </xsl:variable>

    <!-- Im zweiten Schritt werden die Textknoten zusammengefasst und
         der Leerraum normalisiert. -->
    <xsl:value-of select="normalize-space($textContent)"/>

  </xsl:template>

  <xsl:template match="@*"/>

  <xsl:template match="tei:teiHeader"/>
  <xsl:template match="tei:note"/>

</xsl:transform>
