<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
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
	<tr height = 100>
		<td align = center ><h3></br></br>비밀번호 찾기</h3></td>
	</tr>
	<tr>
		<td><form action = halfPwFind_02.jsp method = get>
		아이디 <input type = text name = userid size = 10 class = "div2 button1">
		이메일 <input type = text name = email size = 10 class = "div2 button1">
		<input type = submit value = OK class = "button_small button1"></form></td>
	</tr>
</table>
</body>