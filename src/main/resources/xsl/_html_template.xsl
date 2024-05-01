<?xml version="1.0" encoding="utf-8"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template name="head">
        <xsl:param name="title" />

        <head>
            <title>
                <xsl:value-of select="$title" />
                <xsl:text> - Акме облачни услуги</xsl:text>
            </title>

            <meta name="viewport" content="width=device-width, initial-scale=1" />

            <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
        </head>
    </xsl:template>

    <xsl:template name="body">
        <xsl:param name="content" />

        <body>
            <xsl:call-template name="header" />
            <xsl:call-template name="navigation" />

            <main class="container pt-3">
                <article>
                    <xsl:copy-of select="$content" />
                </article>
            </main>
        </body>
    </xsl:template>

    <xsl:template name="header">
        <header class="navbar navbar-expand-lg navbar-dark bg-dark">
            <nav class="container-fluid">
                <a href="#" class="navbar-brand">
                    Акме облачни услуги
                </a>
                <ul class="navbar-nav me-auto mb-2">
                    <li class="nav-item">
                        <a href="#" class="nav-link">Проекти</a>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="nav-link">Потребители</a>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="nav-link active">Плащания</a>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="nav-link">Поддръжка и помощ</a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a href="#" class="nav-link text-white">Изход</a>
                    </li>
                </ul>
            </nav>
        </header>
    </xsl:template>

    <xsl:template name="navigation">
        <nav class="navbar navbar-expand-lg bg-body shadow-sm">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="#">Текущо потребление</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Разплащателни средства</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="#">Фактури</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">История на плащанията</a>
                </li>
            </ul>
        </nav>
    </xsl:template>
</xsl:transform>
