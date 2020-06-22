<%@page import="java.sql.*" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선택한 곡 상세정보</title>
</head>
<body id="backgroundUP">
 		<form  action = bUserMain.jsp method = get>
		<input type = submit class = "button_small button1 keep_right" value = '마이페이지'></form>
  	    <form action = Logout.jsp method = post>
        <input type = submit class = "button_small button1 keep_right" value = "로그아웃"></form>
   <a href="bMain.jsp" class="ico_join"><span class="ir_wa"><img src = nameButton.jpeg></span></a>

	<%@include file = "IncludedbConnect.jsp" %>
    <!-- 데이터 베이스 연결 -->

<%
	// 곡 정보 보여주기
String Seq = request.getParameter("seq");
String WhererDefault = "select track_name, artist_name, date, seq, url,images from music where seq = '" + Seq + "'";   

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
		Statement stmt_mysql = conn_mysql.createStatement();
	
		ResultSet rs = stmt_mysql.executeQuery(WhererDefault);

  while(rs.next()) {
%>
    <form action = bRent_01.jsp method = get>
        <fieldset class="fld_comm">
            <legend class="screen_out">선택한 곡 상세정보</legend>
            <div class="wrap_info">
                <div class="box_info">
                    <dl>
                        <dd>
                            <div>
                                <label>곡명 :</label>
                                <!-- 텍스트 입력 시 .screen_out  -->
                                <input type="text" name=track_name class = "button_small button1"
                                       value="<%=rs.getString(1) %>"readonly=readonly autocomplete="off" size = 30>
                            </div>
                    <dl>
                        <dt>
                                <label>가수명 :</label> <!-- 텍스트 입력 시 .screen_out  -->
                                <input type=text name=artist_name class = "button_small button1"
                                       value="<%=rs.getString(2) %>"readonly=readonly size = 30>
                            </div>
                <div class="box_info">
                    <dl>
                        <dt></dt>
                        <dd>
                            <div>
                                <label>출시일 :</label>
                                <!-- 텍스트 입력 시 .screen_out  -->
                                <input type="text" name=date class = "button_small button1" value="<%=rs.getString(3) %>"readonly=readonly
                                       size = 30>
                                <span class="mark_valid"><span class="ico_join ico_valid"></span><span
                                        class="screen_out"></span></span>
                            </div>
                        </dd>
                    </dl>
                    <dl>
                        <dt></dt>
                        <dd>
                            <div>
                                <label >곡번호 :</label>
                                <!-- 텍스트 입력 시 .screen_out  -->
                                <input type="text" name=seq class = "button_small button1" value = "<%=rs.getString(4) %>"readonly=readonly size = 30>
                            </div>
                        </dd>
                    </dl>
               		<dl>
                        <dt></dt>
                        <dd>
                            <div>
                                <label >듣기 :</label>
                                <!-- 텍스트 입력 시 .screen_out  -->
                                <td align = center>
								   <a href="<%=rs.getString(5)%>" target="_blank">
								   <img src="<%=rs.getString(6)%>" width="150"></a>
                            </div>
                        </dd>
                    </dl>
                </div>
            </div>
<%
      }
      conn_mysql.close();
		} catch (Exception e) {
	    e.printStackTrace();
	 }
%>

            <div class="wrap_btn">
                <input type = submit class = "button_small button1" value = '플레이리스트에 담기'></form>
                <form action = bMain2.jsp method = get>
      			<input type = submit value = 게시판 class = "button_search button1 keep_left">
        </fieldset>
    </form>
</div>

</body>
</html>