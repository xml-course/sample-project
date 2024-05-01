<?xml version="1.0" encoding="utf-8"?>
<xsl:transform version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:inv="http://xmlcourse.free.bg/2019/invoice"
                exclude-result-prefixes="inv">

    <xsl:import href="_html_template.xsl" />
    <xsl:import href="_money.xsl" />

    <xsl:output method="html" doctype-system="about:legacy-compat" indent="yes" />

    <xsl:param name="invoice_id" />

    <xsl:template match="/">
        <html lang="bg">
            <xsl:call-template name="head">
                <xsl:with-param name="title">Детайли за фактура</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="body">
                <xsl:with-param name="content">
                    <xsl:apply-templates select="inv:invoice" />
                </xsl:with-param>
            </xsl:call-template>
        </html>
    </xsl:template>

    <xsl:template match="inv:invoice">
        <div class="py-3">
            <a class="text-decoration-none" href=".">
                Върни се към списъка с фактури
            </a>
        </div>
        <div class="row">
            <div class="col-6">
                <div class="card">
                    <div class="card-header fw-semibold">
                        Издадена на
                        <xsl:value-of select="inv:details/inv:issued" />
                    </div>
                    <div class="card-body">
                        <div class="card-text">
                            <table class="table text-center m-0">
                                <thead>
                                    <tr>
                                        <th>Услуга</th>
                                        <th>Стойност</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <xsl:apply-templates select="inv:charges/inv:services/inv:service" />
                                    <xsl:apply-templates select="inv:summary" />
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="card-footer">
                        <a href="{$invoice_id}?format=pdf" class="card-link text-decoration-none">
                            Свали в PDF формат
                        </a>
                        <a href="{$invoice_id}?format=csv" class="card-link text-decoration-none">
                            Свали в CSV формат
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="inv:service">
        <tr>
            <td>
                <xsl:value-of select="inv:name" />
            </td>
            <td>
                <xsl:call-template name="moneyAmount">
                    <xsl:with-param name="amount" select="inv:subtotal" />
                </xsl:call-template>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="inv:summary">
        <tr>
            <td class="text-end">Данъчна основа</td>
            <td>
                <xsl:call-template name="moneyAmount">
                    <xsl:with-param name="amount" select="inv:subtotal" />
                </xsl:call-template>
            </td>
        </tr>

        <xsl:apply-templates select="inv:taxes/inv:tax" />

        <tr>
            <td class="border-bottom-0 fw-bold text-end">Обща стойност</td>
            <td class="border-bottom-0 fw-bold ">
                <xsl:call-template name="moneyAmount">
                    <xsl:with-param name="amount" select="inv:total" />
                </xsl:call-template>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="inv:tax">
        <tr>
            <td class="text-end">
                <xsl:value-of select="inv:name" />

                <xsl:if test="inv:rate">
                    <xsl:call-template name="taxRate">
                        <xsl:with-param name="tax" select="." />
                    </xsl:call-template>
                </xsl:if>
            </td>
            <td>
                <xsl:call-template name="moneyAmount">
                    <xsl:with-param name="amount" select="inv:amount" />
                </xsl:call-template>
            </td>
        </tr>
    </xsl:template>

</xsl:transform>
