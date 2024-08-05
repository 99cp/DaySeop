<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>end page</title>

	<link rel="stylesheet" type="text/css" href="end.css">
</head>
<body>
	
	<%
	Connection conn=null;
	String driver="org.postgresql.Driver";
    String url="jdbc:postgresql://localhost:5432/dayseop";
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	ResultSet rs3 = null;

    Statement stmt1 = null;
	Statement stmt2 = null;
	Statement stmt3 = null;

	try{
		Class.forName(driver);

		conn=DriverManager.getConnection(url,"postgres","1234");
        
		stmt1 = conn.createStatement();
		stmt2 = conn.createStatement();
		stmt3 = conn.createStatement();
		  
        rs1 = stmt1.executeQuery("select name, price, url, image, count(name) from sorting_cpu group by name, price, url, image having count(name) >0 order by count desc limit 3 offset 0");
		rs2 = stmt2.executeQuery("select name, price, url, image, count(name) from sorting_gpu group by name, price, url, image having count(name) >0 order by count desc limit 3 offset 0");
		rs3 = stmt3.executeQuery("select name, price, url, image, count(name) from sorting_ram group by name, price, url, image having count(name) >0 order by count desc limit 3 offset 0");
		
		
    %>
	<section id="container">
		<div class="alpha">
			<br><br>
        <div class="head">
          
          <p id="description"><i></i></p>
        </div>
        <br><br>

			<form action="survey_cpu.html" id="survey-form">
				<br> <br>
				<div class="image1">
					<%
					while (rs1.next()) {
					%>
					<div class="img1" id="img1" style="border: 1px solid #F5EEDE; float: left; width: 33%;"> <!--세로 정렬-->
						<p><img src='<%=rs1.getString("image")%>'></img></p>
						<p>제품명 : <%=rs1.getString("name")%></p>
						<p>가격 : <%=rs1.getString("price")%> 원</p>
						<p>상품 : <a href='<%=rs1.getString("url")%>'>URL</a></p>
						<!-- <p>정확도 : <%=rs1.getInt("count")*20%>%</p> -->
					</div>					
					<br><br>

					<%
					}
					while (rs2.next()) {
					%>
					<div class="img2" id="img2" style="border: 1px solid #F5EEDE; float: left; width: 33%;">
						<p><img src='<%=rs2.getString("image")%>'></img></p>
						<p>제품명 : <%=rs2.getString("name")%></p>
						<p>가격 : <%=rs2.getString("price")%> 원</p>
						<p>상품 : <a href='<%=rs2.getString("url")%>'>URL</a></p>
						<!-- <p>정확도 : <%=rs2.getInt("count")*20%>%</p> -->
					</div>					
					<br><br>

					<%
					}
					while (rs3.next()) {
					%>
					<div class="img3" id="img3" style="border: 1px solid #F5EEDE; float: left; width: 33%;">
						<p><img src='<%=rs3.getString("image")%>'></img></p>
						<p>제품명 : <%=rs3.getString("name")%></p>
						<p>가격 : <%=rs3.getString("price")%> 원</p>
						<p>상품 : <a href='<%=rs3.getString("url")%>'>URL</a></p>
						<!-- <p>정확도 : <%=rs3.getInt("count")*20%>%</p> -->
					</div>
					<br><br>

					<%
					}
					} catch (Exception e) {
					e.printStackTrace();
					} finally {
					try {
					if (rs1 != null) {
						rs1.close();
					}
					if (rs2 != null) {
						rs2.close();
					}
					if (rs3 != null) {
						rs3.close();
					}
					if (stmt1 != null){
						stmt1.close();
					} 
					if (stmt2 != null){
						stmt2.close();
					} 
					if (stmt3 != null){
						stmt3.close();
					} 
					if (conn != null) {
						conn.close();
					}
					} catch (Exception e) {
					e.printStackTrace();
					}
					}
					%>
				</div>
				
				<button id="btn">다시하기</button>
			</form>
		</div>
	</section>

</body>

</html>