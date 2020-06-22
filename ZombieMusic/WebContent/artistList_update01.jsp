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

   		String Nartist = request.getParameter("artist"); 
   		String Userid = request.getParameter("userid"); 
   		
   		session.setAttribute("USERID", Userid);
   		session.setAttribute("NARTIST", Nartist);
   		
   		int count = 0;
   		int cnt = 0;
   		PreparedStatement ps  = null;
   		try{
   			Class.forName("com.mysql.jdbc.Driver");
   			Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
   			Statement stmt_mysql = conn_mysql.createStatement();
   			if(Userid.length() == 0){
   				
   			} else{
   				if(Userid.length()==0) {
   					cnt++;
   				}
   				if(Nartist.length()==0) {
   					cnt++;
   				}
   				String WhereDefault = "select a_artistname from log_artist";
   				String WhereString = " where a_id  = '" + Userid + "' and a_artistname = '" + Nartist +"'";
   				
   				ResultSet rs = stmt_mysql.executeQuery(WhereDefault + WhereString);
   				
   				while(rs.next()){
   					request.getParameter("a_artistname");
   					count++;
   					}
   					if(count != 0) {	
%>
   	<table align = center>
   		<tr>
   			<td><h3></br></br>이미 리스트에 존재하는 아티스트입니다.</h3></td>
   		</tr>
   		<tr>
   			<td align = center><form action = bMain2.jsp method = get>
   			<input type = submit value = Main class = "button_small button1"></form></td>
   		</tr>
   	</table>
   					
   								
<%	   			
   					}else{
   						if(count==0){
   						String A = "insert into log_artist (a_id,a_artistname) ";
   						String B = "values (?,?)";
	   			
   						ps = conn_mysql.prepareStatement(A+B);
   						ps.setString(1, Userid);
   						ps.setString(2, Nartist);
   						ps.executeUpdate();
   						conn_mysql.close();
   							}
   						}
   					}
   		
   					}catch(Exception e){
   						e.printStackTrace();
   					}
   					response.sendRedirect("artistList_update02.jsp");
	   
	   
   %>
				
				

</body>
</html>