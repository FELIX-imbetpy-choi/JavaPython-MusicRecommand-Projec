<%@page import="java.sql.*" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="UTF-8">
<title>검색결과 상세정보</title>

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

<%
	// 로그인 정보 체크(없으면 로그인 페이지로 바로 이동)
	if(session.getAttribute("ID") == null){
	    response.sendRedirect("Login.jsp");
	}else{ 
%>

<%@include file = "IncludebookSearch.jsp" %>
<%@include file = "IncludedbConnect.jsp" %>

<%
	// 곡 정보 보여주기
String Seq = request.getParameter("seq");
session.setAttribute("SEQ", Seq);
String WhererDefault = "select track_name, artist_name, date, seq, url,images from music where seq = '" + Seq + "'";   

int cnt = 1;
PreparedStatement ps = null;
try {
  Class.forName("com.mysql.jdbc.Driver");
  Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
  Statement stmt_mysql = conn_mysql.createStatement();
  String A = "insert into log_play (l_uid, l_seq, counts, playlog)";
  String B = " values (?,?,?,now())";
  ps = conn_mysql.prepareStatement(A+B);
  ps.setString(1, (String)session.getAttribute("ID"));
  ps.setString(2, (String)session.getAttribute("SEQ"));
  ps.setInt(3, (int)(cnt));
  ps.executeUpdate();
  
  ResultSet rs = stmt_mysql.executeQuery(WhererDefault);
  while(rs.next()) {
%>
	<form action = bRent_01.jsp method = get>
	<table>
		<tr>
           	<td colspan=3 style='text-align:left;vertical-align:bottom;color:white;font-size:30pt;font-weight: bold' height=150>
            선택한 곡 상세정보</td>
        </tr>
		<tr>
        	<td colspan=3 height=50></td>
        </tr>
		<tr>
			<td rowspan=5><a href="<%=rs.getString(5)%>" target="_blank">
			<img src="<%=rs.getString(6)%>" width="150"></a></td>
			<td width=30></td>
			<td style='text-align:left;vertical-align:center;color:white;font-size:30pt;font-weight: bold'>
			<input type="text" name=track_name class = "button_small button1"
                                       value="<%=rs.getString(1) %>"readonly=readonly autocomplete="off" size = 30></td> 
		</tr>
		<tr><form action = artistList_update01.jsp method = get>
			<td width=30></td>
			<td>
			<input type=text name=artist_name class = "button_small button1"
                       value="<%=rs.getString(2) %>"readonly=readonly size = 30></td> 
		</tr>
		<tr>
			<td width=30></td>
			<td>
			<input type="text" name=date class = "button_small button1" value="<%=rs.getString(3) %>"readonly=readonly
                                       size = 30></td>
		</tr>
		<tr>
			<td width=30></td>
			<td>
			<input type="text" name=seq class = "button_small button1" value="<%=rs.getString(4) %>"readonly=readonly
                                       size = 30></td>
		</tr>
		<tr>
			<td width=30></td>
			<td>
			<input type="text" name=images class = "button_small button1" value="<%=rs.getString(6) %>"readonly=readonly
                                       size = 30></td>
		</tr>
		<tr>
			<td colspan=3 height=20>
			</td>
		</tr>
		<tr>
			<td style='text-align:right;'>
			<form action = artistList_update01.jsp method = get>
			<input type = submit value = '아티스트 추가' name=artist class = "button_small button1"></form>
			</td>
			<td width=30></td>
			<td>

			<input type = submit class = "button_small button1" value = '플레이리스트에 담기'></form>
			</td>
		</tr>
	</table>

<%
      }
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