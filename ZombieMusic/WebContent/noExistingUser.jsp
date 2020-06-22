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
		<td align = center height = 100>
		<font color="white" size=5>ZombieMusic의 회원이 되십시오!</font>
		</td>
	</tr>
	<tr>
		<td style='text-align:center;vertical-align:bottom' height = 50>
			<form action = halfInsert_01.jsp method = post >
    		<input type = submit value = JOIN class = "button_search button1"></form>
    		
		</td>
	</tr>
	
</table> 
</form>
   
</body>
</html>