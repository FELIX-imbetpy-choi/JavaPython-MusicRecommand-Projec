<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="UTF-8">
<title>아티스트 추가 완료</title>

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

<%
	// 로그인 정보 체크(없으면 로그인 페이지로 바로 이동)
	if(session.getAttribute("ID") == null){
	    response.sendRedirect("bMain.jsp");
	}else{ 
%>
<table align = center>
	<tr>
		<td style='text-align:center;vertical-align:bottom;color:white;font-size:30pt;font-weight: bold' height=500>
<%=(String)session.getAttribute("NARTIST") %>
가 추가 되었습니다.<br/><br/><br/></td>
    </tr>
	<tr>
		<td style='text-align:center;'>
		<form action = bMain2.jsp method = get>
      	<input type = submit class = "button_small button1" value = "홈으로 이동"></form></td>
    </tr>
</table>
    
<%
	}
%>    
    
</body>
</html>