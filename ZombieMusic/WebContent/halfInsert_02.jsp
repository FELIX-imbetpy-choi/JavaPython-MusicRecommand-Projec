<%@page import="java.nio.channels.SeekableByteChannel"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 결과</title>
</head>

<%@include file = "IncludeStyle.jsp" %>

	<body id="backgroundUP">
   <a href="bMain2.jsp" class="ico_join"><span class="ir_wa"><img src = zm_01.gif></span></a>
	
    <!-- 데이터 베이스 연결 -->
	<%@include file = "IncludedbConnect.jsp" %>
	

<%
	request.setCharacterEncoding("utf-8");

	String Userid = request.getParameter("userid");
	String Pw = request.getParameter("pw");
	String Name = request.getParameter("name");
	String Age = request.getParameter("age");
	String Gender = request.getParameter("gender");
	String Artist = request.getParameter("artist");
	String Email = request.getParameter("email");
	
	session.setAttribute("ID", Userid);

	int count = 0;
	int cnt = 0;
	PreparedStatement ps = null;
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
		Statement stmt_mysql = conn_mysql.createStatement();
		if(Userid.length() == 0){
%>
				<table align = center>
	<tr>
		<td style='color:white'><h3></br></br>아이디를 입력하세요!</h3></td>
	</tr>
	<tr>
		<td align = center><form action = halfInsert_01.jsp method = get>
		<input type = submit value = 회원가입하기 class = "button_small button1"></form></td>
	</tr>
</table>
			
<%
		} else{
			if(Name.length()==0) {
				cnt++;
			}
			if(Age.length()==0) {
				cnt++;
			}
			
			if(Email.length()==0) {
				cnt++;
			}
			if(Pw.length()==0) {
				cnt++;
			}
			if(Gender.length()==0) {
				cnt++;
			}
			if(Artist.length()==0) {
				cnt++;
			}
			String WhereDefault = "select id from users";
			String WhereString = " where id  = '" + Userid + "'";
			
			ResultSet rs = stmt_mysql.executeQuery(WhereDefault + WhereString);
			
			while(rs.next()){
				request.getParameter("id");
				count++;
				}
				if(count != 0) {
%>
<table align = center>
	<tr>
		<td style='color:white'><h3></br></br>이미 존재하는 아이디 입니다. 다시 입력해주십시오.</h3></td>
	</tr>
	<tr>
		<td align = center><form action = halfInsert_01.jsp method = get>
		<input type = submit value = 회원가입하기 class = "button_small button1"></form></td>
	</tr>
</table>
				
							
<%
				}else{
					
				
				if(cnt!=0){
	%>
					
						<table align = center>
	<tr>
		<td style='color:white'><h3></br></br>필수 정보를 입력해주세요!</h3></td>
	</tr>
	<tr>
		<td align = center><form action = halfInsert_01.jsp method = get>
		<input type = submit value = 회원가입하기 class = "button_small button1"></form></td>
	</tr>
</table>		
								
	<%
				}else{
				if(count==0){
					String A = "insert into users (id, pw, name, age, gender, email) ";
					String B = "values (?,?,?,?,?,?)";
					String C = "insert into log_artist (a_id, a_artistname) ";
					String D = "values (?,?)";
					
					ps = conn_mysql.prepareStatement(A + B);
					ps.setString(1, Userid);
					ps.setString(2, Pw);
					ps.setString(3, Name);
					ps.setString(4, Age);
					ps.setString(5, Gender);
					ps.setString(6, Email);
					ps.executeUpdate();
					
					ps = conn_mysql.prepareStatement(C + D);
					ps.setString(1, Userid);
					ps.setString(2, Artist);
					ps.executeUpdate();
				}
%>
						<table align = center>
	<tr>
		<td style='color:white'><h3></br></br>가입을 축하드립니다.</h3></td>
	</tr>
	<tr>
		<td align = center><form action = bMain2.jsp method = get>
		<input type = submit value = "홈으로 이동" class = "button_small button1"></form></td>
	</tr>
</table>
			
<%
				}
			}
		}
		conn_mysql.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
	
%>

</body>
</html>