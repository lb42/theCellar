<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 exclude-result-prefixes="xs"
 version="2.0">
 
 <xsl:template match="/">
  <xsl:apply-templates select="//*:listBibl/*:bibl[@n]"/>
 </xsl:template>
 
 <xsl:template match="*:bibl">
  <xsl:variable name="fileName">
   <xsl:value-of select="@n"/>
  </xsl:variable>
  <xsl:variable name="idno">
   <xsl:value-of select="@xml:id"/>
  </xsl:variable>
  <xsl:variable name="theDocument">
   <xsl:value-of select="concat('https://raw.githubusercontent.com/lb42/theCellar/main/tcMins/',$fileName,'.xml')"/>
  </xsl:variable>
  <xsl:message>File: <xsl:value-of select="$fileName"/> </xsl:message>
<xsl:result-document href="{concat('web/', $fileName,'.html')}"> 
 <html>
   <head>
    <link rel="stylesheet" href="css/tei.css" media="screen" title="no title" />
    <link type="application/tei+xml" rel=""
     href='{$theDocument}'/>
    <script src="js/CETEI.js" ></script>
    <script type="text/javascript">
    <xsl:text>var ceteicean = new CETEI();
     ceteicean.shadowCSS = "http://teic.github.io/css/tei.css";
     ceteicean.getHTML5("</xsl:text>
     <xsl:value-of select='$theDocument'/>
     <xsl:text>",function(data) { 
      document.getElementsByTagName("body")[0].appendChild(data);
     });</xsl:text>
    </script>
    <title><xsl:value-of select='concat($idno, ": Minutes of the TEI Technical Council")'/></title>
   </head>
   <body>   
   </body>
  </html>
  </xsl:result-document>
 </xsl:template>
</xsl:stylesheet>