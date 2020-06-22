<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>
<body>

    <!-- 데이터 베이스 연결 -->
	<%@include file = "IncludedbConnect.jsp" %>

<%	
	request.setCharacterEncoding("utf-8");
	String Tuserid = request.getParameter("userid");
	String Tuserpw = request.getParameter("pw");
	
	session.setAttribute("ID", Tuserid);
	//session.setAttribute("PW", Tuserpw);

   	String A = "select pw from users";
   	String B = " where id = '" + session.getAttribute("ID") +"'"; 
   
   	
   	try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
			Statement stmt_mysql = conn_mysql.createStatement();
			
			ResultSet rs = stmt_mysql.executeQuery(A+B);

   		int cnt = 0;
		
		while(rs.next()) {
			
		String login = rs.getString(1);
		cnt++;

			if ( login.equals(Tuserpw) ) {
				response.sendRedirect("bMain2.jsp");
			}
			else if ( login != Tuserpw) {
				response.sendRedirect("wrongIdPw.jsp");
			}
		}
		
			if ( cnt == 0 ){
				response.sendRedirect("noExistingUser.jsp");
			}
		
				conn_mysql.close();
	   		}catch(Exception e){
	   			e.printStackTrace();
				
			}
	
	%>

</body>
</html>