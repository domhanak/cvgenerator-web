<%--
  Created by IntelliJ IDEA.
  User: Adam
  Date: 2.5.14
  Time: 17:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>PDF-CV Generator</title>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" href="css/style.css">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
    <script>
        $(function() {
            $( "#tabs" ).tabs();
        });
    </script>
</head>
<body>

<img src="images/CVlogo.jpg">

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
            <table>
                <tr>
                    <th>Degree:</th>
                    <td><input type="text" name="degree" value="<c:out value='${param.degree}'/>"/></td>
                </tr>
                <tr>
                    <th>Name:</th>
                    <td><input type="text" name="name" value="<c:out value='${param.name}'/>" required /></td>
                </tr>
                <tr>
                    <th>Surname:</th>
                    <td><input type="text" name="surname" value="<c:out value='${param.surname}'/>" required /></td>
                </tr>
                <tr>
                    <th style="vertical-align: text-bottom">Address:</th>
                    <td><input type="text" name="street" value="<c:out value='${param.street}'/>" placeholder="Street" required>
                        <input type="number" name="housenumber" value="<c:out value='${param.housenumber}'/>" placeholder="House number" required><br />
                        <input type="text" name="city" value="<c:out value='${param.city}'/>" placeholder="City" required>
                        <input type="number" name="postcode" value="<c:out value='${param.postcode}'/>" placeholder="Postcode" required></td>
                </tr>
                <tr>
                    <th>Country:</th>
                    <td><input type="text" name="country" value="<c:out value='${param.country}'/>" required></td>
                </tr>
                <tr>
                    <th>Phone:</th>
                    <td><input type="text" name="tel" value="<c:out value='${param.tel}'/>" pattern="\+[0-9]{3}(\s{0,1}[0-9]{3}){3}" required></td>
                </tr>
                <tr>
                    <th>Fax:</th>
                    <td><input type="tel" name="fax" value="<c:out value='${param.fax}'/>" pattern="\+[0-9]{3}(\s{0,1}[0-9]{3}){3}" ></td>
                </tr>
                    <th>E-mail:</th>
                    <td><input type="email" name="email" value="<c:out value='${param.email}'/>"></td>
                <tr/>
                    <th>Homepage:</th>
                    <td><input type="url" name="homepage" value="<c:out value='${param.homepage}'/>"></td>
                <tr/>
            </table>
        </div>

        <div id="tabs-2">
            <table>
                <tr>
                    <th>Gender:</th>
                    <td>
                        <select id="gender" name="gender" value="<c:out value='${param.gendre}'/>">
                            <option value="1">Male</option>
                            <option value="2">Female</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>Date of birth:</th>
                    <td><input type="date" name="dateofbirth" value="<c:out value='${param.dateofbirth}'/>"></td>
                </tr>
                <tr>
                    <th>Place of birth:</th>
                    <td><input type="text" name="placeofbirth" value="<c:out value='${param.placeofbirth}'/>"></td>
                </tr>
                <tr>
                    <th>Present Citizenship:</th>
                    <td><input type="text" name="citizenship" value="<c:out value='${param.citizenship}'/>"></td>
                </tr>

            </table>
        </div>

        <div id="tabs-3">
            <table>
                <tr>
                    <td>From: <input type="month" name="stschoolfrom" value="<c:out value='${param.stschoolfrom}'/>"></td>
                    <td>To: <input type="month" name="stschoolto" value="<c:out value='${param.stschoolto}'/>"></td>
                    <td>School name: <input type="text" name="stschoolname" value="<c:out value='${param.stchoolname}'/>"  style="width: 350px"></td>
                </tr>
                <tr>
                    <td>From: <input type="month" name="ndschoolfrom" value="<c:out value='${param.ndschoolfrom}'/>"></td>
                    <td>To: <input type="month" name="ndschoolto" value="<c:out value='${param.ndschoolto}'/>"></td>
                    <td>School name: <input type="text" name="ndschoolname" value="<c:out value='${param.ndschoolname}'/>"  style="width: 350px"></td>
                </tr>
                <tr>
                    <td>From: <input type="month" name="rdschoolfrom" value="<c:out value='${param.rdschoolfrom}'/>"></td>
                    <td>To: <input type="month" name="rdschoolto" value="<c:out value='${param.rdschoolto}'/>"></td>
                    <td>School name: <input type="text" name="rdschoolname" value="<c:out value='${param.rdschoolname}'/>"  style="width: 350px"></td>
                </tr>
            </table>
        </div>

        <div id="tabs-4">
            <tr>
                <td><textarea cols="80" rows="15" name="thesis" placeholder="Describe your thesis"></textarea></td>
            </tr>
        </div>

        <div id="tabs-5">
            <table>
                <tr>
                    <td>From: <input type="month" name="stworkfrom" value="<c:out value='${param.stworkfrom}'/>"></td>
                    <td>To: <input type="month" name="stworkto" value="<c:out value='${param.stworkto}'/>"></td>
                    <td>Work: <input type="text" name="stwork" value="<c:out value='${param.stwork}'/>"  style="width: 350px"></td>
                </tr>
                <tr>
                    <td>From: <input type="month" name="ndworkfrom" value="<c:out value='${param.ndworkfrom}'/>"></td>
                    <td>To: <input type="month" name="ndworkto" value="<c:out value='${param.ndworkto}'/>"></td>
                    <td>Work: <input type="text" name="ndwork" value="<c:out value='${param.ndwork}'/>"  style="width: 350px"></td>
                </tr>
                <tr>
                    <td>From: <input type="month" name="rdworkfrom" value="<c:out value='${param.rdworkfrom}'/>"></td>
                    <td>To: <input type="month" name="rdworkto" value="<c:out value='${param.rdworkto}'/>"></td>
                    <td>Work: <input type="text" name="rdwork" value="<c:out value='${param.rdwork}'/>"  style="width: 350px"></td>
                </tr>
            </table>
        </div>
        <div id="tabs-6">
            <table>
                <tr>
                    <th><input type="text" name="stlanguage" value="<c:out value='${param.stlanguage}'/>"></th>
                    <td>
                        <select id="stlanguagelvl" name="stlanguagelvl" value="<c:out value='${param.stlanguagelvl}'/>">
                            <option value="1">native</option>
                            <option value="2">near native</option>
                            <option value="3">fair</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th><input type="text" name="ndlanguage" value="<c:out value='${param.ndlanguage}'/>"></th>
                    <td>
                        <select id="ndlanguagelvl" name="ndlanguagelvl" value="<c:out value='${param.ndlanguagelvl}'/>">
                            <option value="1">native</option>
                            <option value="2">near native</option>
                            <option value="3">fair</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th><input type="text" name="rdlanguage" value="<c:out value='${param.rdlanguage}'/>"></th>
                    <td>
                        <select id="rdlanguagelvl" name="rdlanguagelvl" value="<c:out value='${param.rdlanguagelvl}'/>">
                            <option value="1">native</option>
                            <option value="2">near native</option>
                            <option value="3">fair</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th><input type="text" name="thlanguage" value="<c:out value='${param.thlanguage}'/>"></th>
                    <td>
                        <select id="thlanguagelvl" name="thlanguagelvl" value="<c:out value='${param.thlanguagelvl}'/>">
                            <option value="1">native</option>
                            <option value="2">near native</option>
                            <option value="3">fair</option>
                        </select>
                    </td>
                </tr>
            </table>
        </div>
        <div id="tabs-7">
            <table>
                <tr>
                <th>Person, who are familiar with your qualifications and your character:</th>
                </tr>
                <table>
                    <tr>
                        <th>Relationship:</th>
                        <td><input type="text" name="relationship" value="<c:out value='${param.realtionship}'/>"/></td>
                    </tr>
                    <tr>
                        <th>Degree:</th>
                        <td><input type="text" name="refdegree" value="<c:out value='${param.refdegree}'/>"/></td>
                    </tr>
                    <tr>
                        <th>Name:</th>
                        <td><input type="text" name="refname" value="<c:out value='${param.refname}'/>"/></td>
                    </tr>
                    <tr>
                        <th>Surname:</th>
                        <td><input type="text" name="refsurname" value="<c:out value='${param.refsurname}'/>"></td>
                    </tr>
                    <tr>
                        <th style="vertical-align: text-bottom">Address:</th>
                        <td><input type="text" name="refstreet" value="<c:out value='${param.refstreet}'/>" placeholder="Street">
                            <input type="number" name="refhousenumber" value="<c:out value='${param.refhousenumber}'/>" placeholder="House number"><br />
                            <input type="text" name="refcity" value="<c:out value='${param.refcity}'/>" placeholder="City">
                            <input type="number" name="refpostcode" value="<c:out value='${param.refpostcode}'/>" placeholder="Postcode"></td>
                    </tr>
                    <tr>
                        <th>Country:</th>
                        <td><input type="text" name="refcountry" value="<c:out value='${param.refcountry}'/>"></td>
                    </tr>
                    <tr>
                        <th>Phone:</th>
                        <td><input type="tel" name="reftel" value="<c:out value='${param.reftel}'/>"></td>
                    </tr>
                    <tr>
                        <th>Fax:</th>
                        <td><input type="tel" name="reffax" value="<c:out value='${param.reffax}'/>"></td>
                    </tr>
                    <th>E-mail:</th>
                    <td><input type="email" name="refemail" value="<c:out value='${param.refemail}'/>"></td>
                </table>

            </table>
        </div>
    </div>
    <input type="Submit" value="Create CV"  style="border: 2px solid gray; background-color: gold; width: 200px; height: 40px; font-size: 22px; margin-top: 15px; margin-left: 905px"/>
</form>

</body>
</html>
