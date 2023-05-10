<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  version="1.0"
>
<xsl:output method="xml" indent="yes"/>

<xsl:template match="/">
<xsl:apply-templates select="//table"/>
</xsl:template>

<xsl:template match="table">
<attribList>
<xsl:apply-templates/>
</attribList>
</xsl:template>

<xsl:template match="tr">
<xsl:element name="attrib">
<xsl:attribute name="n">
  <xsl:value-of select="td[1]"/>
</xsl:attribute>

<xsl:attribute name="ident">
  <xsl:value-of select="substring-before(td[2],'=')"/>
</xsl:attribute>

<xsl:attribute name="gi">
  <xsl:value-of select="substring-before(substring-after(td[3],'&lt;'),'&gt;')"/>
</xsl:attribute>

<xsl:attribute name="class">
  <xsl:value-of select="substring-before(substring-after(td[3],'%'),';')"/>
</xsl:attribute>

<xsl:element name="current">
  <xsl:value-of select="td[4]"/>
</xsl:element>
<!--
<xsl:element name="edw79">
  <xsl:value-of select="td[5]"/>
</xsl:element>
<xsl:element name="edw86">
  <xsl:value-of select="td[6]"/>
</xsl:element>-->
<xsl:element name="datatype">
  <xsl:value-of select="td[5]"/>
</xsl:element>

<xsl:element name="vals">
  <xsl:value-of select="td[6]"/>
</xsl:element>

<xsl:element name="comments">
  <xsl:value-of select="td[7]"/>
</xsl:element>

<!--<xsl:element name="disposal"/>-->

</xsl:element>
</xsl:template>
</xsl:stylesheet>
