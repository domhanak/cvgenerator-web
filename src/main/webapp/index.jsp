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
                    <td><input type="text" name="degree" value=""/></td>
                </tr>
                <tr>
                    <th>Name:</th>
                    <td><input type="text" name="name" value=""/></td>
                </tr>
                <tr>
                    <th>Surname:</th>
                    <td><input type="text" name="surname" value=""></td>
                </tr>
                <tr>
                    <th style="vertical-align: text-bottom">Address:</th>
                    <td><input type="text" name="street" value="" placeholder="Street">
                        <input type="number" name="housenumber" value="" placeholder="House number"><br />
                        <input type="text" name="city" value="" placeholder="City">
                        <input type="number" name="postcode" value="" placeholder="Postcode"></td>
                </tr>
                <tr>
                    <th>Country:</th>
                    <td><input type="text" name="country" value=""></td>
                </tr>
                <tr>
                    <th>Phone:</th>
                    <td><input type="tel" name="tel" value=""></td>
                </tr>
                <tr>
                    <th>Fax:</th>
                    <td><input type="tel" name="fax" value=""></td>
                </tr>
                    <th>E-mail:</th>
                    <td><input type="email" name="email" value=""></td>
                <tr/>
                    <th>Homepage:</th>
                    <td><input type="url" name="homepage" value=""></td>
                <tr/>
            </table>
        </div>

        <div id="tabs-2">
            <table>
                <tr>
                    <th>Gender:</th>
                    <td>
                        <select id="gender" name="gender" value="">
                            <option value="1">Male</option>
                            <option value="2">Female</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>Date of birth:</th>
                    <td><input type="date" name="dateofbirth" value=""></td>
                </tr>
                <tr>
                    <th>Place of birth:</th>
                    <td><input type="text" name="placeofbirth" value=""></td>
                </tr>
                <tr>
                    <th>Present Citizenship:</th>
                    <td><input type="text" name="citizenship" value=""></td>
                </tr>

            </table>
        </div>

        <div id="tabs-3">
            <table>
                <tr>
                    <td>From: <input type="month" name="stschoolfrom" value=""></td>
                    <td>To: <input type="month" name="stschoolto" value=""></td>
                    <td>School name: <input type="text" name="stschoolname" value=""  style="width: 350px"></td>
                </tr>
                <tr>
                    <td>From: <input type="month" name="ndschoolfrom" value=""></td>
                    <td>To: <input type="month" name="ndschoolto" value=""></td>
                    <td>School name: <input type="text" name="ndschoolname" value=""  style="width: 350px"></td>
                </tr>
                <tr>
                    <td>From: <input type="month" name="rdschoolfrom" value=""></td>
                    <td>To: <input type="month" name="rdschoolto" value=""></td>
                    <td>School name: <input type="text" name="rdschoolname" value=""  style="width: 350px"></td>
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
                    <td>From: <input type="month" name="stworkfrom" value=""></td>
                    <td>To: <input type="month" name="stworkto" value=""></td>
                    <td>Work: <input type="text" name="stwork" value=""  style="width: 350px"></td>
                </tr>
                <tr>
                    <td>From: <input type="month" name="ndworkfrom" value=""></td>
                    <td>To: <input type="month" name="ndworkto" value=""></td>
                    <td>Work: <input type="text" name="ndwork" value=""  style="width: 350px"></td>
                </tr>
                <tr>
                    <td>From: <input type="month" name="rdworkfrom" value=""></td>
                    <td>To: <input type="month" name="rdworkto" value=""></td>
                    <td>Work: <input type="text" name="rdwork" value=""  style="width: 350px"></td>
                </tr>
            </table>
        </div>
        <div id="tabs-6">
            <table>
                <tr>
                    <th><input type="text" name="stlanguage" value=""></th>
                    <td>
                        <select id="stlanguagelvl" name="stlanguagelvl" value="">
                            <option value="1">native</option>
                            <option value="2">near native</option>
                            <option value="3">fair</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th><input type="text" name="ndlanguage" value=""></th>
                    <td>
                        <select id="ndlanguagelvl" name="ndlanguagelvl" value="">
                            <option value="1">native</option>
                            <option value="2">near native</option>
                            <option value="3">fair</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th><input type="text" name="rdlanguage" value=""></th>
                    <td>
                        <select id="rdlanguagelvl" name="rdlanguagelvl" value="">
                            <option value="1">native</option>
                            <option value="2">near native</option>
                            <option value="3">fair</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th><input type="text" name="thlanguage" value=""></th>
                    <td>
                        <select id="thlanguagelvl" name="thlanguagelvl" value="">
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
                        <td><input type="text" name="relationship" value=""/></td>
                    </tr>
                    <tr>
                        <th>Degree:</th>
                        <td><input type="text" name="refdegree" value=""/></td>
                    </tr>
                    <tr>
                        <th>Name:</th>
                        <td><input type="text" name="refname" value=""/></td>
                    </tr>
                    <tr>
                        <th>Surname:</th>
                        <td><input type="text" name="refsurname" value=""></td>
                    </tr>
                    <tr>
                        <th style="vertical-align: text-bottom">Address:</th>
                        <td><input type="text" name="refstreet" value="" placeholder="Street">
                            <input type="number" name="refhousenumber" value="" placeholder="House number"><br />
                            <input type="text" name="refcity" value="" placeholder="City">
                            <input type="number" name="refpostcode" value="" placeholder="Postcode"></td>
                    </tr>
                    <tr>
                        <th>Country:</th>
                        <td><input type="text" name="refcountry" value=""></td>
                    </tr>
                    <tr>
                        <th>Phone:</th>
                        <td><input type="tel" name="reftel" value=""></td>
                    </tr>
                    <tr>
                        <th>Fax:</th>
                        <td><input type="tel" name="reffax" value=""></td>
                    </tr>
                    <th>E-mail:</th>
                    <td><input type="email" name="refemail" value=""></td>
                </table>

            </table>
        </div>
    </div>
    <input type="Submit" value="Create CV"  style="border: 2px solid gray; background-color: gold; width: 200px; height: 40px; font-size: 22px; margin-top: 15px; margin-left: 905px"/>
</form>

</body>
</html>
