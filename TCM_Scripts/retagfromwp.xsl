<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:t="http://www.tei-c.org/ns/1.0" 
      exclude-result-prefixes="xs" version="2.0">
 
 <xsl:variable name="today">
        <xsl:value-of select="format-date(current-date(), '[Y0001]-[M01]-[D01]')"/>
    </xsl:variable> 
 
 <xsl:variable name="inputFile">
        <xsl:value-of select="tokenize(base-uri(.), '/')[last()]"/>       
    </xsl:variable>  
 
 <xsl:variable name="docNumber">
  <xsl:value-of select="substring-before($inputFile,'_')"/>
 </xsl:variable>
 
 <xsl:variable name="wpNumber">
  <xsl:value-of select="substring-before(substring-after($inputFile,'_'),'.xml')"/>
 </xsl:variable>
   <xsl:variable name="mainTitle">
       <xsl:value-of select="//header/h1[starts-with(@class,'entry-title')]"/>
   </xsl:variable>
  
  <xsl:variable name="idno">
   <xsl:value-of select="document('/home/lou/Public/theCellar/tcMins/tcm-catalogue.xml')//*:bibl[*:meeting[@n=$docNumber]]/@xml:id"/>
  </xsl:variable>
  
    <!-- contains a template for each element type found in the wpressXML -->
    
    <xsl:template match="/">
 
    
        <xsl:processing-instruction name="xml-stylesheet">
href="/home/lou/Public/TEI/TEICSS/tei.css" type="text/css"
 </xsl:processing-instruction>
        <xsl:message>Processing  <xsl:value-of select="$inputFile"/>  =   <xsl:value-of select="$idno"/>
         (<xsl:value-of select="$mainTitle"/>)
        </xsl:message>
        <TEI xmlns="http://www.tei-c.org/ns/1.0" n="{$docNumber}">
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>Minutes of the TEI Technical Council</title> 
                    <xsl:copy-of select="document('../tcMins/tcm-catalogue.xml')//*:meeting[@n=$docNumber]"/>
                    </titleStmt>
                    <publicationStmt>
                        <distributor>TEI Website</distributor>
                        <idno><xsl:value-of select="$idno"/></idno>
                    </publicationStmt>
                    <sourceDesc>
                        <p>Retagged from a WordPress HTML file</p>
                    </sourceDesc>
                </fileDesc>
                <revisionDesc>
                    <change when="{$today}">Archival header confected</change>
                    <change>Extracted from Word Press article with id post-<xsl:value-of select="$wpNumber"/> </change>
                </revisionDesc>
            </teiHeader>
            <text ><xsl:apply-templates/></text>
        </TEI>
    </xsl:template>


    <xsl:template match="a">
        <!-- 3072 -->
     <xsl:if test="@href">
        <ref target="{@href}">
            <xsl:apply-templates/>
        </ref></xsl:if>
    </xsl:template>
    <xsl:template match="add">
        <!-- 1 -->
        <xsl:apply-templates/>
    </xsl:template>
    <!--<xsl:template match='alternate'>
<!-\- 1 -\->
<xsl:apply-templates/>
</xsl:template>-->
    <xsl:template match="anchor"/>
    <!-- 7 -->

    <xsl:template match="appinfo"/>
    <!-- 15 -->
    <xsl:template match="application"/>
    <!-- 15 -->
    <xsl:template match="article">
        <!-- 120 -->
        <body>
        <xsl:apply-templates select="./div[@class='entry-content']"/>
        </body>
    </xsl:template>
    
    <xsl:template match="att">
        <!-- 285 -->
        <att>
            <xsl:apply-templates/>
        </att>
    </xsl:template>
    <!--<xsl:template match='author'>
<!-\- 25 -\->
<xsl:apply-templates/>
</xsl:template>-->
    <!--<xsl:template match='availability'>
<!-\- 6 -\->
<xsl:apply-templates/>
</xsl:template>-->
    <xsl:template match="b">
        <!-- 820 -->
        <hi style="b">
            <xsl:apply-templates/>
        </hi>
    </xsl:template>
    <xsl:template match="bibl">
        <!-- 1 -->
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="br"/>
    <!-- 2 -->

    <!--<xsl:template match='change'>
<!-\- 37 -\->
<xsl:apply-templates/>
</xsl:template>-->
    <xsl:template match="closer">
        <!-- 1 -->
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="code">
        <!-- 34 -->
        <code>
            <xsl:apply-templates/>
        </code>
    </xsl:template>
    <xsl:template match="date">
        <!-- 69 -->
        <date>
            <xsl:apply-templates/>
        </date>
    </xsl:template>
    <xsl:template match="del">
        <!-- 8 --> [<xsl:apply-templates/>] </xsl:template>
    <!--<xsl:template match='distributor'>
<!-\- 11 -\->
<xsl:apply-templates/>
</xsl:template>-->
    <xsl:template match="div[contains(@class, 'cdata')]">
        
        <egXML xmlns="http://www.tei-c.org/ns/Examples">
            <xsl:copy-of select="."/>
        </egXML>
    </xsl:template>
    
    <xsl:template match="div">
        <!-- 801 -->
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
 
 
 <xsl:param name="prefix" as="xs:string" select="'h'"/>
 <xsl:param name="max-level" as="xs:integer" select="6"/>
 
 <xsl:function name="t:group" as="node()*">
  <xsl:param name="nodes" as="node()*"/>
  <xsl:param name="level" as="xs:integer"/>
  <xsl:for-each-group select="$nodes" group-starting-with="*[local-name() eq concat($prefix, $level)]">
   <xsl:choose>
    <xsl:when test="self::*[local-name() eq concat($prefix, $level)]">
     <div type="{local-name()}">
      <xsl:apply-templates select="."/>
      <xsl:sequence select="t:group(current-group() except ., $level + 1)"/>
     </div>
    </xsl:when>
    <xsl:when test="$level lt $max-level">
     <xsl:sequence select="t:group(current-group(), $level + 1)"/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:apply-templates select="current-group()"/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:for-each-group>
 </xsl:function>
 
 <xsl:template match="@* | node()">
  <xsl:copy>
   <xsl:apply-templates select="@* , node()"/>
  </xsl:copy>
 </xsl:template>

 <xsl:template match="*[h1 | h2 | h3 | h4 | h5 | h6]">
  <xsl:copy>
   <xsl:sequence select="t:group(*, 1)"/>
  </xsl:copy>
 </xsl:template>
 
 <!--
 
    
    <xsl:template match="div[@class='entry-content']">
     <xsl:choose>
      <xsl:when test="h2">
       <xsl:for-each-group select="*" group-starting-with="h2">              
        <div type="h2">
         <xsl:for-each select="current-group()">
          <xsl:apply-templates select="."/>
         </xsl:for-each>
        </div>        
       </xsl:for-each-group>
      </xsl:when>
      <xsl:when test="h3">
       <xsl:for-each-group select="*" group-starting-with="h3">              
        <div type="h3">
         <xsl:for-each select="current-group()">
          <xsl:apply-templates select="."/>
         </xsl:for-each>
        </div>        
       </xsl:for-each-group>
      </xsl:when>
      
      <xsl:otherwise>
       <xsl:comment>No h2 or h3 subheadings found within body</xsl:comment>
       <xsl:apply-templates/>
      </xsl:otherwise>
     </xsl:choose>
      
     
    </xsl:template>
 
 <xsl:template match="h3">
  <xsl:for-each-group select="*" group-starting-with="h3">              
   <div type="h3">
    <xsl:for-each select="current-group()">
     <xsl:apply-templates select="."/>
    </xsl:for-each>
   </div>        
  </xsl:for-each-group>
 </xsl:template>
 
 <xsl:template match="h4">
  <xsl:for-each-group select="*" group-starting-with="h4">              
   <div type="h4">
    <xsl:for-each select="current-group()">
     <xsl:apply-templates select="."/>
    </xsl:for-each>
   </div>        
  </xsl:for-each-group>
 </xsl:template>
 -->
    
    <xsl:template match="divgen"/>
    <!-- 1 -->
    <!--
<xsl:template match='doctitle'>
<!-\- 3 -\->
<xsl:apply-templates/>
</xsl:template>
<xsl:template match='edition'>
<!-\- 23 -\->
<xsl:apply-templates/>
</xsl:template>
<xsl:template match='editionstmt'>
<!-\- 23 -\->
<xsl:apply-templates/>
</xsl:template>-->
    <xsl:template match="egxml">
        <!-- 5 -->
     <egXML xmlns="http://www.tei-c.org/ns/Examples">
      <xsl:copy-of select="."/>
    </egXML>
    </xsl:template>
    <!--<xsl:template match='elementref'>
<!-\- 4 -\->
<xsl:apply-templates/>
</xsl:template>
<xsl:template match='elementspec'>
<!-\- 1 -\->
<xsl:apply-templates/>
</xsl:template>-->
    <xsl:template match="emph">
        <!-- 47 -->
        <emph>
            <xsl:apply-templates/>
        </emph>
    </xsl:template>
    <!--<xsl:template match='encodingdesc'>
<!-\- 15 -\->
<xsl:apply-templates/>
</xsl:template>
<xsl:template match='filedesc'>
<!-\- 38 -\->
<xsl:apply-templates/>
</xsl:template>-->
    <xsl:template match="foreign">
        <!-- 2 -->
        <foreign>
            <xsl:apply-templates/>
        </foreign>
    </xsl:template>
    <xsl:template match="front"/>
    <!-- 8 -->

    <xsl:template match="gi">
        <!-- 2708 -->
        <gi>
            <xsl:apply-templates/>
        </gi>
    </xsl:template>
  <xsl:template match="h1 | h2 | h3 | h4 | h5 | h6">
         <head>
          <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </head>
    </xsl:template>
 <xsl:template match="@id">
  <xsl:attribute name="xml:id">
   <xsl:value-of select="."/>
  </xsl:attribute>
 </xsl:template>
    <xsl:template match="head">
        <head>
            <xsl:apply-templates/>
        </head>
    </xsl:template>
 
    <xsl:template match='header'>
<xsl:comment>
<xsl:apply-templates/></xsl:comment>
</xsl:template>
 
    <xsl:template match="hi[@class]">
        <!-- 1001 -->
        <hi style="{@class}">
            <xsl:apply-templates/>
        </hi>
    </xsl:template>
    <xsl:template match="hi[not(@class)]">
        <!-- 1001 -->
        <hi>
            <xsl:apply-templates/>
        </hi>
    </xsl:template>
    <xsl:template match="hr">
        <!-- 120 -->
        <milestone unit="unknown" rend="rule"/>
    </xsl:template>
    <xsl:template match="i">
        <!-- 55 -->
        <hi style="i">
            <xsl:apply-templates/>
        </hi>
    </xsl:template>
    <xsl:template match="ident">
        <!-- 34 -->
        <ident>
            <xsl:apply-templates/>
        </ident>
    </xsl:template>
    <!--<xsl:template match='idno'>
<!-\- 12 -\->
<xsl:apply-templates/>
</xsl:template>-->
    <xsl:template match="item | li">
        <!-- 14 -->
        <item>
            <xsl:apply-templates/>
        </item>
    </xsl:template>
    <xsl:template match="label">
        <!-- 397 -->
        <label>
            <xsl:apply-templates/>
        </label>
    </xsl:template>
    <xsl:template match="lb">
        <!-- 36 -->
        <lb/>
    </xsl:template>

    
    <!--<xsl:template match='listchange'>
<!-\- 15 -\->
<xsl:apply-templates/>
</xsl:template>-->
    <xsl:template match="mentioned">
        <!-- 7 -->
        <mentioned>
            <xsl:apply-templates/>
        </mentioned>
    </xsl:template>
    <xsl:template match="meta"/>
    <!-- <!-\- 2 -\->
        <xsl:apply-templates/>
    </xsl:template>-->
    <!--<xsl:template match="mixedcontent">
        <!-\- 1 -\->
        <xsl:apply-templates/>
    </xsl:template>
  -->
    <xsl:template match="name">
        <!-- 31 -->
        <name>
            <xsl:apply-templates/>
        </name>
    </xsl:template>
    <xsl:template match="note">
        <!-- 32 -->
        <note>
            <xsl:apply-templates/>
        </note>
    </xsl:template>
    <xsl:template match="ol">
        <!-- 31 -->
        <list style="ol">
            <xsl:apply-templates/>
        </list>
    </xsl:template>
    <xsl:template match="p">
        <!-- 3178 -->
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
 
 <xsl:template match="p[@class='listhead']">
  <p rend="head">
   <xsl:apply-templates/>
  </p>
 </xsl:template>
 
   <xsl:template match="p[string-length(.) lt 1]"/>
 
    <!--<xsl:template match="p[label]">     
            <xsl:apply-templates/>
    </xsl:template>
    -->
    <xsl:template match="pb">
        <pb/>
        <!-- <!-\- 1 -\->
        <xsl:apply-templates/>-->
    </xsl:template>
    <xsl:template match="pre">
        <!-- 16 -->
       <!-- <egXML xmlns="http://www.tei-c.org/ns/Examples">
            <xsl:apply-templates/>
        </egXML>-->
     <p rend="pre"><xsl:apply-templates/></p>
    </xsl:template>
    <!--<xsl:template match="process">
        <!-\- 1 -\->
        <xsl:apply-templates/>
    </xsl:template>-->
    <xsl:template match="ptr">
        <!-- 7 -->
        <ref target="{@target}"/>
    </xsl:template>
    <!--<xsl:template match="publicationstmt">
        <!-\- 38 -\->
        <xsl:apply-templates/>
    </xsl:template>-->
    <!--<xsl:template match="punct">
        <!-\- 1 -\->
        <xsl:apply-templates/>
    </xsl:template>-->
    <xsl:template match="q">
        <!-- 38 -->
        <q>
            <xsl:apply-templates/>
        </q>
    </xsl:template>
    <xsl:template match="quote">
        <!-- 3 -->
        <quote>
            <xsl:apply-templates/>
        </quote>
    </xsl:template>
    <!-- <xsl:template match="resp">
        <!-\- 8 -\->
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="respstmt">
        <!-\- 8 -\->
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="revisiondesc">
        <!-\- 32 -\->
        <xsl:apply-templates/>
    </xsl:template>-->
    <!-- <xsl:template match="salute">
        <!-\- 2 -\->
        <xsl:apply-templates/>
    </xsl:template>-->
    <xsl:template match="seg[@class]">
        <!-- 15 -->
        <hi style="{@class}">
            <xsl:apply-templates/>
        </hi>
    </xsl:template>
    <!-- <xsl:template match="signatory">
        <!-\- 1 -\->
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="signed">
        <!-\- 2 -\->
        <xsl:apply-templates/>
    </xsl:template>-->
    <xsl:template match="socalled">
        <!-- 9 -->
        <soCalled>
            <xsl:apply-templates/>
        </soCalled>
    </xsl:template>
    <!--<xsl:template match="sourcedesc">
        <!-\- 38 -\->
        <xsl:apply-templates/>
    </xsl:template>-->
    <xsl:template match="sp">
        <!-- 188 -->
       <xsl:copy> <xsl:apply-templates/></xsl:copy>
    </xsl:template>
    <xsl:template match="span">
        <!-- 1558 -->
        <xsl:apply-templates/>
    </xsl:template>
 <xsl:template match="span[contains(@class,'bold')]">
 <hi style="bold"> <xsl:apply-templates/></hi>
 </xsl:template>
    <xsl:template match="speaker">
        <!-- 188 -->
       <xsl:copy> <xsl:apply-templates/></xsl:copy>
    </xsl:template>
    <xsl:template match="strong">
        <!-- 283 -->
        <hi style="strong">
            <xsl:apply-templates/>
        </hi>
    </xsl:template>
    <xsl:template match="table">
        <!-- 73 -->
        <table>
            <xsl:apply-templates/>
        </table>
    </xsl:template>
    <xsl:template match="tbody">
        <!-- 56 -->
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="td">
        <!-- 4469 -->
        <cell>
            <xsl:apply-templates/>
        </cell>
    </xsl:template>
    <!-- <xsl:template match="tei">
        <!-\- 3 -\->
        <xsl:apply-templates/>
    </xsl:template>-->
    <xsl:template match="term">
        <!-- 4 -->
        <term>
            <xsl:apply-templates/>
        </term>
    </xsl:template>
    <!-- <xsl:template match="textnode">
        <!-\- 1 -\->
        <xsl:apply-templates/>
    </xsl:template>-->
    <xsl:template match="time">
        <!-- 4 -->
        <xsl:apply-templates/>
    </xsl:template>
    <!--<xsl:template match="title">
        <!-\- 45 -\->
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="titlepage">
        <!-\- 3 -\->
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="titlepart">
        <!-\- 3 -\->
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="titlestmt">
        <!-\- 38 -\->
        <xsl:apply-templates/>
    </xsl:template>-->
    <xsl:template match="tr">
        <!-- 1031 -->
        <row>
            <xsl:apply-templates/>
        </row>
    </xsl:template>
    <xsl:template match="tt">
        <!-- 3 -->
        <hi style="tt">
            <xsl:apply-templates/>
        </hi>
    </xsl:template>
    <xsl:template match=" ul">
        <!-- 483 -->
        <list style="ul">
            <xsl:apply-templates/>
        </list>
    </xsl:template>
    <!-- <xsl:template match="val">
        <!-\- 2 -\->
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="w">
        <!-\- 1 -\->
        <xsl:apply-templates/>
    </xsl:template>-->

</xsl:stylesheet>
