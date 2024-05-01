<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="_html_template.xsl" />

    <xsl:output method="html" doctype-system="about:legacy-compat" indent="yes" />

    <xsl:template match="/">
        <html lang="bg">
            <xsl:call-template name="head">
                <xsl:with-param name="title">Фактури</xsl:with-param>
            </xsl:call-template>

            <xsl:call-template name="body">
                <xsl:with-param name="content">
                    <xsl:apply-templates select="invoices" />
                </xsl:with-param>
            </xsl:call-template>
        </html>
    </xsl:template>

    <xsl:template match="invoices">
        <h2 class="py-3">
            Издадени фактури
        </h2>
        <div class="row">
            <div class="col">
                <table class="table text-center">
                    <thead>
                        <tr>
                            <th>Дата на издаване</th>
                            <th>Описание</th>
                            <th colspan="2" />
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:apply-templates select="invoice" />
                    </tbody>
                </table>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="invoice">
        <tr>
            <td>
                <xsl:value-of select="issued" />
            </td>
            <td>
                <xsl:value-of select="description" />
            </td>
            <td>
                <a href="{id}" class="text-decoration-none">
                    Прегледай
                </a>
            </td>
            <td>
                Свали:
                <a href="{id}?format=pdf" class="text-decoration-none">
                    PDF
                </a>
                |
                <a href="{id}?format=csv" class="text-decoration-none">
                    CSV
                </a>
            </td>
        </tr>
    </xsl:template>
</xsl:transform>
