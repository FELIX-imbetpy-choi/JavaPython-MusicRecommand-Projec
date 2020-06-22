<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="jbMenu">
<table align = left>
	<tr>
		<td>
		<a href=bMain2.jsp><img src = home.gif></a>
		</td>
		<td><form action = bSearch_02.jsp method = get>
   		<select class = "button_small button1 keep_left" name = "searchtype">
		<option>곡명</option> 
		<option>가수</option> 
		</select></td>
	<td><input type = text name = searchtext size = 30% class = "button_small button1 keep_left"></td>
	<td><input type = submit class = "button_small button1" value = "검색" size = 20>	</form></td>
	</tr>
</table>
</div>


<style>
select {
        width: 70px;
        padding: 15px;
        border: white;
        border-radius: 5px;
        background-color: white;
    }
</style>