<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="UTF-8">
<title>플레이리스트 추가</title>

<%@include file = "IncludeStyle.jsp" %>
    
<script src="//code.jquery.com/jquery-1.12.4.min.js"></script>

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
   // 로그인 정보 체크(없으면 로그인 페이지로 바로 이동)
   if(session.getAttribute("ID") == null){
       response.sendRedirect("bMain.jsp");
   }else{ 
%>

<form action = halfupdate_01.jsp method = get>
<table border=0 frameborder=0 align = center width = 80%>
	<tr>
		<td colspan=4 style='text-align:left;vertical-align:bottom;color:white;font-size:30pt;font-weight: bold' height=150>
		Playlist 추가
		</td>
	</tr>
	<tr>
        <td align=left>사용자ID : <input type = text name= name value="<%=(String)session.getAttribute("ID") %>" size=10 class = "div2 button1" readonly=readonly></td>
	</tr>
	<tr>
        <td align=left>곡명 :  <input type = text name= name value="<%=(String)session.getAttribute("TNAME") %>" size=10 class = "div2 button1" readonly=readonly></td>
	</tr>
	<tr>	
        <td align=left>아티스트 : <input type = text name= name value="<%=(String)session.getAttribute("ANAME") %>" size=10 class = "div2 button1" readonly=readonly></td>
	</tr>
	<tr>
        <td align=left>플레이리스트에 추가 되었습니다.</td>
    </tr>
    </form>
<form action = bUserMain.jsp method = get>
<input type = submit value = 플레이리스트 class = "button_search button1 keep_left">
<form action = bMain2.jsp method = get>
<input type = submit value = 게시판 class = "button_search button1 keep_left">
<%
   }
%>

</body>
</html>