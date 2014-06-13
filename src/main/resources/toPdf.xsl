<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:param name="pid" />
    <!--<xsl:variable name="pid1" select="$pid"/>-->
    <xsl:template match="/">
        \documentclass[a4paper]{article}
        \usepackage[dvips]{graphicx,color} % or [pdftex]?
        \usepackage[pdftex,colorlinks]{hyperref}

        \usepackage{tabularx}

        %\usepackage{doublespace}
        %\setstretch{1.2}

        \usepackage{ae}
        \usepackage[T1]{fontenc}
        \usepackage{CV}

        \begin{document}

        \pagestyle{empty}

        %Ueberschrift
        \begin{center}
        \huge{\textsc{Curriculum Vitae}}
        \vspace{\baselineskip}

        \Large{\textsc{<xsl:value-of select="profiles/profile[@pid=$pid]/contact/degree"/> <xsl:value-of select="profiles/profile[@pid=$pid]/contact/name"/>}}
        \end{center}
        \vspace{1.5\baselineskip}

        \section{Address}

        \begin{flushleft}
        <xsl:value-of select="profiles/profile[@pid=$pid]/contact/address/street"/> \\
        <xsl:value-of select="profiles/profile[@pid=$pid]/contact/address/postcode"/> <xsl:value-of select="profiles/profile[@pid=$pid]/contact/address/city"/> \\
        <xsl:value-of select="profiles/profile[@pid=$pid]/contact/country"/> \\
        Phone: <xsl:value-of select="profiles/profile[@pid=$pid]/contact/phone"/> \\
        Fax: <xsl:value-of select="profiles/profile[@pid=$pid]/contact/fax"/> \\
        Email: <xsl:value-of select="profiles/profile[@pid=$pid]/contact/email"/> \\
        Homepage: <xsl:value-of select="profiles/profile[@pid=$pid]/contact/homepage"/> \\
        \end{flushleft}


        \section{Personal Details}
        \begin{flushleft}
        Gender: <xsl:value-of select="profiles/profile[@pid=$pid]/details/gender"/> \\
        Date of birth: <xsl:value-of select="profiles/profile[@pid=$pid]/details/birthDate"/> \\
        Place of birth: <xsl:value-of select="profiles/profile[@pid=$pid]/details/birthPlace"/> \\
        Present Citizenship: <xsl:value-of select="profiles/profile[@pid=$pid]/details/citizenship"/>
        \end{flushleft}


        \section{Education}

        \begin{CV}
        \item[<xsl:value-of select="profiles/profile[@pid=$pid]/education/school[1]/from"/>--<xsl:value-of select="profiles/profile[@pid=$pid]/education/school[1]/to"/>] <xsl:value-of select="profiles/profile[@pid=$pid]/education/school[1]/@name"/>
        <xsl:apply-templates select="/profiles/profile[@pid=$pid]/education/school[2]" mode="school2" />
        <xsl:apply-templates select="/profiles/profile[@pid=$pid]/education/school[3]" mode="school3" />
        \end{CV}

        \pagebreak

        <xsl:apply-templates select="profiles/profile[@pid=$pid]/thesis" mode="thesis"/>

        \section{Working Experience}

        \begin{CV}

        \item[<xsl:value-of select="profiles/profile[@pid=$pid]/experience/job[1]/from"/>--<xsl:value-of select="profiles/profile[@pid=$pid]/experience/job[1]/to"/>] <xsl:value-of select="profiles/profile[@pid=$pid]/experience/job[1]/@name"/>

        <xsl:apply-templates select="/profiles/profile[@pid=$pid]/experience/job[2]" mode="job2" />

        <xsl:apply-templates select="/profiles/profile[@pid=$pid]/experience/job[3]" mode="job3" />

        \end{CV}


        \section{Language Knowledge}
        \begin{table}[h] %\centering
        \begin{tabular}{p{2cm}>{\bfseries}p{2.5cm}p{3cm}}
        &amp; <xsl:value-of select="profiles/profile[@pid=$pid]/languages/language[1]/@name"/>  &amp; <xsl:value-of select="profiles/profile[@pid=$pid]/languages/language[1]/@knowledge"/> \\
        &amp; <xsl:value-of select="profiles/profile[@pid=$pid]/languages/language[2]/@name"/>  &amp; <xsl:value-of select="profiles/profile[@pid=$pid]/languages/language[2]/@knowledge"/> \\
        <xsl:apply-templates select="profiles/profile[@pid=$pid]/languages/language[3]/@name" mode="language3"/>
        <xsl:apply-templates select="profiles/profile[@pid=$pid]/languages/language[3]/@name" mode="language4"/>
        \end{tabular}
        \end{table}

        \pagebreak

        <xsl:apply-templates select="profiles/profile[@pid=$pid]/reference" mode="reference"/>

        \vspace{2\baselineskip}
        \noindent Groningen, \today



        \end{document}

        %Tabellen
        \begin{table}[htbp] \centering%
        \begin{tabular}{lll}\hline\hline
        1 &amp; 2 &amp; 3 \\ \hline
        1 &amp; \multicolumn{2}{c}{2} \\
        \hline
        \end{tabular}
        \caption{Titel\label{Tabelle: Label}}
        \end{table}

    </xsl:template>

    <xsl:template match="profiles/profile[@pid=$pid]/education/school[2]" mode="school2">
        \item[<xsl:value-of select="profiles/profile[@pid=$pid]/education/school[2]/from"/>--<xsl:value-of select="profiles/profile[@pid=$pid]/education/school[2]/to"/>] <xsl:value-of select="profiles/profile[@pid=$pid]/education/school[2]/@name"/>
    </xsl:template>

    <xsl:template match="profiles/profile/education/school[3]" mode="school3">
        \item[<xsl:value-of select="profiles/profile[@pid=$pid]/education/school[3]/from"/>--<xsl:value-of select="profiles/profile[@pid=$pid]/education/school[3]/to"/>] <xsl:value-of select="profiles/profile[@pid=$pid]/education/school[3]/@name"/>
    </xsl:template>

    <xsl:template match="profiles/profile[@pid=$pid]/thesis" mode="thesis">
        \section{Thesis}
        \noindent <xsl:value-of select="profiles/profile[@pid=$pid]/thesis"/>
    </xsl:template>

    <xsl:template match="profiles/profile[@pid=$pid]/experience/job[2]" mode="job2">
        \item[<xsl:value-of select="profiles/profile[@pid=$pid]/experience/job[2]/from"/>--<xsl:value-of select="profiles/profile[@pid=$pid]/experience/job[2]/to"/>] <xsl:value-of select="profiles/profile[@pid=$pid]/experience/job[2]/@name"/>
    </xsl:template>

    <xsl:template match="profiles/profile[@pid=$pid]/experience/job[2]" mode="job3">
        \item[<xsl:value-of select="profiles/profile[@pid=$pid]/experience/job[3]/from"/>--<xsl:value-of select="profiles/profile[@pid=$pid]/experience/job[3]/to"/>] <xsl:value-of select="profiles/profile[@pid=$pid]/experience/job[3]/@name"/>
    </xsl:template>

    <xsl:template match="profiles/profile[@pid=$pid]/languages/language[3]/@name" mode="language3">
        &amp; <xsl:value-of select="profiles/profile[@pid=$pid]/languages/language[3]/@name"/> &amp; <xsl:value-of select="profiles/profile[@pid=$pid]/languages/language[3]/@knowledge"/>\\
    </xsl:template>

    <xsl:template match="profiles/profile[@pid=$pid]/languages/language[4]/@name" mode="language4">
        &amp; <xsl:value-of select="profiles/profile[@pid=$pid]/languages/language[4]/@name"/> &amp; <xsl:value-of select="profiles/profile[@pid=$pid]/languages/language[4]/@knowledge"/> \\
    </xsl:template>

    <xsl:template match="profiles/profile[@pid=$pid]/reference" mode="reference">
        \section{References}

        \begin{table}[h]
        \begin{tabular}{@{}lll@{}}
        \textbf{<xsl:value-of select="profiles/profile[@pid=$pid]/reference/contact/degree"/> <xsl:value-of select="profiles/profile[@pid=$pid]/reference/contact/name"/>} \\
        <xsl:value-of select="profiles/profile[@pid=$pid]/reference/relationship"/> &amp; Phone: &amp; <xsl:value-of select="profiles/profile[@pid=$pid]/reference/contact/phone"/>\\
        <xsl:value-of select="profiles/profile[@pid=$pid]/reference/contact/address/street"/> &amp; Fax: &amp; <xsl:value-of select="profiles/profile[@pid=$pid]/reference/contact/fax"/>\\
        <xsl:value-of select="profiles/profile[@pid=$pid]/reference/contact/address/postcode"/> <xsl:value-of select="profiles/profile[@pid=$pid]/reference/contact/address/city"/> &amp; Email: &amp; <xsl:value-of select="profiles/profile[@pid=$pid]/reference/contact/email"/> \\
        <xsl:value-of select="profiles/profile[@pid=$pid]/reference/contact/address/country"/> \\
        \end{tabular}
        \end{table}
    </xsl:template>


</xsl:stylesheet>
