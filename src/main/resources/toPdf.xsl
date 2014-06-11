<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        \documentclass[a4paper]{article}

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

        \Large{\textsc{<xsl:value-of select="profiles/profile/contact/degree"/> <xsl:value-of select="profiles/profile/contact/name"/> <xsl:value-of select="profiles/profile/contact/surname"/>}}
        \end{center}
        \vspace{1.5\baselineskip}

        \section{Address}

        \begin{flushleft}
        <xsl:value-of select="profiles/profile/contact/address/street"/> <xsl:value-of select="profiles/profile/contact/address/number"/> \\
        <xsl:value-of select="profiles/profile/contact/address/postcode"/> <xsl:value-of select="profiles/profile/contact/address/city"/> \\
        <xsl:value-of select="profiles/profile/contact/country"/> \\
        Phone: <xsl:value-of select="profiles/profile/contact/phone"/> \\
        Fax: <xsl:value-of select="profiles/profile/contact/fax"/> \\
        Email: <xsl:value-of select="profiles/profile/contact/email"/> \\
        Homepage: <xsl:value-of select="profiles/profile/contact/homepage"/> \\
        \end{flushleft}


        \section{Personal Details}
        \begin{flushleft}
        Gender: <xsl:value-of select="profiles/profile/details/gender"/> \\
        Date of birth: <xsl:value-of select="profiles/profile/details/birthDate"/> \\
        Place of birth: <xsl:value-of select="profiles/profile/details/birthPlace"/> \\
        Present Citizenship: <xsl:value-of select="profiles/profile/details/citizenship"/>
        \end{flushleft}


        \section{Education}

        \begin{CV}
        \item[<xsl:value-of select="profiles/profile/education/school[1]/from"/>--<xsl:value-of select="profiles/profile/education/school[1]/to"/>] <xsl:value-of select="profiles/profile/education/school[1]/@name"/>
        \item[<xsl:value-of select="profiles/profile/education/school[2]/from"/>--<xsl:value-of select="profiles/profile/education/school[2]/to"/>] <xsl:value-of select="profiles/profile/education/school[2]/@name"/>
        \item[<xsl:value-of select="profiles/profile/education/school[3]/from"/>--<xsl:value-of select="profiles/profile/education/school[3]/to"/>] <xsl:value-of select="profiles/profile/education/school[3]/@name"/>
        \end{CV}

        \pagebreak

        \section{Thesis}
        \noindent A special feature of the German financial system is the position of
        the \emph{Deutsche Bundesbank}, which is considered to be one of the
        most independent central banks in the world. The purpose of this
        research is to analyse to which extent this formal independent
        position has led to less political influence on the central
        bank than, for instance, in the USA.

        \section{Working Experience}

        \begin{CV}

        \item[<xsl:value-of select="profiles/profile/experience/job[1]/from"/>--<xsl:value-of select="profiles/profile/experience/job[1]/to"/>] <xsl:value-of select="profiles/profile/experience/job[1]/@name"/>

        \item[<xsl:value-of select="profiles/profile/experience/job[2]/from"/>--<xsl:value-of select="profiles/profile/experience/job[2]/to"/>] <xsl:value-of select="profiles/profile/experience/job[2]/@name"/>


        \item[<xsl:value-of select="profiles/profile/experience/job[3]/from"/>--<xsl:value-of select="profiles/profile/experience/job[3]/to"/>] <xsl:value-of select="profiles/profile/experience/job[3]/@name"/>

        \end{CV}


        \section{Language Knowledge}
        \begin{table}[h] %\centering
        \begin{tabular}{p{2cm}>{\bfseries}p{2.5cm}p{3cm}}
        &amp; <xsl:value-of select="profiles/profile/languages/language[1]/@name"/>  &amp; <xsl:value-of select="profiles/profile/languages/language[1]/@level"/> \\
        &amp; <xsl:value-of select="profiles/profile/languages/language[2]/@name"/>  &amp; <xsl:value-of select="profiles/profile/languages/language[3]/@level"/> \\
        &amp; <xsl:value-of select="profiles/profile/languages/language[3]/@name"/> &amp; <xsl:value-of select="profiles/profile/languages/language[4]/@level"/>\\
        &amp; <xsl:value-of select="profiles/profile/languages/language[3]/@name"/> &amp; <xsl:value-of select="profiles/profile/languages/language[4]/@level"/> \\
        \end{tabular}
        \end{table}

        \pagebreak

        \section{References}

        \begin{table}[h]
        \begin{tabular}{@{}lll@{}}
        \textbf{Prof. Dr. Pro. Fessor} \\
        Thesis supervisor &amp; Phone: &amp; +31-50-312.3456\\
        P.O. Box 800 &amp; Fax: &amp; +31-50-567.123\\
        9700 AV Groningen &amp; Email: &amp; p.fessor@xxx.rug.nl \\
        The Netherlands \\
        \end{tabular}
        \end{table}

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

</xsl:stylesheet>
