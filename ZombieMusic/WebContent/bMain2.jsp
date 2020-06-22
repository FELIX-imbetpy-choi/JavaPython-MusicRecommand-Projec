<%@page import="java.sql.*"%>
<%@page import="com.semi.funtion.function"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>

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
      <form action = genre.jsp method = get>
      <input type = submit class = "button_small button1 keep_right" value = '장르'></form>
<%@include file = "IncludebookSearch.jsp" %>
<%@include file = "IncludedbConnect.jsp" %>
       
<%
    request.setCharacterEncoding("utf-8");

// 아이디 값 바꾸기
String A = "select artist_name, track_name, images, url, music.seq, log_play.playlog from music, log_play where log_play.l_uid ='" + session.getAttribute("ID")+ "' and log_play.l_seq = music.seq order by log_play.playlog  desc limit 8;";
   
try {
  Class.forName("com.mysql.jdbc.Driver");
  Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
  Statement stmt_mysql = conn_mysql.createStatement();
  // SQL 문 실행 결과 ps
  ResultSet ps = stmt_mysql.executeQuery(A);
%>

<form action = bClickSearch.jsp method = get>
<table border=0 frameborder=0 align = center width = 80%>
<tr>
<td colspan=4 style='text-align:left;vertical-align:bottom;color:white;font-size:30pt;font-weight: bold' height=150>
Recently Played
</td>
</tr>
<tr>

<%
  int cnt = 0;
  int line = 0;

  while(ps.next()){
      cnt++;
%>

<td style='text-align:center;vertical-align:top;color:gray;font-size:12pt' >
<a href="bClickSearch.jsp?seq=<%=ps.getString(5)%>">
<img src="<%=ps.getString(3)%>" width="300"></a>
<br/><%=ps.getString(1) %><br/><%=ps.getString(2) %></td>


<%
      if(cnt % 4 == 0){
         line++;
%>
</tr>

<%
      }         
   }
  conn_mysql.close();
} catch (Exception e) {
  e.printStackTrace();
}
%>

<%
}
%>


<!-- --------------------------------- 추가 아티스트 기반 추천 띄우기------------------------------------------- -->

<%@include file = "IncludedbConnect.jsp" %>       
<%
  request.setCharacterEncoding("utf-8");

// 해당 사용자의 아티스트 목록이 나오도록 ID값으로 수정하기
String A = "select distinct(track_name), artist_name,   images, url, music.seq from music, log_artist where log_artist.a_id ='" + session.getAttribute("ID") + "' and log_artist.a_artistname = music.artist_name  order by rand() limit 8;";
try {
  Class.forName("com.mysql.jdbc.Driver");
  Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
  Statement stmt_mysql = conn_mysql.createStatement();
  // SQL 문 실행 결과 ps
  ResultSet ps = stmt_mysql.executeQuery(A);
%>

<form action = bClickSearch.jsp method = get>
<table border=0 frameborder=0 align = center width = 80%>
<tr>
<td colspan=4 style='text-align:left;vertical-align:bottom;color:white;font-size:30pt;font-weight: bold' height=150>
My Artist
</td>
</tr>
<tr>
<%
  int cnt = 0;
  int line = 0;

  while(ps.next()){
      cnt++;
%>

<td style='text-align:center;vertical-align:top;color:gray;font-size:12pt'>
<a href="bClickSearch.jsp?seq=<%=ps.getString(5)%>">
<img src="<%=ps.getString(3)%>" width="300"></a>
<br/><%=ps.getString(2) %><br/><%=ps.getString(1) %></td>

<%
      if(cnt % 4 == 0){
         line++;
%>
</tr>

<%
      }         
   }
  conn_mysql.close();
} catch (Exception e) {
  e.printStackTrace();
}
%>

<%

%>

<!-- --------------------------------- 추천곡 띄우기------------------------------------------- -->
<%
	function rj = new function();

 String id = (String)session.getAttribute("ID");
 ArrayList<String> musicnums = rj.RrandomForestRegressor(id);
    
    request.setCharacterEncoding("utf-8");
%>
 
 	<form action = bClickSearch.jsp method = get>
	<table border=0 frameborder=0 align = center width = 80%>
	<tr colspan=4 style='text-align:left;vertical-align:bottom;color:white;font-size:30pt;font-weight: bold' height=150>
	<td>Recommend Music</td>
	</tr>
 	<tr>
<%	
	int cnt = 0;
    for (int i = 0; i < musicnums.size(); i++) {
    	cnt = cnt + 1;
	    // 해당 사용자의 아티스트 목록이 나오도록 ID값으로 수정하기
	    String B = "select artist_name, track_name, images, url, music.seq from music, users where users.id = "+ id +" and music.seq="+musicnums.get(i)+";";
	       
	    try {
	      Class.forName("com.mysql.jdbc.Driver");
	      Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
	      Statement stmt_mysql = conn_mysql.createStatement();
	      // SQL 문 실행 결과 ps
	      ResultSet ps = stmt_mysql.executeQuery(B);
    
%>

<%
		  
		  while(ps.next()){
			  
%>

<td style='text-align:center;vertical-align:top;color:gray;font-size:12pt' >
<a href="bClickSearch.jsp?seq=<%=ps.getString(5)%>">
<img src="<%=ps.getString(3)%>" width="300"></a>
<br/><%=ps.getString(1) %><br/><%=ps.getString(2) %></td>

<%
		  }
		  conn_mysql.close();
		} catch (Exception e) {
		  e.printStackTrace();
		}
		
		if(cnt % 4 == 0){
%>
		</tr>
<%
		}
    }
%>		
	
</table>
</form>

</body>
</html>