<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="UTF-8">
<title>아티스트 정보</title>

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

<%	
	request.setCharacterEncoding("utf-8");

   	String A = "select distinct artist_name from music ";
   	String B = " where artist_name not in(select a_artistname from log_artist where log_artist.a_id = '" + session.getAttribute("ID")+ "') order by artist_name";
   
   	try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
			Statement stmt_mysql = conn_mysql.createStatement();
			
			ResultSet rs = stmt_mysql.executeQuery(A+B);
			
			%>
	<form action = artistList_update01.jsp method = get>
	<table class = "center" >
		<tr>
           	<td colspan=2 style='text-align:left;vertical-align:bottom;color:white;font-size:30pt;font-weight: bold' height=150>
           	My Artist</td>
        </tr>
		<tr>
        	<td colspan=2 height=10></td>
        </tr>
		<tr>	
			<td style='text-align:left;vertical-align:center;color:gray;font-size:15pt;font-weight: bold' height=20>
			사용자 ID</td><td><input type = text name=userid value=<%=(String)session.getAttribute("ID")%> size = 10 readonly=readonly class = "div1 button1"></td>
		</tr>
		<tr>
			<td style='text-align:left;vertical-align:center;color:gray;font-size:15pt;font-weight: bold' height=20>
			아티스트</td>
    		<td><select name="artist">
			<option value="아티스트를 선택해주세요" selected>아티스트를 선택해주세요</option>
<%		
			while(rs.next()) {
				String NewArtist = rs.getString(1);
%>
			<option value="<%=rs.getString(1) %>"><%=rs.getString(1) %></option>
<%
			}
				conn_mysql.close();
	   		}catch(Exception e){
	   	e.printStackTrace();		
		}
	
		%>
			</select></td>
		</tr>
		<tr>
			<td>
			<input type = submit value = '추가' name=update class = "button_search button1"></form>
			</td>
		</tr>  
	</table>

<%	
	}
%>



</body>
</html>