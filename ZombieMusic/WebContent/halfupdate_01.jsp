<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 정보 수정</title>
</head>
<body>

    <!-- 데이터 베이스 연결 -->
	<%@include file = "IncludedbConnect.jsp" %>

<%
	request.setCharacterEncoding("utf-8");

   		String Tname = request.getParameter("name"); 
   		String Tpw = request.getParameter("pw"); 
   		String Tage = request.getParameter("age"); 
   		String Tgender = request.getParameter("gender"); 
   		String Temail = request.getParameter("email"); 
   		
   		session.setAttribute("NAME", Tname);
   		session.setAttribute("PW", Tpw);
   		session.setAttribute("AGE", Tage);
   		session.setAttribute("GENDER", Tgender);
   		session.setAttribute("EMAIL", Temail);

   		PreparedStatement ps  = null;
   		try{
   			Class.forName("com.mysql.jdbc.Driver");
   			Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
   			Statement stmt_mysql = conn_mysql.createStatement();
   			
   			String A = "update users set pw = ?,name = ?,age = ?,gender = ?,email = ? ";
   			String B = " where id = '"+session.getAttribute("ID")+"'";
   			
   			   			
   			ps = conn_mysql.prepareStatement(A+B);
   			ps.setString(1, Tpw);
   			ps.setString(2, Tname);
   			ps.setString(3, Tage);
   			ps.setString(4, Tgender);
   			ps.setString(5, Temail);
			ps.executeUpdate();
			
			conn_mysql.close();
   		}catch(Exception e){
   			e.printStackTrace();
   			
   		}
   	response.sendRedirect("halfupdate_02.jsp");
   
   
   
   %>
				
				

</body>
</html>