<%--
  Created by IntelliJ IDEA.
  User: igor
  Date: 6/14/2014
  Time: 12:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: Adam
  Date: 2.5.14
  Time: 17:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title>PDF-CV Generator</title>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
    <script>
        $(function() {
            $( "#tabs" ).tabs();
        });
    </script>
</head>
<body>

<img src="<%=request.getContextPath()%>/images/CVlogo.jpg">

<c:if test="${not empty error}">
    <div style="border: solid 1px red; background-color: yellow; padding: 10px">
        <c:out value="${error}"/>
    </div>
</c:if>
<c:if test="${not empty error2}">
    <div style="border: solid 1px red; background-color: yellow; padding: 10px">
        <c:out value="${error2}"/>
    </div>
</c:if>
<form action="${pageContext.request.contextPath}/profiles/add" method="post">
<div id="tabs" style="width: 1105px" >
<ul>
    <li><a href="#tabs-1">Address</a></li>
    <li><a href="#tabs-2">Personal details</a></li>
    <li><a href="#tabs-3">Education</a></li>
    <li><a href="#tabs-4">Thesis</a></li>
    <li><a href="#tabs-5">Working expirience</a></li>
    <li><a href="#tabs-6">Language knowledge</a></li>
    <li><a href="#tabs-7">Reference</a></li>
</ul>

<div id="tabs-1">

    <x:parse xml="${profilesDoc}" var="output"/>

    <c:set var="degreeAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]/contact/degree/text()" />
    </c:set>
    <c:set var="fullNameAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]/contact/name/text()" />
    </c:set>

    <c:set var="nameParts" value="${fn:split(fullNameAttr, ' ')}" />


    <c:set var="fullStreetAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]/contact/address/street/text()" />
    </c:set>

    <c:set var="streetParts" value="${fn:split(fullStreetAttr, ' ')}" />
    <c:set var="streetNum" value="${streetParts[fn:length(streetParts)-1]}" />
    <c:set var="streetNameWithSpace" value="${fn:substringBefore(fullStreetAttr,streetNum)}" />
    <c:set var="streetName" value="${fn:trim(streetNameWithSpace)}" />



    <c:set var="cityAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]/contact/address/city/text()" />
    </c:set>
    <c:set var="postCodeAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]/contact/address/postcode/text()" />
    </c:set>
    <c:set var="countryAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]/contact/country/text()" />
    </c:set>
    <c:set var="phoneAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]/contact/phone/text()" />
    </c:set>
    <c:set var="faxAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]/contact/fax/text()" />
    </c:set>
    <c:set var="emailAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]/contact/email/text()" />
    </c:set>
    <c:set var="homepageAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]/contact/homepage/text()" />
    </c:set>

    <c:set var="genderAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]/details/gender/text()" />
    </c:set>
    <c:set var="birthDateAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]/details/birthDate/text()" />
    </c:set>
    <c:set var="birthPlaceAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]/details/birthPlace/text()" />
    </c:set>
    <c:set var="citizenshipAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]/details/citizenship/text()" />
    </c:set>

    <c:set var="school1pAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]/education/school[1]/@name" />
    </c:set>
    <c:set var="school1FromAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]/education/school[1]/from/text()" />
    </c:set>
    <c:set var="school1ToAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]/education/school[1]/to/text()" />
    </c:set>

    <c:set var="school2pAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]/education/school[2]/@name" />
    </c:set>
    <c:set var="school2FromAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]/education/school[2]/from/text()" />
    </c:set>
    <c:set var="school2ToAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]/education/school[2]/to/text()" />
    </c:set>

    <c:set var="school3pAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]/education/school[3]/@name" />
    </c:set>
    <c:set var="school3FromAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]/education/school[3]/from/text()" />
    </c:set>
    <c:set var="school3ToAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]/education/school[3]/to/text()" />
    </c:set>

    <c:set var="thesisAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]/thesis/text()" />
    </c:set>

    <c:set var="job3Attr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]//job[3]/@name" />
    </c:set>
    <c:set var="job3FromAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]//job[3]/from/text()" />
    </c:set>
    <c:set var="job3ToAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]//job[3]/to/text()" />
    </c:set>

    <c:set var="job1Attr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]//job[1]/@name" />
    </c:set>
    <c:set var="job1FromAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]//job[1]/from/text()" />
    </c:set>
    <c:set var="job1ToAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]//job[1]/to/text()" />
    </c:set>

    <c:set var="job2Attr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]//job[2]/@name" />
    </c:set>
    <c:set var="job2FromAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]//job[2]/from/text()" />
    </c:set>
    <c:set var="job2ToAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]//job[2]/to/text()" />
    </c:set>



    <c:set var="fullRefNameAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]/reference//name/text()" />
    </c:set>

    <c:set var="refNameParts" value="${fn:split(fullRefNameAttr, ' ')}" />

    <c:set var="fullRefStreetAttr">
        <x:out select="$output/profiles/profile[@pid = $loadPid]/reference//street/text()" />
    </c:set>

    <c:set var="refStreetParts" value="${fn:split(fullRefStreetAttr, ' ')}" />

    <c:set var="refStreetNum" value="${refStreetParts[fn:length(refStreetParts)-1]}" />
    <c:set var="refStreetNameWithSpace" value="${fn:substringBefore(fullRefStreetAttr,refStreetNum)}" />
    <c:set var="refStreetName" value="${fn:trim(refStreetNameWithSpace)}" />


    <table>
        <tr>
            <th>Your ID:</th>
            <td><input type="text" name="pid" value="<c:out value='${loadPid}'/>"/></td>
        </tr>
        <tr>
            <th>Degree:</th>
            <td><input type="text" name="degree" value="<c:out value='${degreeAttr}'/>"/></td>
        </tr>
        <tr>
            <th>Name:</th>
            <td><input type="text" name="name" value="<c:out value='${nameParts[0]}'/>" required /></td>
        </tr>
        <tr>
            <th>Surname:</th>
            <td><input type="text" name="surname" value="<c:out value='${nameParts[1]}'/>" required /></td>
        </tr>
        <tr>
            <th style="vertical-align: text-bottom">Address:</th>
            <td><input type="text" name="street" value="<c:out value='${streetName}'/>" placeholder="Street" required>
                <input type="number" name="housenumber" value="<c:out value='${streetNum}'/>" placeholder="House number" required><br />
                <input type="text" name="city" value="<c:out value='${cityAttr}'/>" placeholder="City" required>
                <input type="text" name="postcode" value="<c:out value='${postCodeAttr}'/>" placeholder="Postcode" required></td>
        </tr>
        <tr>
            <th>Country:</th>
            <td><input type="text" name="country" value="<c:out value='${countryAttr}'/>" required></td>
        </tr>
        <tr>
            <th>Phone:</th>
            <td><input type="text" name="tel" value="<c:out value='${phoneAttr}'/>" pattern="\+[0-9]{3}(\s{0,1}[0-9]{3}){3}" placeholder="+420 777 178 983" required></td>
        </tr>
        <tr>
            <th>Fax:</th>
            <td><input type="text" name="fax" value="<c:out value='${faxAttr}'/>" pattern="\+[0-9]{3}(\s{0,1}[0-9]{3}){3}" placeholder="+420 777 178 983" ></td>
        </tr>
        <th>E-mail:</th>
        <td><input type="email" name="email" value="<c:out value='${emailAttr}'/>"></td>
        <tr/>
        <th>Homepage:</th>
        <td><input type="url" name="homepage" value="<c:out value='${homepageAttr}'/>"></td>
        <tr/>
    </table>
</div>

<div id="tabs-2">
    <table>
        <tr>
            <th>Gender:</th>
            <td>
                <select id="gender" name="gender" required value="<c:out value='${genderAttr}'/>">
                    <option value="male">Male</option>
                    <option value="female">Female</option>
                </select>
            </td>
        </tr>
        <tr>
            <th>Date of birth:</th>
            <td><input type="text" required pattern="(([0][1-9])|([1-2][0-9])|[3][0|1])[.](([0][1-9])|([1][0-2]))[.](19|20)\d{2}" placeholder="01.01.2014" name="dateofbirth" value="<c:out value='${birthDateAttr}'/>"></td>
        </tr>
        <tr>
            <th>Place of birth:</th>
            <td><input type="text" required name="placeofbirth" value="<c:out value='${birthPlaceAttr}'/>"></td>
        </tr>
        <tr>
            <th>Present Citizenship:</th>
            <td><input type="text" required name="citizenship" value="<c:out value='${citizenshipAttr}'/>"></td>
        </tr>

    </table>
</div>

<div id="tabs-3">
    <table>
        <tr>
            <td>From: <input type="text" name="stschoolfrom" required pattern="(([0][1-9])|([1-2][0-9])|[3][0|1])[.](([0][1-9])|([1][0-2]))[.](19|20)\d{2}" placeholder="01.01.2014" value="<c:out value='${school1FromAttr}'/>"></td>
            <td>To: <input type="text" name="stschoolto" required pattern="(([0][1-9])|([1-2][0-9])|[3][0|1])[.](([0][1-9])|([1][0-2]))[.](19|20)\d{2}" placeholder="01.01.2014" value="<c:out value='${school1ToAttr}'/>"></td>
            <td>School name: <input type="text" name="stschoolname" required value="<c:out value='${school1pAttr}'/>"  style="width: 350px"></td>
        </tr>
        <tr>
            <td>From: <input type="text" name="ndschoolfrom" pattern="(([0][1-9])|([1-2][0-9])|[3][0|1])[.](([0][1-9])|([1][0-2]))[.](19|20)\d{2}" placeholder="01.01.2014" value="<c:out value='${school2FromAttr}'/>"></td>
            <td>To: <input type="text" name="ndschoolto" pattern="(([0][1-9])|([1-2][0-9])|[3][0|1])[.](([0][1-9])|([1][0-2]))[.](19|20)\d{2}" placeholder="01.01.2014" value="<c:out value='${school2ToAttr}'/>"></td>
            <td>School name: <input type="text" name="ndschoolname" value="<c:out value='${school2pAttr}'/>"  style="width: 350px"></td>
        </tr>
        <tr>
            <td>From: <input type="text" name="rdschoolfrom" pattern="(([0][1-9])|([1-2][0-9])|[3][0|1])[.](([0][1-9])|([1][0-2]))[.](19|20)\d{2}" placeholder="01.01.2014" value="<c:out value='${school3FromAttr}'/>"></td>
            <td>To: <input type="text" name="rdschoolto" pattern="(([0][1-9])|([1-2][0-9])|[3][0|1])[.](([0][1-9])|([1][0-2]))[.](19|20)\d{2}" placeholder="01.01.2014" value="<c:out value='${school3ToAttr}'/>"></td>
            <td>School name: <input type="text" name="rdschoolname" value="<c:out value='${school3pAttr}'/>"  style="width: 350px"></td>
        </tr>
    </table>
</div>

<div id="tabs-4">
    <tr>
        <td><textarea cols="80" rows="15" name="thesis" value="<c:out value='${thesisAttr}'/>" placeholder="Describe your thesis"></textarea></td>
    </tr>
</div>

<div id="tabs-5">
    <table>
        <tr>
            <td>From: <input type="text" name="stworkfrom" pattern="(([0][1-9])|([1-2][0-9])|[3][0|1])[.](([0][1-9])|([1][0-2]))[.](19|20)\d{2}" placeholder="01.01.2014" value="<c:out value='${job1FromAttr}'/>"></td>
            <td>To: <input type="text" name="stworkto" pattern="(([0][1-9])|([1-2][0-9])|[3][0|1])[.](([0][1-9])|([1][0-2]))[.](19|20)\d{2}" placeholder="01.01.2014" value="<c:out value='${job1ToAttr}'/>"></td>
            <td>Work: <input type="text" name="stwork" value="<c:out value='${job1Attr}'/>"  style="width: 350px"></td>
        </tr>
        <tr>
            <td>From: <input type="text" name="ndworkfrom" pattern="(([0][1-9])|([1-2][0-9])|[3][0|1])[.](([0][1-9])|([1][0-2]))[.](19|20)\d{2}" placeholder="01.01.2014" value="<c:out value='${job2FromAttr}'/>"></td>
            <td>To: <input type="text" name="ndworkto" pattern="(([0][1-9])|([1-2][0-9])|[3][0|1])[.](([0][1-9])|([1][0-2]))[.](19|20)\d{2}" placeholder="01.01.2014" value="<c:out value='${job2ToAttr}'/>"></td>
            <td>Work: <input type="text" name="ndwork" value="<c:out value='${job2Attr}'/>"  style="width: 350px"></td>
        </tr>
        <tr>
            <td>From: <input type="text" name="rdworkfrom" pattern="(([0][1-9])|([1-2][0-9])|[3][0|1])[.](([0][1-9])|([1][0-2]))[.](19|20)\d{2}" placeholder="01.01.2014" value="<c:out value='${job3FromAttr}'/>"></td>
            <td>To: <input type="text" name="rdworkto" pattern="(([0][1-9])|([1-2][0-9])|[3][0|1])[.](([0][1-9])|([1][0-2]))[.](19|20)\d{2}" placeholder="01.01.2014" value="<c:out value='${job3ToAttr}'/>"></td>
            <td>Work: <input type="text" name="rdwork" value="<c:out value='${job3Attr}'/>"  style="width: 350px"></td>
        </tr>
    </table>
</div>
<div id="tabs-6">
    <table>
        <tr>
            <th><input type="text" name="stlanguage" value="<x:out select="$output/profiles/profile[@pid = $loadPid]//language[1]/@name" />"></th>
            <td>
                <select id="stlanguagelvl" name="stlanguagelvl" value="<x:out select="$output/profiles/profile[@pid = $loadPid]//language[1]/@knowledge" />">
                    <option value="native">native</option>
                    <option value="near native">near native</option>
                    <option value="3">fair</option>
                </select>
            </td>
        </tr>
        <tr>
            <th><input type="text" name="ndlanguage" value="<x:out select="$output/profiles/profile[@pid = $loadPid]//language[2]/@name" />"></th>
            <td>
                <select id="ndlanguagelvl" name="ndlanguagelvl" value="<x:out select="$output/profiles/profile[@pid = $loadPid]//language[2]/@knowledge" />">
                    <option value="native">native</option>
                    <option value="near native">near native</option>
                    <option value="fair">fair</option>
                </select>
            </td>
        </tr>
        <tr>
            <th><input type="text" name="rdlanguage" value="<x:out select="$output/profiles/profile[@pid = $loadPid]//language[3]/@name" />"></th>
            <td>
                <select id="rdlanguagelvl" name="rdlanguagelvl" value="<x:out select="$output/profiles/profile[@pid = $loadPid]//language[3]/@knowledge" />">
                    <option value="native">native</option>
                    <option value="near native">near native</option>
                    <option value="fair">fair</option>
                </select>
            </td>
        </tr>
        <tr>
            <th><input type="text" name="thlanguage" value="<x:out select="$output/profiles/profile[@pid = $loadPid]//language[4]/@name" />"></th>
            <td>
                <select id="thlanguagelvl" name="thlanguagelvl" value="<x:out select="$output/profiles/profile[@pid = $loadPid]//language[4]/@knowledge" />">
                    <option value="native">native</option>
                    <option value="near native">near native</option>
                    <option value="fair">fair</option>
                </select>
            </td>
        </tr>
    </table>
</div>
<div id="tabs-7">
    <table>
        <tr>
            <th>Person, who is familiar with your qualifications and your character:</th>
        </tr>
        <table>
            <tr>
                <th>Relationship:</th>
                <td><input type="text" name="relationship" value="<x:out select="$output/profiles/profile[@pid = $loadPid]//relationship/text()" />"/></td>
            </tr>
            <tr>
                <th>Degree:</th>
                <td><input type="text" name="refdegree" value="<x:out select="$output/profiles/profile[@pid = $loadPid]/reference//degree/text()" />"/></td>
            </tr>
            <tr>
                <th>Name:</th>
                <td><input type="text" name="refname" value="${refNameParts[0]}"/></td>
            </tr>
            <tr>
                <th>Surname:</th>
                <td><input type="text" name="refsurname" value="<c:out value='${refNameParts[1]}'/>"></td>
            </tr>
            <tr>
                <th style="vertical-align: text-bottom">Address:</th>
                <td><input type="text" name="refstreet" value="<c:out value='${refStreetName}'/>" placeholder="Street">
                    <input type="number" name="refhousenumber" value="<c:out value='${refStreetNum}'/>" placeholder="House number"><br />
                    <input type="text" name="refcity" value="<x:out select="$output/profiles/profile[@pid = $loadPid]/reference//city/text()" />" placeholder="City">
                    <input type="text" name="refpostcode" value="<x:out select="$output/profiles/profile[@pid = $loadPid]/reference//postcode/text()" />" placeholder="Postcode"></td>
            </tr>
            <tr>
                <th>Country:</th>
                <td><input type="text" name="refcountry" value="<x:out select="$output/profiles/profile[@pid = $loadPid]/reference//country/text()" />"></td>
            </tr>
            <tr>
                <th>Phone:</th>
                <td><input type="text" name="reftel" pattern="\+[0-9]{3}(\s{0,1}[0-9]{3}){3}" placeholder="+420 777 178 983" value="<x:out select="$output/profiles/profile[@pid = $loadPid]/reference//phone/text()" />"></td>
            </tr>
            <tr>
                <th>Fax:</th>
                <td><input type="text" name="reffax" pattern="\+[0-9]{3}(\s{0,1}[0-9]{3}){3}" placeholder="+420 777 178 983" value="<x:out select="$output/profiles/profile[@pid = $loadPid]/reference//fax/text()" />"></td>
            </tr>
            <th>E-mail:</th>
            <td><input type="email" name="refemail" value="<x:out select="$output/profiles/profile[@pid = $loadPid]/reference//email/text()" />"></td>
            <th>Homepage:</th>
            <td><input type="url" name="refhomepage" value="<x:out select="$output/profiles/profile[@pid = $loadPid]/reference//homepage/text()" />"></td>
        </table>

    </table>
</div>
</div>
<input class="button" type="Submit" value="Create CV" style="margin-top: 15px; margin-left: 905px;"/>
</form>
<form action="${pageContext.request.contextPath}/profiles/load" method="get">
    <input type="text" name="loadpid" value="<c:out value='${param.loadpid}'/>" placeholder="Your profile ID" style="margin-left: 750px;">
    <input class="button" type="submit" value="Load CV">
</form>
</body>
</html>

