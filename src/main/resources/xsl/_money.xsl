<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:inv="http://xmlcourse.free.bg/2019/invoice">

    <xsl:template name="moneyAmount">
        <xsl:param name="amount" />

        <xsl:value-of select="$amount" />
        <xsl:text> </xsl:text>
        <xsl:value-of select="/inv:invoice/inv:details/inv:currency" />
    </xsl:template>

    <xsl:template name="taxRate">
        <xsl:param name="tax" />

        <xsl:text> </xsl:text>
        <xsl:value-of select="$tax/inv:rate" />
        <xsl:text>%</xsl:text>
    </xsl:template>

</xsl:stylesheet>