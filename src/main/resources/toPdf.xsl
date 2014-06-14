<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text" version="1.0" encoding="UTF-8" indent="no" omit-xml-declaration="yes"/>
    <xsl:param name="pid" />

    <xsl:template match="/">
        <xsl:text>\documentclass[a4paper]{article}&#xa;</xsl:text>
        <xsl:text>\usepackage[utf8]{inputenc}&#xa;</xsl:text>
        <xsl:text>\usepackage[dvips]{graphicx,color} % or [pdftex]?&#xa;</xsl:text>
        <xsl:text>\usepackage[pdftex,colorlinks]{hyperref}&#xa;</xsl:text>
        <xsl:text>\usepackage{ae}&#xa;</xsl:text>
        <xsl:text>\usepackage[T1]{fontenc}&#xa;</xsl:text>
        <xsl:text>\usepackage{CV}&#xa;</xsl:text>
        <xsl:text>\usepackage{tabularx}&#xa;</xsl:text>

        <xsl:text>%\usepackage{doublespace}&#xa;</xsl:text>
        <xsl:text>%\setstretch{1.2}&#xa;</xsl:text>

        <xsl:text>\begin{document}&#xa;</xsl:text>

        <xsl:text>\pagestyle{empty}&#xa;</xsl:text>

        <xsl:text>%Ueberschrift&#xa;</xsl:text>
        <xsl:text>\begin{center}&#xa;</xsl:text>
        <xsl:text>\huge{\textsc{Curriculum Vitae}}&#xa;</xsl:text>
        <xsl:text>\vspace{\baselineskip}&#xa;</xsl:text>

        \Large{\textsc{<xsl:value-of select="profiles/profile[@pid=$pid]/contact/degree"/> <xsl:value-of select="profiles/profile[@pid=$pid]/contact/name"/>}}
        <xsl:text>\end{center}&#xa;</xsl:text>
        <xsl:text>\vspace{1.5\baselineskip}&#xa;</xsl:text>

        <xsl:text>\section{Address}&#xa;</xsl:text>

        <xsl:text>\begin{flushleft}&#xa;</xsl:text>
        <xsl:value-of select="profiles/profile[@pid=$pid]/contact/address/street"/> \\
        <xsl:value-of select="profiles/profile[@pid=$pid]/contact/address/postcode"/> <xsl:value-of select="profiles/profile[@pid=$pid]/contact/address/city"/> \\
        <xsl:value-of select="profiles/profile[@pid=$pid]/contact/country"/> \\
        Phone: <xsl:value-of select="profiles/profile[@pid=$pid]/contact/phone"/> \\
        Fax: <xsl:value-of select="profiles/profile[@pid=$pid]/contact/fax"/> \\
        Email: <xsl:value-of select="profiles/profile[@pid=$pid]/contact/email"/> \\
        Homepage: <xsl:value-of select="profiles/profile[@pid=$pid]/contact/homepage"/> \\
        <xsl:text>\end{flushleft}&#xa;</xsl:text>


        <xsl:text>\section{Personal Details}&#xa;</xsl:text>
        <xsl:text>\begin{flushleft}&#xa;</xsl:text>
        Gender: <xsl:value-of select="profiles/profile[@pid=$pid]/details/gender"/> \\
        Date of birth: <xsl:value-of select="profiles/profile[@pid=$pid]/details/birthDate"/> \\
        Place of birth: <xsl:value-of select="profiles/profile[@pid=$pid]/details/birthPlace"/> \\
        Present Citizenship: <xsl:value-of select="profiles/profile[@pid=$pid]/details/citizenship"/>
        <xsl:text>\end{flushleft}&#xa;</xsl:text>


        <xsl:text>\section{Education}&#xa;</xsl:text>

        <xsl:text>\begin{CV}&#xa;</xsl:text>
        \item[<xsl:value-of select="profiles/profile[@pid=$pid]/education/school[1]/from"/>--<xsl:value-of select="profiles/profile[@pid=$pid]/education/school[1]/to"/>] <xsl:value-of select="profiles/profile[@pid=$pid]/education/school[1]/@name"/>
        <xsl:apply-templates select="/profiles/profile[@pid=$pid]/education/school[2]" mode="school2" />
        <xsl:apply-templates select="/profiles/profile[@pid=$pid]/education/school[3]" mode="school3" />
        <xsl:text>\end{CV}&#xa;</xsl:text>

        <xsl:text>\pagebreak&#xa;</xsl:text>

        <xsl:apply-templates select="profiles/profile[@pid=$pid]/thesis" mode="thesis"/>

        <xsl:text>\section{Working Experience}&#xa;</xsl:text>

        <xsl:text>\begin{CV}&#xa;</xsl:text>

        \item[<xsl:value-of select="profiles/profile[@pid=$pid]/experience/job[1]/from"/>--<xsl:value-of select="profiles/profile[@pid=$pid]/experience/job[1]/to"/>] <xsl:value-of select="profiles/profile[@pid=$pid]/experience/job[1]/@name"/>

        <xsl:apply-templates select="/profiles/profile[@pid=$pid]/experience/job[2]" mode="job2" />

        <xsl:apply-templates select="/profiles/profile[@pid=$pid]/experience/job[3]" mode="job3" />

        <xsl:text>\end{CV}&#xa;</xsl:text>


        <xsl:text>\section{Language Knowledge}&#xa;</xsl:text>
        <xsl:text>\begin{table}[h] %\centering&#xa;</xsl:text>
        <xsl:text>\begin{tabular}{p{2cm}>{\bfseries}p{2.5cm}p{3cm}}&#xa;</xsl:text>
        <xsl:text disable-output-escaping="yes">&amp; </xsl:text><xsl:value-of select="profiles/profile[@pid=$pid]/languages/language[1]/@name"/>  <xsl:text disable-output-escaping="yes">&amp; </xsl:text><xsl:value-of select="profiles/profile[@pid=$pid]/languages/language[1]/@knowledge"/> \\
        <xsl:text disable-output-escaping="yes">&amp; </xsl:text><xsl:value-of select="profiles/profile[@pid=$pid]/languages/language[2]/@name"/>  <xsl:text disable-output-escaping="yes">&amp; </xsl:text><xsl:value-of select="profiles/profile[@pid=$pid]/languages/language[2]/@knowledge"/> \\
        <xsl:apply-templates select="profiles/profile[@pid=$pid]/languages/language[3]/@name" mode="language3"/>
        <xsl:apply-templates select="profiles/profile[@pid=$pid]/languages/language[3]/@name" mode="language4"/>
        <xsl:text>\end{tabular}&#xa;</xsl:text>
        <xsl:text>\end{table}&#xa;</xsl:text>

        <xsl:text>\pagebreak&#xa;</xsl:text>

        <xsl:apply-templates select="profiles/profile[@pid=$pid]/reference" mode="reference"/>

        <xsl:text>\vspace{2\baselineskip}&#xa;</xsl:text>
        <xsl:text>\noindent Groningen, \today&#xa;</xsl:text>



        <xsl:text>\end{document}&#xa;</xsl:text>

        <xsl:text>%Tabellen&#xa;</xsl:text>
        <xsl:text>\begin{table}[htbp] \centering%&#xa;</xsl:text>
        <xsl:text>\begin{tabular}{lll}\hline\hline&#xa;</xsl:text>
        <xsl:text>1 &amp; 2 &amp; 3 \\ \hline&#xa;</xsl:text>
        <xsl:text>1 &amp; \multicolumn{2}{c}{2} \\&#xa;</xsl:text>
        <xsl:text>\hline&#xa;</xsl:text>
        <xsl:text>\end{tabular}&#xa;</xsl:text>
        <xsl:text>\caption{Titel\label{Tabelle: Label}}&#xa;</xsl:text>
        <xsl:text>\end{table}&#xa;</xsl:text>

    </xsl:template>

    <xsl:template match="profiles/profile[@pid=$pid]/education/school[2]" mode="school2">
        \item[<xsl:value-of select="profiles/profile[@pid=$pid]/education/school[2]/from"/>--<xsl:value-of select="profiles/profile[@pid=$pid]/education/school[2]/to"/>] <xsl:value-of select="profiles/profile[@pid=$pid]/education/school[2]/@name"/>
    </xsl:template>

    <xsl:template match="profiles/profile/education/school[3]" mode="school3">
        \item[<xsl:value-of select="profiles/profile[@pid=$pid]/education/school[3]/from"/>--<xsl:value-of select="profiles/profile[@pid=$pid]/education/school[3]/to"/>] <xsl:value-of select="profiles/profile[@pid=$pid]/education/school[3]/@name"/>
    </xsl:template>

    <xsl:template match="profiles/profile[@pid=$pid]/thesis" mode="thesis">
        <xsl:text>\section{Thesis}&#xa;</xsl:text>
        \noindent <xsl:value-of select="profiles/profile[@pid=$pid]/thesis"/>
    </xsl:template>

    <xsl:template match="profiles/profile[@pid=$pid]/experience/job[2]" mode="job2">
        \item[<xsl:value-of select="profiles/profile[@pid=$pid]/experience/job[2]/from"/>--<xsl:value-of select="profiles/profile[@pid=$pid]/experience/job[2]/to"/>] <xsl:value-of select="profiles/profile[@pid=$pid]/experience/job[2]/@name"/>
    </xsl:template>

    <xsl:template match="profiles/profile[@pid=$pid]/experience/job[3]" mode="job3">
        \item[<xsl:value-of select="profiles/profile[@pid=$pid]/experience/job[3]/from"/>--<xsl:value-of select="profiles/profile[@pid=$pid]/experience/job[3]/to"/>] <xsl:value-of select="profiles/profile[@pid=$pid]/experience/job[3]/@name"/>
    </xsl:template>

    <xsl:template match="profiles/profile[@pid=$pid]/languages/language[3]/@name" mode="language3">
        <xsl:text disable-output-escaping="yes">&amp; </xsl:text><xsl:value-of select="profiles/profile[@pid=$pid]/languages/language[3]/@name"/> <xsl:text disable-output-escaping="yes">&amp; </xsl:text><xsl:value-of select="profiles/profile[@pid=$pid]/languages/language[3]/@knowledge"/>\\
    </xsl:template>

    <xsl:template match="profiles/profile[@pid=$pid]/languages/language[4]/@name" mode="language4">
        <xsl:text disable-output-escaping="yes">&amp; </xsl:text><xsl:value-of select="profiles/profile[@pid=$pid]/languages/language[4]/@name"/> <xsl:text disable-output-escaping="yes">&amp; </xsl:text><xsl:value-of select="profiles/profile[@pid=$pid]/languages/language[4]/@knowledge"/> \\
    </xsl:template>

    <xsl:template match="profiles/profile[@pid=$pid]/reference" mode="reference">
        <xsl:text>\section{References}</xsl:text>

        <xsl:text>\begin{table}[h]&#xa;</xsl:text>
        <xsl:text>\begin{tabular}{@{}lll@{}}&#xa;</xsl:text>
        \textbf{<xsl:value-of select="profiles/profile[@pid=$pid]/reference/contact/degree"/> <xsl:value-of select="profiles/profile[@pid=$pid]/reference/contact/name"/>} \\
        <xsl:value-of select="profiles/profile[@pid=$pid]/reference/relationship"/> <xsl:text disable-output-escaping="yes">&amp; Phone: &amp; </xsl:text><xsl:value-of select="profiles/profile[@pid=$pid]/reference/contact/phone"/>\\
        <xsl:value-of select="profiles/profile[@pid=$pid]/reference/contact/address/street"/> <xsl:text disable-output-escaping="yes">&amp; Fax: &amp; </xsl:text><xsl:value-of select="profiles/profile[@pid=$pid]/reference/contact/fax"/>\\
        <xsl:value-of select="profiles/profile[@pid=$pid]/reference/contact/address/postcode"/> <xsl:value-of select="profiles/profile[@pid=$pid]/reference/contact/address/city"/> <xsl:text disable-output-escaping="yes">&amp; Email: &amp; </xsl:text><xsl:value-of select="profiles/profile[@pid=$pid]/reference/contact/email"/> \\
        <xsl:value-of select="profiles/profile[@pid=$pid]/reference/contact/address/country"/> \\
        <xsl:text>\end{tabular}&#xa;</xsl:text>
        <xsl:text>\end{table}&#xa;</xsl:text>
    </xsl:template>
</xsl:stylesheet>
