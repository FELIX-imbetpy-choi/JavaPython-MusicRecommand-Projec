<%@page import="java.sql.*"%>
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
   if(session.getAttribute("ID") != null){
       response.sendRedirect("bMain2.jsp");
   }else{ 
%>
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
      <form  action = halfInsert_01.jsp method = get>
      <input type = submit class = "button_small button1 keep_right" value = '회원가입'></form>
      <form action = Login.jsp method = post>
      <input type = submit class = "button_small button1 keep_right" value = "로그인"></form>
<%@include file = "IncludedbConnect.jsp" %>
       
<%
      request.setCharacterEncoding("utf-8");

    String A = "select track_name,seq, images from music limit 10";
       
   try {
      Class.forName("com.mysql.jdbc.Driver");
      Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
      Statement stmt_mysql = conn_mysql.createStatement();
      // SQL 문 실행 결과 ps
      ResultSet ps = stmt_mysql.executeQuery(A);
%>

    <form action = bClickSearch.jsp method = get>
   <table border = 0 align = center width = 80%>
   <tr>
<%
      int cnt = 0;
      int line = 0;

      while(ps.next()){
          cnt++;
                %><td align = center><a href="bClickSearch.jsp?seq=<%=ps.getString(2) %>">
                <img src="<%=ps.getString(3) %>" width="150"></td><%
          if(cnt % 5 == 0){
             line++;
             %></tr><%
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

</table>
</form>

</body>
</html>