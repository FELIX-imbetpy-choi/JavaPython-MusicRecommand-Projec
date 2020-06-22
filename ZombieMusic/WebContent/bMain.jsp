<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Zombie Music</title>

<body id="backgroundUp">
<%@include file = "IncludeStyle.jsp" %>

<table class = "relative">
	<tr>
		<td style='text-align:center;vertical-align:bottom' height = 300>
		<a href="bMain.jsp" class="ico_join"><span class="ir_wa"><img src=zm_1.gif></span></a>
		</td>
	</tr>
	<tr>
		<td style='text-align:center;vertical-align:bottom' height = 150>
			<form action = halfInsert_01.jsp method = post >
    		<input type = submit value = JOIN size = 15% class = "button_small button1"></form>
    		
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
  			<input type = text name = userid size = 30% class = "button_search button1" placeholder="ID"><p></p>
  			<input type = password name = pw size = 30% class = "button_search button1" placeholder="PASSWORD"></td>   
  	</tr>
  	<tr>
  		<td style='text-align:center;vertical-align:bottom' align = center height = 70>
  		
		<input type = submit value = LOGIN size = 15% align = center class = "button_small button1"></td>
	</tr>
	

</table>
</form>
   
</body>
</html>