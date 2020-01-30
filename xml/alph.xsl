<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="Windows-1251" indent="no"/>


<xsl:template match="alph">
	<html>
		<head>
			<link rel="stylesheet" href="styles.css"/>
		</head>
		<body>
			<xsl:apply-templates/>
			<xsl:call-template name="toc"/>
		</body>
	</html>
</xsl:template>

<xsl:template match="title"><h1><xsl:value-of select="."/></h1><xsl:call-template name="toc"/></xsl:template>
<xsl:template match="subtitle"><p class="subtitle"><xsl:value-of select="."/></p></xsl:template>
<xsl:template match="ref">(<span class="ref"><xsl:value-of select="."/></span>)</xsl:template>
<xsl:template match="footnote"><span class="footnote">[<xsl:value-of select="."/>]</span></xsl:template>


<xsl:template match="section">
<table border="0" cellpadding="5px" width="100%">
<tr>
	<td class="letter" width="58px" valign="top" align="center">
		<xsl:value-of select="@letter"/>
	</td>
	<td>
		<xsl:apply-templates select="p"/>
	</td>
</tr>
</table>
</xsl:template>

<xsl:template name="toc">
	<xsl:variable name="mode"><xsl:value-of select="document('config.xml')//transformation/@mode"/></xsl:variable>

	<p class="menu">
		<a>
			<xsl:choose>
				<xsl:when test="$mode='static'"><xsl:attribute name="href">book.html</xsl:attribute></xsl:when>
				<xsl:otherwise><xsl:attribute name="href">../View.htm</xsl:attribute></xsl:otherwise>
			</xsl:choose>
			[Зри2 ўказaніе главaмъ]
		</a>
	</p>
</xsl:template>

<xsl:template match="p"><p><xsl:apply-templates/></p></xsl:template>
<xsl:template match="text()"><xsl:value-of select="."/></xsl:template>
</xsl:stylesheet>
