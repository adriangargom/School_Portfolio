<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">

    <html>
        <!--Head-->
        <head>
            <title>CoperAventura S.A.</title>
            <!--Set styles-->
            <style>
                .capcalera{    
                    background-color: orange;
                }
                .nom{
                    font-family: initial;
                    font-size: 20px;
                    font-weight: bold;
                    text-transform:uppercase;
                    color: mediumorchid;
                }
                .dades{
                    font-family: initial;
                    font-size: 15px;    
                    font-weight: bold;
                    text-align: center;
                    color: orange;
                    background-color: mediumorchid;
                }
                .mes{
                    font-family: initial;
                    font-size: 15px;    
                    font-weight: bold;
                    text-align: center;
                    text-transform:uppercase;
                    color: #FF0080;
                    background-color: #FFE4C4;
                }
                .dia{
                    font-family: verdana, sans-serif;
                    font-size: 15px; 
                    text-align: right;
                    font-weight: bold;
                    color: #8A8E27;
                }
                table{
                    border:4px solid;
                    margin:0 auto;
                }
                th{
                    font-family: verdana, sans-serif;
                    text-align: center;     
                    font-weight: bold;
                    background-color: goldenrod;
                    border:1px solid;
                }
                td{
                    border:1px solid;
                }
                a{
                    color: darkorange;
                }
            </style>
        </head>

        <!--Body-->
        <body>
            <!--Header 1-->
            <header class="capcalera">
                <span>
                    <img  alt="logoParc" width="50" height="50">
                        <xsl:attribute name="src">
                            <xsl:value-of select="parc/logo"/>
                        </xsl:attribute>
                    </img>
                </span>
                
                <span class="nom"><xsl:value-of select="parc/@nom"/></span>
                
            </header>

            <!--Header 2-->
            <header class="dades">
                Obrim del <xsl:value-of select="parc/dates/dataObertura"/> al <xsl:value-of select="parc/dates/dataTancament"/>
            </header>

            <!-- Buscamos el elemento mes con el atributo @nom igual a noviembre-->
            <xsl:for-each select="parc/horaris/mes[@nom = 'Novembre']">
        
                <!--Header 3-->
                <!--Generamos el header con el nombre del mes, en este caso Noviembre-->
                <header class="mes">
                    <xsl:value-of select="@nom"/>
                </header>

                <!--Section 1-->
                <!--Generamos la Section que va a almacenar la tabla del horario-->
                <section>
                    <table border ="1">

                        <!--Recorremos el periodo 1 del mes Noviembre-->
                        <tr>
                            <xsl:for-each select="periode[@diaInici = '1']/diaSetmana">
                                <th><xsl:value-of select="."/></th>
                            </xsl:for-each>
                        </tr>

                        <xsl:for-each select="periode">
                            <tr>
                                <xsl:for-each select="diaSetmana">
                                    <td>

                                        <div class="dia"><xsl:value-of select="@diaMes"/></div>

                                        <xsl:if test="@diaMes and not(@horaObertura) and not(@horaTancament)">
                                            <div>TANCAT</div>
                                        </xsl:if>
                                        <xsl:if test="@horaObertura and @horaTancament">
                                            <div>
                                                <xsl:value-of select="@horaObertura"/> - <xsl:value-of select="@horaTancament"/>
                                            </div>
                                        </xsl:if>
                                    </td>
                                </xsl:for-each>
                            </tr>
                        </xsl:for-each>
                    </table>
                </section>

            </xsl:for-each>

            <!--Footer 1-->
            <footer class="dades">

                <div><xsl:value-of select="parc/adreca"/></div>
                <div><xsl:value-of select="parc/ciutat"/>-<xsl:value-of select="parc/pais"/></div>

                <div>
                    web:
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="parc/paginaWeb"/>
                        </xsl:attribute>
                        <xsl:value-of select="parc/paginaWeb"/>
                    </a>
                </div>
            </footer>

        </body>
    </html>

</xsl:template>
</xsl:stylesheet>