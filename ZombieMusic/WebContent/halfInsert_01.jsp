<%@page import="java.sql.*" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<%@include file = "IncludeStyle.jsp" %>

</head>
<%@include file = "IncludedbConnect.jsp" %>
<body id="backgroundUp">
<table class = "center" >
	<tr>
		<td colspan=2 style='text-align:left;vertical-align:bottom;color:white;font-size:30pt;font-weight: bold' height=150>
		회원가입 
		</td>
	</tr>
	<tr>
		<td height=20></td>
	</tr>
    <form action = halfInsert_02.jsp method = get>
	<tr>
		<td style='text-align:left;vertical-align:center;color:gray;font-size:15pt;font-weight: bold' height=20>아이디</td>
		<td><input type="text" name=userid class = "div1 button1" 
                                       value="" autocomplete="off" maxlength="15"></td>
	</tr>
	<tr>
		<td style='text-align:left;vertical-align:center;color:gray;font-size:15pt;font-weight: bold' height=20>비밀번호</td>
		<td><input type="password" name=pw class = "div1 button1"
                                       value="" maxlength="32"></td>
    </tr>
	<tr>
		<td style='text-align:left;vertical-align:center;color:gray;font-size:15pt;font-weight: bold' height=20>이름</td>
		<td><input type="text" name=name class = "div1 button1" value=""
                                       maxlength="30"></td>
    </tr>
    <tr>
    	<td style='text-align:left;vertical-align:center;color:gray;font-size:15pt;font-weight: bold' height=20>나이</td>
    	<td><select name="age">
									<option value="0" selected>연령대를 선택해주세요</option>
									<option value="10">10대</option>
									<option value="20">20대</option>
									<option value="30">30대</option>
									<option value="40">40대</option>
									<option value="50">50대</option>
									<option value="60">60대</option>
									<option value="70">70대</option>
								</select></td>
	</tr>
	<tr>
		<td style='text-align:left;vertical-align:center;color:gray;font-size:15pt;font-weight: bold' height=20>성별</td>
		<td style='text-align:left;vertical-align:center;color:gray;font-size:15pt;font-weight: bold' height=20><input type = "radio" name = "gender" value = "male" checked = "checked">남
			<input type = "radio" name = "gender" value = "female">여</td>
	</tr>
	<tr>
		<td style='text-align:left;vertical-align:center;color:gray;font-size:15pt;font-weight: bold' height=20>아티스트</td>
		<td><select name="artist">

									<option value="아티스트를 선택해주세요" selected>아티스트를 선택해주세요</option>
<% 

String WhererDefault = "select artist_name from music where popularity > 89 group by artist_name";   

try {
  Class.forName("com.mysql.jdbc.Driver");
  Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
  Statement stmt_mysql = conn_mysql.createStatement();
  
  ResultSet rs = stmt_mysql.executeQuery(WhererDefault);
  while(rs.next()) {
	  //안녕하세요 요한님^^
 %> 
									<option value="<%=rs.getString(1) %>"><%=rs.getString(1) %></option>
 <%
      }
      conn_mysql.close();
		} catch (Exception e) {
	    e.printStackTrace();
	 }
%>
                                </select></td>
	</tr>
	<tr>
		<td style='text-align:left;vertical-align:center;color:gray;font-size:15pt;font-weight: bold' height=20>이메일</td>
		<td><input type="text" id="email" name="email" class = "div1 button1"
                                       value="" autocomplete="off"></td>
   	</tr>
	<tr>
		<td colspan=2>
                <button type="submit" class = "button_small button1">확인</button>
	    </td>
	</tr>
</table>
</form>
	
</body>
</html>