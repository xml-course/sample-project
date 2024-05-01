<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:inv="http://xmlcourse.free.bg/2019/invoice"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    exclude-result-prefixes="inv">

    <xsl:import href="_money.xsl" />

    <xsl:output method="xml" encoding="utf-8" indent="yes" />

    <xsl:template match="/">
        <fo:root>
            <xsl:call-template name="layout" />

            <fo:page-sequence id="document-content" master-reference="master-page">
                <xsl:call-template name="header" />
                <xsl:call-template name="footer" />

                <fo:flow flow-name="xsl-region-body" font-size="12pt" font-family="Arial, DejaVu Sans" font-weight="normal">
                    <xsl:apply-templates select="inv:invoice" />
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template match="inv:invoice">
        <xsl:apply-templates select="inv:details" />
        <xsl:apply-templates select="inv:charges" />
        <xsl:apply-templates select="inv:summary" />
    </xsl:template>

    <xsl:template match="inv:details">
        <fo:block space-after="12pt">
            <fo:table table-layout="fixed" width="100%">
                <fo:table-column column-width="50%" />
                <fo:table-column column-width="50%"/>

                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block>Номер на документа</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>
                                <xsl:value-of select="inv:number" />
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block>Дата на издаване</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>
                                <xsl:value-of select="inv:issued" />
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block>Възникване на данъчното събитие</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>
                                <xsl:value-of select="inv:payment_due" />
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>

        <fo:block space-before="12pt" space-after="12pt">
            <fo:table table-layout="fixed" width="100%">
                <fo:table-column column-width="50%" />
                <fo:table-column column-width="50%" />

                <fo:table-header>
                    <fo:table-cell>
                        <fo:block font-weight="bold">Получател</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block font-weight="bold">Издател</fo:block>
                    </fo:table-cell>
                </fo:table-header>

                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell>
                            <xsl:call-template name="legalEntity">
                                <xsl:with-param name="entity" select="inv:for" />
                            </xsl:call-template>
                        </fo:table-cell>
                        <fo:table-cell>
                            <xsl:call-template name="legalEntity">
                                <xsl:with-param name="entity" select="inv:from" />
                            </xsl:call-template>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

    <xsl:template match="inv:charges">
        <fo:block space-before="12pt" space-after="12pt">
            <fo:table table-layout="fixed" width="100%">
                <fo:table-column column-width="40%" />
                <fo:table-column column-width="15%" />
                <fo:table-column column-width="15%" />
                <fo:table-column column-width="15%" />
                <fo:table-column column-width="15%" />

                <fo:table-header>
                    <fo:table-cell>
                        <fo:block font-weight="bold">Наименование на услугата</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block font-weight="bold">Мярка</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block font-weight="bold">Количество</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block font-weight="bold">Единична цена</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block font-weight="bold">Стойност</fo:block>
                    </fo:table-cell>
                </fo:table-header>
                <fo:table-body>
                    <xsl:apply-templates select="inv:services/inv:service/inv:items/inv:item" />
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

    <xsl:template match="inv:item">
        <fo:table-row>
            <fo:table-cell>
                <fo:block>
                    <xsl:value-of select="ancestor::inv:service/inv:name" /> - <xsl:value-of select="inv:description" />
                </fo:block>
            </fo:table-cell>
            <fo:table-cell>
                <fo:block>
                    <xsl:value-of select="inv:unit" />
                </fo:block>
            </fo:table-cell>
            <fo:table-cell>
                <fo:block>
                    <xsl:value-of select="inv:usage" />
                </fo:block>
            </fo:table-cell>
            <fo:table-cell>
                <fo:block>
                    <xsl:if test="inv:unit_price">
                        <xsl:call-template name="moneyAmount">
                            <xsl:with-param name="amount" select="inv:unit_price" />
                        </xsl:call-template>
                    </xsl:if>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell>
                <fo:block>
                    <xsl:call-template name="moneyAmount">
                        <xsl:with-param name="amount" select="inv:amount" />
                    </xsl:call-template>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>

    <xsl:template match="inv:summary">
        <fo:block space-before="12pt" space-after="12pt">
            <fo:table table-layout="fixed" width="50%">
                <fo:table-column column-width="50%" />
                <fo:table-column column-width="50%" />

                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block>Данъчна основа</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>
                                <xsl:call-template name="moneyAmount">
                                    <xsl:with-param name="amount" select="inv:subtotal" />
                                </xsl:call-template>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <xsl:apply-templates select="inv:taxes/inv:tax" />
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block font-weight="bold">Обща стойност</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block font-weight="bold">
                                <xsl:call-template name="moneyAmount">
                                    <xsl:with-param name="amount" select="inv:total" />
                                </xsl:call-template>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

    <xsl:template match="inv:tax">
        <fo:table-row>
            <fo:table-cell>
                <fo:block>
                    <xsl:value-of select="inv:name" />

                    <xsl:if test="inv:rate">
                        <xsl:call-template name="taxRate">
                            <xsl:with-param name="tax" select="." />
                        </xsl:call-template>
                    </xsl:if>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell>
                <fo:block>
                    <xsl:call-template name="moneyAmount">
                        <xsl:with-param name="amount" select="inv:amount" />
                    </xsl:call-template>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>

    <xsl:template name="legalEntity">
        <xsl:param name="entity" />

        <fo:table table-layout="fixed" width="100%">
            <fo:table-column column-width="100%" />

            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="$entity/inv:name" />
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="$entity/inv:address" />
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="$entity/inv:city" />
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="$entity/inv:country" />
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>
                            ЕИК/ЕГН: <xsl:value-of select="$entity/inv:id" />
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:if test="$entity/inv:vat_id">
                                <xsl:value-of select="$entity/inv:vat_id" />
                            </xsl:if>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>

    <xsl:template name="layout">
        <fo:layout-master-set>
            <fo:simple-page-master master-name="master-page"
                                   page-height="29.7cm"
                                   page-width="21cm"
                                   margin-top="0.5cm"
                                   margin-bottom="0cm"
                                   margin-left="1cm"
                                   margin-right="1cm">

                <fo:region-body margin-top="1.5cm" margin-bottom="2cm" />
                <fo:region-before extent="1cm" />
                <fo:region-after extent="1cm" />
            </fo:simple-page-master>
        </fo:layout-master-set>
    </xsl:template>

    <xsl:template name="header">
        <fo:static-content flow-name="xsl-region-before" font-size="10pt" font-family="Arial, DejaVu Sans" font-weight="normal">
            <fo:block text-align="right">
                Фактура <xsl:value-of select="/inv:invoice/inv:details/inv:number" />
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="footer">
        <fo:static-content flow-name="xsl-region-after" font-size="10pt" font-family="Arial, DejaVu Sans" font-weight="normal">
            <fo:block text-align="right">
                Страница <fo:page-number /> от <fo:page-number-citation-last ref-id="document-content" />
            </fo:block>
        </fo:static-content>
    </xsl:template>

</xsl:stylesheet>
