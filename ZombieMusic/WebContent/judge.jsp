<%@page import="org.apache.jasper.tagplugins.jstl.core.If"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>Like Spotify</title>

<%@include file = "IncludeStyle.jsp" %>
    
<script src="//code.jquery.com/jquery-1.12.4.min.js"></script>

<%
   // 로그인 정보 체크(없으면 로그인 페이지로 바로 이동)
   if(session.getAttribute("ID") == null){
       response.sendRedirect("bMain.jsp");
   }else{ 
	   
   }
%>
<%@include file = "IncludeSearchbar.jsp" %>
</head>

<body id="backgroundUP">
 <form action = Logout.jsp method = post>
      <input type = submit class = "button_small button1 keep_right" value = "로그아웃"></form>
      <form action = halfmypage.jsp method = post>
      <input type = submit class = "button_small button1 keep_right" value = "회원정보"></form>
      <form  action = bUserMain.jsp method = get>
      <input type = submit class = "button_small button1 keep_right" value = '플레이리스트'></form>
      <form action = artistList.jsp method = get>
      <input type = submit class = "button_small button1 keep_right" value = '아티스트'></form>
<%@include file = "IncludebookSearch.jsp" %>
<%@include file = "IncludedbConnect.jsp" %>
	<%
		
		request.setCharacterEncoding("utf-8");
		String genre = request.getParameter("genre");
		
 	    
		String WhererDefault = "select artist_name, track_name, url, images, seq from music where "+ genre + " order by "+ genre + " desc limit 100";
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
			Statement stmt_mysql = conn_mysql.createStatement();
			
			ResultSet rs = stmt_mysql.executeQuery(WhererDefault);	
	%>
		<table border = 0 align = center width = 80%>
		<table border=0 frameborder=0 align = center width = 80%>
<tr>
<td colspan=4 style='text-align:left;vertical-align:bottom;color:white;font-size:30pt;font-weight: bold' height=150>
Genre
</td>
</tr>
	<%
	    int cnt = 0;
			while(rs.next()) {
				cnt++;
	%>
				
				<td style='text-align:center;vertical-align:top;color:gray;font-size:12pt'><a href="bClickSearch.jsp?seq=<%= rs.getString(5) %>"><img src=<%= rs.getString(4) %> width="300"></a><!-- 이미지, 새탭에서 열리게 -->
					<br/><b><%= rs.getString(1) %></b><br/> <!-- 아티스트 -->
					<%= rs.getString(2) %>
				</td> <!-- 트랙 -->
				
	<%
				if(cnt % 4 == 0){
	%>
				</tr>	
	<%
				}
			}
				conn_mysql.close();
					
	%>
		</table>
	<%
			} catch (Exception e) {
				e.printStackTrace();
			}
	%>

</body>
</html>