<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID 찾기 결과</title>
</head>
<body id="backgroundUP">
<%@include file = "IncludeStyle.jsp" %>

    <!-- 데이터 베이스 연결 -->
	<%@include file = "IncludedbConnect.jsp" %>

<%
	request.setCharacterEncoding("utf-8");

	String Email = request.getParameter("email");
	session.setAttribute("EMAIL", Email); 
	
	int cnt = 0;

	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
		Statement stmt_mysql = conn_mysql.createStatement();
		
		
		if (Email.length() == 0 ){
%>
			<table align = center>
	<tr>
		<td><h3></br></br>전화번호를 입력하세요!</h3></td>
	</tr>
	<tr>
		<td align = center><form action = halfIdFind_01.jsp method = get>
		<input type = submit value = 이전페이지 class = "button_small button1"></form></td>
	</tr>
</table>
<%
		} else {
		
		String A = "select id from users";
		String B = " where email = '" + session.getAttribute("EMAIL") + "'";
//		String B = " where u_phone = '" + request.getParameter("Phone") + "'";
		ResultSet rs = stmt_mysql.executeQuery(A + B);
		
		while(rs.next()){
			rs.getString(1);
			cnt++;
%>
			<table align = center>
	<tr>
		<td><h3></br></br>당신의 아이디는 <%=rs.getString(1) %> 입니다.</h3></td>
	</tr>
	<tr>
		<td align = center><form action = Login.jsp method = get>
		<input type = submit value = 로그인 class = "button_small button1"></form></td>
	</tr>
</table>
			
<%
		}
		
		if ( cnt == 0){
%>
			<table align = center>
	<tr>
		<td><h3></br></br>가입되지 않은 아이디 입니다.</h3></td>
	</tr>
	<tr>
		<td align = center><form action = halfInsert_01.jsp method = get>
		<input type = submit value =회원가입하기 class = "button_small button1"></form></td>
	</tr>
</table>
			
<%
			}
 
		}
	conn_mysql.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
%>

</body>
</html>