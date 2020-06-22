<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 탈퇴</title>
</head>
<body id="backgroundUP">
<%@include file = "IncludeStyle.jsp" %>

<%
	// 로그인 정보 체크(없으면 로그인 페이지로 바로 이동)
	if(session.getAttribute("ID") == null){
	    response.sendRedirect("bMain.jsp");
	}else{ 
%>

<%=(String)session.getAttribute("ID") %>
님의 탈퇴가 완료되었습니다.<br/> 그동안 좀비뮤직을 사랑해주셔서 감사합니다.<br/>

<%
	}
%>

</body>
</html>