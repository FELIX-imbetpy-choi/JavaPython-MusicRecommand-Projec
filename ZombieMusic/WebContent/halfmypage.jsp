<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원정보</title>

<%@include file = "IncludeStyle.jsp" %>

<script src="//code.jquery.com/jquery-1.12.4.min.js"></script>

<%
	// 로그인 정보 체크(없으면 로그인 페이지로 바로 이동)
	if(session.getAttribute("ID") == null){
	    response.sendRedirect("bMain.jsp");
	}else{ 
%>

<%@include file = "IncludeSearchbar.jsp" %>
</head>

<body id="backgroundUP">
      <form action = Logout.jsp method = post>
      <input type = submit class = "button_small button1 keep_right" value = "로그아웃"></form>
      <form  action = bUserMain.jsp method = get>
      <input type = submit class = "button_small button1 keep_right" value = '플레이리스트'></form>
      <form action = artistList.jsp method = get>
      <input type = submit class = "button_small button1 keep_right" value = '아티스트'></form>
      <form action = genre.jsp method = get>
      <input type = submit class = "button_small button1 keep_right" value = '장르'></form>
    
<%@include file = "IncludebookSearch.jsp" %>
<%@include file = "IncludedbConnect.jsp" %>

<%	
	request.setCharacterEncoding("utf-8");

   	String A = "select id, pw, name, age, gender, email from users";
   	String B = " where id = '"+session.getAttribute("ID")+"'";
   
   	try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
			Statement stmt_mysql = conn_mysql.createStatement();
			
			ResultSet rs = stmt_mysql.executeQuery(A+B);
		
			while(rs.next()) {
				String Userid = rs.getString(1);
				String Userpw = rs.getString(2);
				String Username = rs.getString(3);
				String Userage = rs.getString(4);
				String Usergender = rs.getString(5);
				String Useremail = rs.getString(6);			
%>

	<form action = halfupdate_01.jsp method = get>
	<table class = "center" >
		<tr>
           	<td colspan=2 style='text-align:left;vertical-align:bottom;color:white;font-size:30pt;font-weight: bold' height=150>
           	회원 정보</td>
        </tr>
		<tr>
        	<td colspan=2 height=10></td>
        </tr>
		<tr>	
			<td style='text-align:left;vertical-align:center;color:gray;font-size:15pt;font-weight: bold' height=20>
			사용자 ID</td>
			<td><input type = text name=userid value=<%=(String)session.getAttribute("ID")%> size = 15 readonly=readonly class = "div1 button1"></td>
		</tr>
		<tr>	
			<td style='text-align:left;vertical-align:center;color:gray;font-size:15pt;font-weight: bold' height=20>
			비밀번호</td><td><input type = text name= pw value="<%=Userpw%>" size=15 class = "div1 button1"><br/></td>
		</tr>
		<tr>
			<td style='text-align:left;vertical-align:center;color:gray;font-size:15pt;font-weight: bold' height=20>
			이름</td><td><input type = text name=name value="<%=Username%>" size = 15 class = "div1 button1"><br/></td>
		</tr>
		<tr>
			<td style='text-align:left;vertical-align:center;color:gray;font-size:15pt;font-weight: bold' height=20>
			나이</td><td><input type = text name=age value="<%=Userage%>" size = 15 class = "div1 button1"></td>
		</tr>
		<tr>
			<td style='text-align:left;vertical-align:center;color:gray;font-size:15pt;font-weight: bold' height=20>
			성별</td><td><input type = text name=gender value="<%=Usergender%>" size = 15 class = "div1 button1"></td>
		</tr>
		<tr>	
			<td style='text-align:left;vertical-align:center;color:gray;font-size:15pt;font-weight: bold' height=20>
			이메일</td><td><input type = text name=email value="<%=Useremail%>" size = 15 class = "div1 button1"></td>
		</tr>	
		<tr>
			<td height=20 colspan=2>
			</td>
		</tr>
		<tr>
			<td style='text-align:right;vertical-align:center;'><input type = submit value = '수정' name=update class = "button_small button1"></form></td>
			<td style='text-align:left;vertical-align:center;'><form action = halfdelete_01.jsp method = get>
			<input type = submit value = '탈퇴' name=delete class = "button_small button1"></form></td>
		</tr>
	</table>

<%	
			}
				conn_mysql.close();
	   		}catch(Exception e){
	   	e.printStackTrace();		
		}
	
%>

<%
	}
%>

	</table>

</body>
</html>