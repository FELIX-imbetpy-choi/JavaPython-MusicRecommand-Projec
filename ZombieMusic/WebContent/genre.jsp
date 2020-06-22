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
      <form action = genre.jsp method = get>
      <input type = submit class = "button_small button1 keep_right" value = '장르'></form>
<%@include file = "IncludebookSearch.jsp" %>
<%@include file = "IncludedbConnect.jsp" %>
	<table border=0 frameborder=0 align = center width = 80%>
<tr>
<td colspan=4 style='text-align:left;vertical-align:bottom;color:white;font-size:30pt;font-weight: bold' height=150>
Genre
</td>
</tr>
<tr>
		<tr>
			<td align="center"><a href="judge.jsp?genre=clst_acoustic"><img src="image/acoustic.png" width="400"></a></td>
			<td align="center"><a href="judge.jsp?genre=clst_danceability"><img src="image/dance.png" width="400"></a></td> 
		</tr>
		
		<tr>
			<td align="center"><a href="judge.jsp?genre=clst_instrumentalness"><img src="image/instrument.png" width="400"></a></td>
			<td align="center"><a href="judge.jsp?genre=clst_loudness"><img src="image/loudness.png" width="400"></a></td>
		</tr>
		
		<tr>
			<td align="center"><a href="judge.jsp?genre=clst_popularity"><img src="image/popular.png" width="400"></a></td>
			<td align="center"><a href="judge.jsp?genre=clst_speechiness"><img src="image/speech.png" width="400"></a></td>
		</tr>
	</table>
	
</body>
</html>