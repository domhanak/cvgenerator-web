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

<form method="post">
    <div id="tabs" style="width: 800px" >
        <ul>
            <li><a href="#tabs-1">Personal information</a></li>
            <li><a href="#tabs-2">Education</a></li>
            <li><a href="#tabs-3">Qualities</a></li>
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
                    <th>Phone:</th>
                    <td><input type="tel" name="tel" value=""></td>
                </tr>
                <th>E-mail:</th>
                <td><input type="email" name="email" value=""></td>
                <tr/>
                <tr>
                    <th>Country:</th>
                    <td><input type="text" name="country" value=""></td>
                </tr>
                <tr>
                    <th>Sex:</th>
                    <td>
                        <select id="sex" name="sex" value="">
                            <option value="1">Male</option>
                            <option value="2">Female</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>Marital status:</th>
                    <td>
                        <select id="mas" name="mas" value="">
                            <option value="1">Married</option>
                            <option value="2">Single</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>Date of birth:</th>
                    <td><input type="date" name="dateofbirth" value=""></td>
                </tr>
                <tr>
                    <th>Driving license:</th>
                    <td>
                        <input type="checkbox" name="a" value="">A
                        <input type="checkbox" name="b" value="">B
                        <input type="checkbox" name="c" value="">C
                        <input type="checkbox" name="d" value="">D
                        <input type="checkbox" name="e" value="">E
                        <input type="checkbox" name="t" value="">T
                    </td>
                </tr>

            </table>
        </div>

        <div id="tabs-2">
        </div>

        <div id="tabs-3">
        </div>
    </div>
    <input type="Submit" value="Create CV"  style="border: 2px solid gray; background-color: gold; width: 200px; height: 40px; font-size: 22px; margin-top: 15px; margin-left: 300px"/>
</form>

</body>
</html>
