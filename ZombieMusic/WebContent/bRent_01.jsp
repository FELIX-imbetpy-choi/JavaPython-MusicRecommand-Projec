<%@page import="java.sql.*" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반납 신청</title>
</head>
<body id="backgroundUP">
		<form  action = bUserMain.jsp method = get>
		<input type = submit class = "button_small button1 keep_right" value = '마이페이지'></form>
  	    <form action = Logout.jsp method = post>
        <input type = submit class = "button_small button1 keep_right" value = "로그아웃"></form>
<table align = center>
	<tr>
		<td height = 400>
		<a href="bMain.jsp" id="daumServiceLogo" class="ico_join"><span class="ir_wa"><img src = zm_1.gif></span></a>
		</td>
	</tr>
</table>
<%@include file = "IncludeStyle.jsp" %>
    <!-- 데이터 베이스 연결 -->
   <%@include file = "IncludedbConnect.jsp" %>
<table>
</table>

<%
    request.setCharacterEncoding("utf-8");
	String Seq = request.getParameter("seq");
    String Tname = request.getParameter("track_name");
    String Muserid = request.getParameter("userid");
    String Aname = request.getParameter("artist_name");
    String Images = request.getParameter("images");
    
    session.setAttribute("SEQ", Seq);
    session.setAttribute("ANAME", Aname);
    session.setAttribute("TNAME", Tname);
    session.setAttribute("MUSERID", Muserid);
    session.setAttribute("IMAGES", Images);
    
    String WhererDefault = "select track_name from music,log_playlist where p_seq = '" + Seq + "'and p_id ='"+ session.getAttribute("ID") +"'";   

    int cnt = 0;
    PreparedStatement ps = null;
      try {
         Class.forName("com.mysql.jdbc.Driver");
         Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
         Statement stmt_mysql = conn_mysql.createStatement();
         ResultSet rs = stmt_mysql.executeQuery(WhererDefault);
         
         while (rs.next()) {
            request.getParameter("p_trackname");
            cnt++;
            
         }
         conn_mysql.close();
         } catch (Exception e) {
            e.printStackTrace();
         }
      
         if(cnt!=0){
%>
<table align = center>
	<tr>
		<td style='text-align:left;vertical-align:center;color:gray;font-size:15pt;font-weight: bold' height=20><h3></br></br>이미 대여한 책입니다.</h3></td>
	</tr>
	<tr>
		<td align = center><form action = bMain2.jsp method = get>
		<input type = submit value = 뒤로 class = "button_small button1"></form></td>
	</tr>
</table>
<%
         }else{

            try {
               Class.forName("com.mysql.jdbc.Driver");
               Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
               Statement stmt_mysql = conn_mysql.createStatement();
               String A = "insert into log_playlist (p_id, p_trackname,p_artistname, p_seq, p_images, insertdate)";
	           String B = " values (?,?,?,?,?,now())";
	            
	           ps = conn_mysql.prepareStatement(A+B);
	           ps.setString(1, (String)session.getAttribute("ID"));
	           ps.setString(2, Tname);
	           ps.setString(3, (String)session.getAttribute("ANAME"));
	           ps.setString(4, (String)session.getAttribute("SEQ"));
	           ps.setString(5, Images);
           	   ps.executeUpdate();



            conn_mysql.close();
         } catch (Exception e) {
            e.printStackTrace();
         }
         //잘되면 알려줘야지
         response.sendRedirect("bRent_02.jsp");
         }
%>
</body>
</html>