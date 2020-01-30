<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="Windows-1251" indent="no"/>

<xsl:variable name="mode"><xsl:value-of select="document('config.xml')//transformation/@mode"/></xsl:variable>


<xsl:template match="book">
	<html>
		<head>
			<link rel="stylesheet" href="styles.css"/>
		</head>
		<body>
			<img style="float:left;" src="img/is517.jpg" width="150px"/>	
			<h1 class="book"><xsl:value-of select="title"/></h1>
			<p class="autor"><xsl:value-of select="autor"/></p>
			<xsl:apply-templates select="intro"/>
			<!--p class="menu" style="font-size:60%; margin-top:-10px;"-->
			<p>
				<a>
					<xsl:choose>
						<xsl:when test="$mode='static'"><xsl:attribute name="href">alph.html</xsl:attribute></xsl:when>
						<xsl:otherwise><xsl:attribute name="href">xml/alph.htm</xsl:attribute></xsl:otherwise>
					</xsl:choose>
					<!--[Ґлфави1тъ же сeй д¦0вный зри2 здЁ]-->
					<xsl:value-of select="document('alph.xml')//title"/>&#160;<xsl:value-of select="document('alph.xml')//subtitle"/>
				</a>
			</p>
			<xsl:apply-templates select="part"/>
			<xsl:apply-templates select="verses"/>
	</body>
	</html>
</xsl:template>

<xsl:template match="intro">
	<!--xsl:variable name="ref">xml/intro.htm#<xsl:value-of select="@file"/></xsl:variable-->
	<a>
		<xsl:choose>
			<xsl:when test="$mode='static'"><xsl:attribute name="href"><xsl:value-of select="document(@file)//intro/@fname"/>.html</xsl:attribute></xsl:when>
			<xsl:otherwise><xsl:attribute name="href">xml/intro.htm#<xsl:value-of select="@file"/></xsl:attribute></xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="document(@file)//intro/@title"/><br/>
	</a>
</xsl:template>

<xsl:template match="part">
	<h2>	
		<xsl:choose>
			<xsl:when test="@chapter_count=count(chapter|verses)"><xsl:attribute name="class">complete</xsl:attribute></xsl:when>
			<xsl:otherwise><xsl:attribute name="class">more</xsl:attribute></xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="@title"/>
	</h2>

	<ul class="toc">
		<xsl:apply-templates select="chapter|verses"/>
	</ul>
</xsl:template>

<xsl:template match="chapter">
	<xsl:variable name="showcount">true</xsl:variable>
	<xsl:variable name="src"><xsl:value-of select="@file"/></xsl:variable>
	<xsl:variable name="htmlname"><xsl:value-of select="substring-before($src, '.xml')"/>.html</xsl:variable>
	<li>
		<a>
			<xsl:choose>
				<xsl:when test="$mode = 'static'"><xsl:attribute name="href"><xsl:value-of select="$htmlname"/></xsl:attribute></xsl:when>
				<xsl:otherwise><xsl:attribute name="href">xml/chapter.htm#<xsl:value-of select="$src"/></xsl:attribute></xsl:otherwise>
			</xsl:choose>
			
			<xsl:value-of select="document($src)/chapter/title"/>.
		</a> 
		
		
		<xsl:choose>
			<xsl:when test="count(document($src)/chapter/verse)&lt;number(document($src)/chapter/@verse_cnt)">
				<span class="more"><xsl:value-of select="document($src)/chapter/inscription"/></span>
				
				<xsl:if test="$showcount='true'">
					<span style="font-family:arial; color:blue">&#160;<xsl:value-of select="count(document($src)/chapter/verse)"/></span>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="document($src)/chapter/inscription"/></xsl:otherwise>
		</xsl:choose>
			</li>
</xsl:template>

<xsl:template match="verses">
	<xsl:variable name="src"><xsl:value-of select="@file"/></xsl:variable>
	<xsl:variable name="htmlname"><xsl:value-of select="substring-before($src, '.xml')"/>.html</xsl:variable>
	<a>
		<xsl:choose>
			<xsl:when test="$mode='static'">
				<xsl:attribute name="href"><xsl:value-of select="$htmlname"/></xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="href">xml/chapter.htm#<xsl:value-of select="$src"/></xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
		<span class="versetitle"><xsl:value-of select="document($src)/verses/title"/></span>
	</a>
		&#160;
	<span class="versesubtitle"><xsl:value-of select="document($src)/verses/subtitle"/></span><br/>
</xsl:template>
</xsl:stylesheet>
