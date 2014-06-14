<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:param name="pid" />

    <xsl:template match="/">
        <xsl:text>\documentclass[a4paper]{article}</xsl:text>
        <xsl:text>\usepackage[utf8]{inputenc}&#xa;</xsl:text>
        <xsl:text>\usepackage[dvips]{graphicx,color} % or [pdftex]?</xsl:text>
        <xsl:text>\usepackage[pdftex,colorlinks]{hyperref}</xsl:text>
        <xsl:text>\usepackage{ae}</xsl:text>
        <xsl:text>\usepackage[T1]{fontenc}</xsl:text>
        <xsl:text>\usepackage{CV}</xsl:text>
        <xsl:text>\usepackage{tabularx}</xsl:text>

        <xsl:text>%\usepackage{doublespace}</xsl:text>
        <xsl:text>%\setstretch{1.2}</xsl:text>

        <xsl:text>\begin{document}</xsl:text>

        <xsl:text>\pagestyle{empty}</xsl:text>

        <xsl:text>%Ueberschrift</xsl:text>
        <xsl:text>\begin{center}</xsl:text>
        <xsl:text>\huge{\textsc{Curriculum Vitae}}</xsl:text>
        <xsl:text>\vspace{\baselineskip}</xsl:text>

        \Large{\textsc{<xsl:value-of select="profiles/profile[@pid=$pid]/contact/degree"/> <xsl:value-of select="profiles/profile[@pid=$pid]/contact/name"/>}}
        <xsl:text>\end{center}</xsl:text>
        <xsl:text>\vspace{1.5\baselineskip}</xsl:text>

        <xsl:text>\section{Address}</xsl:text>

        <xsl:text>\begin{flushleft}</xsl:text>
        <xsl:value-of select="profiles/profile[@pid=$pid]/contact/address/street"/> \\
        <xsl:value-of select="profiles/profile[@pid=$pid]/contact/address/postcode"/> <xsl:value-of select="profiles/profile[@pid=$pid]/contact/address/city"/> \\
        <xsl:value-of select="profiles/profile[@pid=$pid]/contact/country"/> \\
        Phone: <xsl:value-of select="profiles/profile[@pid=$pid]/contact/phone"/> \\
        Fax: <xsl:value-of select="profiles/profile[@pid=$pid]/contact/fax"/> \\
        Email: <xsl:value-of select="profiles/profile[@pid=$pid]/contact/email"/> \\
        Homepage: <xsl:value-of select="profiles/profile[@pid=$pid]/contact/homepage"/> \\
        <xsl:text>\end{flushleft}</xsl:text>


        <xsl:text>\section{Personal Details}</xsl:text>
        <xsl:text>\begin{flushleft}</xsl:text>
        Gender: <xsl:value-of select="profiles/profile[@pid=$pid]/details/gender"/> \\
        Date of birth: <xsl:value-of select="profiles/profile[@pid=$pid]/details/birthDate"/> \\
        Place of birth: <xsl:value-of select="profiles/profile[@pid=$pid]/details/birthPlace"/> \\
        Present Citizenship: <xsl:value-of select="profiles/profile[@pid=$pid]/details/citizenship"/>
        <xsl:text>\end{flushleft}</xsl:text>


        <xsl:text>\section{Education}</xsl:text>

        <xsl:text>\begin{CV}</xsl:text>
        \item[<xsl:value-of select="profiles/profile[@pid=$pid]/education/school[1]/from"/>--<xsl:value-of select="profiles/profile[@pid=$pid]/education/school[1]/to"/>] <xsl:value-of select="profiles/profile[@pid=$pid]/education/school[1]/@name"/>
        <xsl:apply-templates select="/profiles/profile[@pid=$pid]/education/school[2]" mode="school2" />
        <xsl:apply-templates select="/profiles/profile[@pid=$pid]/education/school[3]" mode="school3" />
        <xsl:text>\end{CV}</xsl:text>

        <xsl:text>\pagebreak</xsl:text>

        <xsl:apply-templates select="profiles/profile[@pid=$pid]/thesis" mode="thesis"/>

        <xsl:text>\section{Working Experience}</xsl:text>

        <xsl:text>\begin{CV}</xsl:text>

        \item[<xsl:value-of select="profiles/profile[@pid=$pid]/experience/job[1]/from"/>--<xsl:value-of select="profiles/profile[@pid=$pid]/experience/job[1]/to"/>] <xsl:value-of select="profiles/profile[@pid=$pid]/experience/job[1]/@name"/>

        <xsl:apply-templates select="/profiles/profile[@pid=$pid]/experience/job[2]" mode="job2" />

        <xsl:apply-templates select="/profiles/profile[@pid=$pid]/experience/job[3]" mode="job3" />

        <xsl:text>\end{CV}</xsl:text>


        <xsl:text>\section{Language Knowledge}</xsl:text>
        <xsl:text>\begin{table}[h] %\centering</xsl:text>
        <xsl:text>\begin{tabular}{p{2cm}>{\bfseries}p{2.5cm}p{3cm}}</xsl:text>
        &amp; <xsl:value-of select="profiles/profile[@pid=$pid]/languages/language[1]/@name"/>  &amp; <xsl:value-of select="profiles/profile[@pid=$pid]/languages/language[1]/@knowledge"/> \\
        &amp; <xsl:value-of select="profiles/profile[@pid=$pid]/languages/language[2]/@name"/>  &amp; <xsl:value-of select="profiles/profile[@pid=$pid]/languages/language[2]/@knowledge"/> \\
        <xsl:apply-templates select="profiles/profile[@pid=$pid]/languages/language[3]/@name" mode="language3"/>
        <xsl:apply-templates select="profiles/profile[@pid=$pid]/languages/language[3]/@name" mode="language4"/>
        <xsl:text>\end{tabular}</xsl:text>
        <xsl:text>\end{table}</xsl:text>

        <xsl:text>\pagebreak</xsl:text>

        <xsl:apply-templates select="profiles/profile[@pid=$pid]/reference" mode="reference"/>

        <xsl:text>\vspace{2\baselineskip}</xsl:text>
        <xsl:text>\noindent Groningen, \today</xsl:text>



        <xsl:text>\end{document}</xsl:text>

        <xsl:text>%Tabellen</xsl:text>
        <xsl:text>\begin{table}[htbp] \centering%</xsl:text>
        <xsl:text>\begin{tabular}{lll}\hline\hline</xsl:text>
        <xsl:text>1 &amp; 2 &amp; 3 \\ \hline</xsl:text>
        <xsl:text>1 &amp; \multicolumn{2}{c}{2} \\</xsl:text>
        <xsl:text>\hline</xsl:text>
        <xsl:text>\end{tabular}</xsl:text>
        <xsl:text>\caption{Titel\label{Tabelle: Label}}</xsl:text>
        <xsl:text>\end{table}</xsl:text>

    </xsl:template>

    <xsl:template match="profiles/profile[@pid=$pid]/education/school[2]" mode="school2">
        \item[<xsl:value-of select="profiles/profile[@pid=$pid]/education/school[2]/from"/>--<xsl:value-of select="profiles/profile[@pid=$pid]/education/school[2]/to"/>] <xsl:value-of select="profiles/profile[@pid=$pid]/education/school[2]/@name"/>
    </xsl:template>

    <xsl:template match="profiles/profile/education/school[3]" mode="school3">
        \item[<xsl:value-of select="profiles/profile[@pid=$pid]/education/school[3]/from"/>--<xsl:value-of select="profiles/profile[@pid=$pid]/education/school[3]/to"/>] <xsl:value-of select="profiles/profile[@pid=$pid]/education/school[3]/@name"/>
    </xsl:template>

    <xsl:template match="profiles/profile[@pid=$pid]/thesis" mode="thesis">
        <xsl:text>\section{Thesis}</xsl:text>
        \noindent <xsl:value-of select="profiles/profile[@pid=$pid]/thesis"/>
    </xsl:template>

    <xsl:template match="profiles/profile[@pid=$pid]/experience/job[2]" mode="job2">
        \item[<xsl:value-of select="profiles/profile[@pid=$pid]/experience/job[2]/from"/>--<xsl:value-of select="profiles/profile[@pid=$pid]/experience/job[2]/to"/>] <xsl:value-of select="profiles/profile[@pid=$pid]/experience/job[2]/@name"/>
    </xsl:template>

    <xsl:template match="profiles/profile[@pid=$pid]/experience/job[3]" mode="job3">
        \item[<xsl:value-of select="profiles/profile[@pid=$pid]/experience/job[3]/from"/>--<xsl:value-of select="profiles/profile[@pid=$pid]/experience/job[3]/to"/>] <xsl:value-of select="profiles/profile[@pid=$pid]/experience/job[3]/@name"/>
    </xsl:template>

    <xsl:template match="profiles/profile[@pid=$pid]/languages/language[3]/@name" mode="language3">
        &amp; <xsl:value-of select="profiles/profile[@pid=$pid]/languages/language[3]/@name"/> &amp; <xsl:value-of select="profiles/profile[@pid=$pid]/languages/language[3]/@knowledge"/>\\
    </xsl:template>

    <xsl:template match="profiles/profile[@pid=$pid]/languages/language[4]/@name" mode="language4">
        &amp; <xsl:value-of select="profiles/profile[@pid=$pid]/languages/language[4]/@name"/> &amp; <xsl:value-of select="profiles/profile[@pid=$pid]/languages/language[4]/@knowledge"/> \\
    </xsl:template>

    <xsl:template match="profiles/profile[@pid=$pid]/reference" mode="reference">
        <xsl:text>\section{References}</xsl:text>

        <xsl:text>\begin{table}[h]</xsl:text>
        <xsl:text>\begin{tabular}{@{}lll@{}}</xsl:text>
        \textbf{<xsl:value-of select="profiles/profile[@pid=$pid]/reference/contact/degree"/> <xsl:value-of select="profiles/profile[@pid=$pid]/reference/contact/name"/>} \\
        <xsl:value-of select="profiles/profile[@pid=$pid]/reference/relationship"/> &amp; Phone: &amp; <xsl:value-of select="profiles/profile[@pid=$pid]/reference/contact/phone"/>\\
        <xsl:value-of select="profiles/profile[@pid=$pid]/reference/contact/address/street"/> &amp; Fax: &amp; <xsl:value-of select="profiles/profile[@pid=$pid]/reference/contact/fax"/>\\
        <xsl:value-of select="profiles/profile[@pid=$pid]/reference/contact/address/postcode"/> <xsl:value-of select="profiles/profile[@pid=$pid]/reference/contact/address/city"/> &amp; Email: &amp; <xsl:value-of select="profiles/profile[@pid=$pid]/reference/contact/email"/> \\
        <xsl:value-of select="profiles/profile[@pid=$pid]/reference/contact/address/country"/> \\
        <xsl:text>\end{tabular}</xsl:text>
        <xsl:text>\end{table}</xsl:text>
    </xsl:template>


</xsl:stylesheet>
