<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>본인의 책은 빌릴수 없습니다.</title>
</head>
<body id="backgroundUP">
<%@include file = "IncludeStyle.jsp" %>


<table align = center>
	<tr>
		<td height = 400>
		<a href="bMain.jsp" id="daumServiceLogo" class="ico_join"><span class="ir_wa"><img src = nameButton.jpeg></span></a>
		</td>
	</tr>
</table>

<table align = center>
	<tr>
		<td align = center>
<h3>본인의 책은 빌릴수 없습니다.</h3>
		</td>
	</tr>
	<tr>
		<td align = center>
<form action = bMain.jsp method = get>
	<input type = submit class = "button_small button1" value = '게시판'></form>
		</td>
	</tr>

</table>

</body>
</html>