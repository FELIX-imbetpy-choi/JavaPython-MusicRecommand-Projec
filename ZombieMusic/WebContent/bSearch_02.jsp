<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="UTF-8">
<title>검색 결과</title>

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

<!-- 데이터 베이스 연결 -->
<%@include file = "IncludedbConnect.jsp" %>

<%
   request.setCharacterEncoding("utf-8");

   String searchtext = request.getParameter("searchtext");

   session.setAttribute("SEARCHTEXT", searchtext); 
    
   int cnt = 0;

   try{
      Class.forName("com.mysql.jdbc.Driver");
      Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
      Statement stmt_mysql = conn_mysql.createStatement();

      if(searchtext.length() == 0){
%>
 <!-- 책검색 -->
	<%@include file = "IncludebookSearch.jsp" %>
	<table align = center>
		<tr>
           <h3>검색 키워드를 입력하세요!</h3>
           <a href =bMain.jsp>게시판으로 이동</a>
        </tr>
    </table>
<%
      } else if(searchtext.length() != 0){
%>         
      <%@include file = "IncludeStyle.jsp" %>
      <%@include file = "IncludebookSearch.jsp" %>
<%  
         String searchtype = request.getParameter("searchtype");
       
         switch(searchtype) {
            
         case "곡명":
               String A = "select seq, track_name, artist_name,images from music";
               String B = " where track_name like '%" + searchtext + "%'";
               ResultSet rs = stmt_mysql.executeQuery(A + B);
      %>
           	<table>
           		<tr>
           			<td colspan=4 style='text-align:left;vertical-align:bottom;color:white;font-size:30pt;font-weight: bold' height=150>
           			검색 결과
           			</td>
           		</tr>
           		<tr>
           			<td colspan=4 height=10></td>
           		</tr>
      <%  
               while(rs.next()){
                  cnt++;
      %>
  
               <tr style='text-align:left;vertical-align:center;color:white;font-size:12pt;line-height:1.8em'>
                  <td>
                  <a href="bClickSearch.jsp?seq=<%=rs.getString(1)%>">
		          <img src="<%=rs.getString(4)%>" width="100"></a><br/></td>
                  <td width=30></td><td><%=rs.getString(2)%><br/><%=rs.getString(3)%></td>        
               </tr>
               
      <%   
               }
      %>
               </table><br>
      <% 
               break;
     
         case "가수":
               String C = "select seq, track_name, artist_name,images from music";
               String D = " where artist_name like '%" + searchtext + "%'";
               ResultSet gs = stmt_mysql.executeQuery(C + D);
      %>
              	<table>
           		<tr>
           			<td colspan=4 style='text-align:left;vertical-align:bottom;color:white;font-size:30pt;font-weight: bold' height=150>
           			검색 결과
           			</td>
           		</tr>
           		<tr>
           			<td colspan=4 height=10>
           		</tr>
      <%                
               while(gs.next()){
                  cnt++;
      %>
               <tr style='text-align:left;vertical-align:center;color:white;font-size:12pt;line-height:1.8em'>
                  <td><a href="bClickSearch.jsp?seq=<%=gs.getString(1)%>">
		          <img src="<%=gs.getString(4)%>" width="100"></a><br/></td>
                  <td width=30></td><td><%=gs.getString(2)%><br/><%=gs.getString(3)%></td>        
               </tr>
      <%   
               }
      %>
               </table><br>
      <%
               break;
               default :
                  out.println("오류입니다.");
                  
               
         }
         
         if(cnt == 0){
%>
         <h3>검색한 결과가 없습니다!</h3>
         <a href =bMain.jsp>게시판으로 이동</a>
<%                               

            }
         }
         conn_mysql.close();
      } catch (Exception e) {
      e.printStackTrace();
      }
   
%>

</body>
</html>