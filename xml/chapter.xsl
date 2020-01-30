<?xml version="1.0" encoding="Windows-1251" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="Windows-1251" indent="no"/>


<xsl:template match="/">
	<html>
		<head>
			<link rel="stylesheet" href="styles.css"></link>
		</head>
		<body>
			<xsl:apply-templates/>
		</body>
	</html>
</xsl:template>

<xsl:template match="chapter">
	<xsl:apply-templates select="title"/>
	<xsl:apply-templates select="inscription"/>
	<xsl:apply-templates select="verse"/>
	<xsl:if test="@part=3 and @chapt=11"><xsl:apply-templates select="document('end33.xml')"/></xsl:if>
	<xsl:call-template name="seetoc"/>
</xsl:template>

<xsl:template match="verses">
	<xsl:apply-templates select="title"/>
	<xsl:apply-templates select="subtitle"/>
	<xsl:apply-templates select="verse | inscription"/>
	<xsl:if test="@part=3 and @chapt=11"><xsl:apply-templates select="document('end33.xml')"/></xsl:if>
	<xsl:call-template name="seetoc"/>
</xsl:template>

<xsl:template match="title">
	<p class="part">
		<xsl:choose>
			<xsl:when test="//chapter/@part=1">Чaсть №</xsl:when>
			<xsl:when test="//chapter/@part=2">Чaсть в7</xsl:when>
			<xsl:when test="//chapter/@part=3">Чaсть G</xsl:when>
		</xsl:choose>
	</p>
	<h1>
		<xsl:value-of  select="."/>
	</h1>
	<xsl:call-template name="seetoc"/>
</xsl:template>

<xsl:template name="seetoc">
	<p class="menu">
		<a>
			<xsl:attribute name="href"><xsl:call-template name="href"/></xsl:attribute>
			[Зри2 ўказaніе главaмъ]
		</a>
	</p>
</xsl:template>

<xsl:template match="verse">
	<p>
			<xsl:choose>
				<xsl:when test="position()=1">
					<xsl:apply-templates select="text()" mode="init"/>
				</xsl:when>
				<xsl:otherwise>
					<span class="number">
						<xsl:value-of select="@number"/>
					</span>&#160;
					<xsl:apply-templates/>
				</xsl:otherwise>
			</xsl:choose>
	</p>
</xsl:template>

<xsl:template match="verse/ref"><nobr>(<span class="ref"><xsl:value-of  select="."/></span>)</nobr></xsl:template>
<xsl:template match="verse/footnote"><span class="footnote">[<xsl:value-of select="."/>]</span></xsl:template>

<!--xsl:template match="verse/text()"><xsl:value-of select="."/></xsl:template-->
<xsl:template match="text()"><xsl:value-of select="."/></xsl:template>

<xsl:template match="text()" mode="init">
	<xsl:if test="position()=1">
		<div class="init"><xsl:value-of select="substring(., 1, 1)"/></div>
		<xsl:value-of select="substring(., 2)"/>
		<xsl:apply-templates select="following-sibling::node()"/>
	</xsl:if>
</xsl:template>

<xsl:template match="inscription">
	<p class="inscription">
		<xsl:value-of select="."/>
	</p>
</xsl:template>

<xsl:template match="subtitle">
	<p class="subtitle">
		<xsl:value-of select="."/>
	</p>
</xsl:template>


<!--xsl:template match="init"><div class="init"><xsl:value-of select="."/></div></xsl:template-->

<xsl:template match="p"><p><xsl:apply-templates/></p></xsl:template>
<xsl:template match="h2"><h2><xsl:value-of select="."/></h2></xsl:template>

<xsl:template name="href">
	<xsl:variable name="mode"><xsl:value-of select="document('config.xml')//transformation/@mode"/></xsl:variable>
	<xsl:choose>
		<xsl:when test="$mode = 'static'">book.html</xsl:when>
		<xsl:otherwise>../View.htm</xsl:otherwise>
	</xsl:choose>
	
</xsl:template>

</xsl:stylesheet>