<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 탈퇴</title>
</head>
<body>

    <!-- 데이터 베이스 연결 -->
	<%@include file = "IncludedbConnect.jsp" %>

<%
		request.setCharacterEncoding("utf-8");
   	
		String Tuserid = request.getParameter("userid"); 
		String id = (String)session.getAttribute("ID");

   		PreparedStatement ps  = null;
   		try{
   			Class.forName("com.mysql.jdbc.Driver");
   			Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
   			Statement stmt_mysql = conn_mysql.createStatement();
   			
   			String A = "delete from users";
   			String B = " where id = ?";
   			
   			   			
   			ps = conn_mysql.prepareStatement(A+B);
   			ps.setString(1, id);
			ps.executeUpdate();
			
			conn_mysql.close();
   		}catch(Exception e){
   			e.printStackTrace();
   			
   		}
   	session.invalidate();	
   	response.sendRedirect("halfdelete_02.jsp");
   
   
   
   %>

</body>
</html>