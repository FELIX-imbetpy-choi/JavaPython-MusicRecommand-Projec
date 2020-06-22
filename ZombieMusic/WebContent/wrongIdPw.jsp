<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입력하신 정보가 일치하지 않습니다.</title>
</head>
<body id="backgroundUP">
<%@include file = "IncludeStyle.jsp" %>

<table align = center>
	<tr>
		<td height = 400>
		<a href="bMain.jsp" id="daumServiceLogo" class="ico_join"><span class="ir_wa"><img src = zm_1.gif></span></a>
		</td>
	</tr>
</table>

<table align = center>
	<tr>
		<td align = center style='color:white;font-size:20pt;font-weight: bold'><h3>입력하신 정보가 일치하지 않습니다. 다시 입력해 주세요.</h3></td>
	</tr>
	<tr>
		<td align = center><form action = bMain.jsp method = get>
	<input type = submit class = "button_small button1" value = '뒤로'></form></td>
	</tr>
</table>





</body>
</html>