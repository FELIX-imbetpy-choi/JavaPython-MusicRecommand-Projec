<%@page import="java.sql.*" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="UTF-8">
<title>플레이리스트</title>


<%@include file = "IncludeStyle.jsp" %>
    
<script src="//code.jquery.com/jquery-1.12.4.min.js"></script>
<%@include file = "IncludeSearchbar.jsp" %>
</head>

<body id="backgroundUP">

<%
   // 로그인 정보 체크(없으면 로그인 페이지로 바로 이동)
   if(session.getAttribute("ID") == null){
       response.sendRedirect("bMain.jsp");
   }else{ 
%>
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
         
    String C = "select p_trackname,p_seq,p_images, p_artistname from log_playlist";
    String D = " where p_id = '" +(String)session.getAttribute("ID") + "'";
    
   try {
      Class.forName("com.mysql.jdbc.Driver");
      Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
      Statement stmt_mysql = conn_mysql.createStatement();
      ResultSet ps = stmt_mysql.executeQuery(C+D);
      
%>
      <form action = bUserMain_02.jsp method = get>
<table border=0 frameborder=0 align = center width = 80%>
<tr>
<td colspan=3 style='text-align:left;vertical-align:bottom;color:white;font-size:30pt;font-weight: bold' height=150>
My Playlist
</td>
</tr>

<%
      int c = 0;
      while(ps.next()) {
%>
         <tr>
            <td style='text-align:center;vertical-align:top;color:white;font-size:12pt'><a href="bClickSearch.jsp?seq=<%=ps.getString(2) %>">
                <img src="<%=ps.getString(3) %>" width="150"></td>
         
            <td style='text-align:center;vertical-align:top;color:white;font-size:12pt'><%=ps.getString(1) %></td>

            <td style='text-align:center;vertical-align:top;color:white;font-size:12pt'><%if(ps.getString(4)==null){out.println("");}else{%><%=ps.getString(4)%><%;}%></td>
            
         </tr>
<%
      c++;
      }
      
%>
      </table>
      
   
       </form>

 
<%
      conn_mysql.close();
   } catch (Exception e) {
      e.printStackTrace();
   }
%>

<%
   }
%>

</body>
</html>