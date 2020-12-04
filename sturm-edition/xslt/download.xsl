<xsl:transform version="3.0" expand-text="yes"
               xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:variable name="baseUrl" as="xs:string">https://sturm-edition.de/api/files/</xsl:variable>
  <xsl:variable name="dataDirectory" as="xs:string" select="resolve-uri('../daten/', static-base-uri())"/>

  <xsl:template match="/files">
    <xsl:for-each-group select="idno[@type = 'letter']" group-by="@key">

      <xsl:variable name="files" as="element(idno)+">
        <xsl:perform-sort select="current-group()">
          <xsl:sort select="@version" order="descending"/>
        </xsl:perform-sort>
      </xsl:variable>

      <xsl:variable name="mostRecentVersion" as="element(idno)" select="$files[1]"/>

      <xsl:variable name="sourceUrl" as="xs:string" select="resolve-uri($mostRecentVersion, $baseUrl)"/>
      <xsl:variable name="targetUrl" as="xs:string" select="resolve-uri($mostRecentVersion, $dataDirectory)"/>

      <xsl:choose>
        <xsl:when test="doc-available($sourceUrl)">
          <xsl:message>Downloading {$sourceUrl} to {$targetUrl}</xsl:message>
          <xsl:result-document href="{$targetUrl}" method="xml">
            <xsl:sequence select="doc($sourceUrl)"/>
          </xsl:result-document>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>Document {$sourceUrl} is not available</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each-group>

    <xsl:text>OK</xsl:text>
  </xsl:template>

</xsl:transform>
