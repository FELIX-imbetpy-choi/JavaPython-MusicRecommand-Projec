<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="UTF-8">
<title>내 정보 수정 완료</title>

<%@include file = "IncludeStyle.jsp" %>
    
<script src="//code.jquery.com/jquery-1.12.4.min.js"></script>

<script>
      $( document ).ready( function() {
        var jbOffset = $( '.jbMenu' ).offset();
        $( window ).scroll( function() {
          if ( $( document ).scrollTop() > jbOffset.top ) {
            $( '.jbMenu' ).addClass( 'jbFixed' );
          }
          else {
            $( '.jbMenu' ).removeClass( 'jbFixed' );
          }
        });
      } );
</script>
</head>

<body id="backgroundUP">

      <form action = Logout.jsp method = post>
      <input type = submit class = "button_small button1 keep_right" value = "로그아웃"></form>
      <form  action = bUserMain.jsp method = get>
      <input type = submit class = "button_small button1 keep_right" value = '마이플레이리스트'></form>
<%@include file = "IncludebookSearch.jsp" %>
<%@include file = "IncludedbConnect.jsp" %>

<%
	// 로그인 정보 체크(없으면 로그인 페이지로 바로 이동)
	if(session.getAttribute("ID") == null){
	    response.sendRedirect("Login.jsp");
	}else{ 
%>
<table align = center>
	<tr>
		<td style='text-align:center;vertical-align:bottom;color:white;font-size:40pt;font-weight: bold' height=500>
<%=(String)session.getAttribute("ID") %>
님의 정보가 수정되었습니다.<br/><br/><br/></td>
    </tr>
	<tr>
		<td style='text-align:center;vertical-align:bottom;color:white;font-size:50pt;font-weight: bold'>
		<form action = halfmypage.jsp method = get>
      	<input type = submit class = "button_small button1" value = "회원정보로 이동"></form>
    </tr>
</table>
    
<%
	}
%>    
    
</body>
</html>