<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:inv="http://xmlcourse.free.bg/2019/invoice">

    <xsl:output method="text" encoding="utf-8" media-type="text/csv" />

    <xsl:decimal-format name="european" decimal-separator="," grouping-separator="."/>

    <xsl:template match="/">
        <xsl:text>"Услуга","Продукт","Мярка","Количество","Единична цена","Стойност"</xsl:text>
        <xsl:text>&#10;</xsl:text>

        <xsl:apply-templates select="inv:invoice/inv:charges/inv:services/inv:service/inv:items/inv:item" />
        <xsl:apply-templates select="inv:invoice/inv:summary/inv:taxes/inv:tax" />
    </xsl:template>

    <xsl:template match="inv:item">
        <xsl:call-template name="quote_string">
            <xsl:with-param name="string_to_quote" select="ancestor::inv:service/inv:name" />
        </xsl:call-template>
        <xsl:text>,</xsl:text>
        <xsl:call-template name="quote_string">
            <xsl:with-param name="string_to_quote" select="inv:description" />
        </xsl:call-template>
        <xsl:text>,</xsl:text>
        <xsl:call-template name="quote_string">
            <xsl:with-param name="string_to_quote" select="inv:unit" />
        </xsl:call-template>
        <xsl:text>,</xsl:text>
        <xsl:call-template name="number">
            <xsl:with-param name="num" select="inv:usage" />
        </xsl:call-template>
        <xsl:text>,</xsl:text>
        <xsl:call-template name="number">
            <xsl:with-param name="num" select="inv:unit_price" />
        </xsl:call-template>
        <xsl:text>,</xsl:text>
        <xsl:call-template name="number">
            <xsl:with-param name="num" select="inv:amount" />
        </xsl:call-template>

        <xsl:text>&#10;</xsl:text>
    </xsl:template>

    <xsl:template match="inv:tax">
        <xsl:text>"Данък",</xsl:text>
        <xsl:call-template name="quote_string">
            <xsl:with-param name="string_to_quote" select="inv:name" />
        </xsl:call-template>
        <xsl:text>,</xsl:text>
        <xsl:choose>
            <xsl:when test="inv:rate">
                <xsl:text>"процент",</xsl:text>
                <xsl:call-template name="number">
                    <xsl:with-param name="num" select="inv:rate" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>,</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>,,</xsl:text>
        <xsl:call-template name="number">
            <xsl:with-param name="num" select="inv:amount" />
        </xsl:call-template>

        <xsl:text>&#10;</xsl:text>
    </xsl:template>

    <xsl:template name="quote_string">
        <xsl:param name="string_to_quote" />

        <xsl:variable name="striped_string">
            <xsl:value-of select="translate($string_to_quote, '&quot;', '')" />
        </xsl:variable>

        <xsl:value-of select="concat('&quot;', $striped_string ,'&quot;')" />
    </xsl:template>

    <xsl:template name="number">
        <xsl:param name="num" />

        <xsl:if test="$num">
            <xsl:call-template name="quote_string">
                <xsl:with-param name="string_to_quote" select="format-number($num, '0,00', 'european')" />
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
