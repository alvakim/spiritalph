<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="Windows-1251" indent="no"/>

	
	<xsl:template match="intro">
	<html>
		<head>
			<link rel="stylesheet" href="styles.css"></link>
		</head>
		<body>
			<h2><xsl:value-of select="@title"/></h2>
			<xsl:call-template name="seetoc"/>
			<xsl:apply-templates/>
			<xsl:call-template name="seetoc"/>
		</body>
	</html>
	</xsl:template>
	
	<xsl:template match="p">
		<p>		<!--xsl:apply-templates/-->
			<xsl:choose>
				<xsl:when test="position()=1">
					<xsl:apply-templates select="text()" mode="init"/>
				</xsl:when>
				<xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
			</xsl:choose>
		</p>	
	</xsl:template>
	
	<xsl:template match="text()" mode="init">
		<xsl:if test="position()=1">
			<div class="init"><xsl:value-of select="substring(., 1, 1)"/></div>
			<xsl:value-of select="substring(., 2)"/>
			<xsl:apply-templates select="following-sibling::node()"/>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="ref">
		<nobr>(<span class="ref"><xsl:value-of  select="."/></span>)</nobr>
	</xsl:template>

	<xsl:template name="seetoc">
		<p class="menu">
			<a>
				<xsl:attribute name="href"><xsl:call-template name="href"/></xsl:attribute>
				[Зри2 ўказaніе главaмъ]
			</a>
		</p>
	</xsl:template>
<xsl:template name="href">
	<xsl:variable name="mode"><xsl:value-of select="document('config.xml')//transformation/@mode"/></xsl:variable>
	<xsl:choose>
		<xsl:when test="$mode = 'static'">book.html</xsl:when>
		<xsl:otherwise>../View.htm</xsl:otherwise>
	</xsl:choose>
	
</xsl:template>
	
</xsl:stylesheet>
