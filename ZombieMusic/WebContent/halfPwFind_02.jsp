<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기 결과</title>
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

    <!-- 데이터 베이스 연결 -->
	<%@include file = "IncludedbConnect.jsp" %>

<%
	request.setCharacterEncoding("utf-8");

	String Userid = request.getParameter("userid");
	String Email = request.getParameter("email");
	session.setAttribute("ID", Userid);  
	session.setAttribute("EMAIL", Email);

	int cnt = 0;
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
		Statement stmt_mysql = conn_mysql.createStatement();

	if ( Email.length() == 0 || Userid.length() ==0) {
%>
		
	<table align = center>
	<tr>
		<td><h3></br></br>빈칸을 빠짐없이 입력해주세요.</h3></td>
	</tr>
	<tr>
		<td align = center><form action = halfPwFind_01.jsp method = get>
		<input type = submit value = 이전페이지 class = "button_small button1"></form></td>
	</tr>
</table>
		
<%
	} else {
		
	String A = "select pw from users";
	String B = " where id = '" + Userid + "'" + " and email = '" + Email+ "'";
	
	
		ResultSet rs = stmt_mysql.executeQuery(A + B);
		while(rs.next()){
			rs.getString(1);
			cnt++;
%>
	
	<table align = center>
	<tr>
		<td><h3></br></br>당신의 비밀번호는 <%=rs.getString(1) %> 입니다.</h3></td>
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
		<td><h3></br></br>회원정보가 없습니다.</h3></td>
	</tr>
	<tr>
		<td align = center><form action = halfInsert_01.jsp method = get>
		<input type = submit value = 회원가입하기 class = "button_small button1"></form></td>
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