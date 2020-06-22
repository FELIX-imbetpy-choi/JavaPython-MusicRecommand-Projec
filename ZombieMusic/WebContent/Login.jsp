<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body id="backgroundUp">
<table class = "relative">
	<tr>
		<td style='text-align:center;vertical-align:bottom' height = 300>
		<a href="bMain.jsp" class="ico_join"><span class="ir_wa"><img src=zm_1.gif></span></a>
		</td>
	</tr>
	<tr>
		<td style='text-align:center;vertical-align:bottom' height = 150>
			<form action = halfInsert_01.jsp method = post >
    		<input type = submit value = 회원가입 class = "button_search button1"></form>
    		
		</td>
	</tr>
	<tr>
		<td align = center height = 50>
		<font color="white" size=5>or</font>
		</td>
	</tr>
	<tr>
  		<td align = center height = 70>
  			<form action = Login_02.jsp method = get>
  			<input type = text name = userid size = 10 class = "div1 button1" placeholder="아이디를 입력하세요."><p></p>
  			<input type = password name = pw size = 10 class = "div1 button1" placeholder="비밀번호를 입력하세요."></td>   
  	</tr>
  	<tr>
  		<td style='text-align:center;vertical-align:bottom' align = center height = 70>
  		
		<input type = submit value = 로그인 align = center class = "button_search button1"></td>
	</tr>
</table> 
</form>
   
</body>
</html>