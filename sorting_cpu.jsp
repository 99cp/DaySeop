<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("utf-8");
    String url="jdbc:postgresql://localhost:5432/dayseop";
    Connection con = DriverManager.getConnection(url,"postgres","1234");	
	String driver="org.postgresql.Driver";
    
    String select = "select count(*) from cpu_product";
    Statement stm = con.createStatement();
    int total = 0;
    ResultSet rs = null;

	String r11 = request.getParameter("radio-group-0");
    String r22 = request.getParameter("radio-group-1");

    int r1 = Integer.parseInt(r11);
    int r2 = Integer.parseInt(r22);

	try{
		
        Class.forName(driver);
        
        rs = stm.executeQuery(select);
        if(rs.next())
        {
            total = rs.getInt(1);
        }
        String drop = "DROP TABLE sorting_cpu";
		String sql = "CREATE TABLE sorting_cpu(name VARCHAR(255) PRIMARY KEY, price INT, cpu_socket VARCHAR(255), url VARCHAR(255), image VARCHAR(255))"; 
		PreparedStatement pstmt = con.prepareStatement(drop);
        PreparedStatement pstmt0 = con.prepareStatement(sql);
		pstmt.executeUpdate(); 
        pstmt0.executeUpdate(); 
        
        String sql1 = "insert into sorting_cpu (name, price, cpu_socket, url, image) SELECT name, price, cpu_socket, URL, image From cpu_product order by cpu_cache limit "+String.valueOf(total/5)+" OFFSET "+String.valueOf(total/5*r1-total/5)+"";
        String sql2 = "insert into sorting_cpu (name, price, cpu_socket, url, image) SELECT name, price, cpu_socket, URL, image From cpu_product order by cpu_core limit "+String.valueOf(total/5)+" OFFSET "+String.valueOf(total/5*r2-total/5)+"";
        

        PreparedStatement pstmt1 = con.prepareStatement(sql1);
        PreparedStatement pstmt2 = con.prepareStatement(sql2);

		pstmt1.executeUpdate(); 
        pstmt2.executeUpdate(); 

        rs.close();
        stm.close();
        pstmt0.close();
		pstmt.close();
        pstmt1.close();
        pstmt2.close();
        
		con.close();
	}catch(ClassNotFoundException e) {
		out.println(e);
	}catch(SQLException e){
        out.println(e);
	}
	response.sendRedirect("survey_gpu.html");
%>