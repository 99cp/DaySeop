<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("utf-8");
    String url="jdbc:postgresql://localhost:5432/dayseop";
    Connection con = DriverManager.getConnection(url,"postgres","1234");	
	String driver="org.postgresql.Driver";
    
    String select = "select count(*) from gpu_product";
    Statement stm = con.createStatement();
    int total = 0;
    ResultSet rs = null;

	String r11 = request.getParameter("radio-group-0");
    
    int r1 = Integer.parseInt(r11);
    
	try{
		
        Class.forName(driver);
        
        rs = stm.executeQuery(select);
        if(rs.next())
        {
            total = rs.getInt(1);
        }
        String drop = "DROP TABLE sorting_gpu";
		String sql = "CREATE TABLE sorting_gpu(name VARCHAR(255) PRIMARY KEY, price INT, gpu_output VARCHAR(255), gpu_power INT, url VARCHAR(255), image VARCHAR(255))"; 
		PreparedStatement pstmt = con.prepareStatement(drop);
        PreparedStatement pstmt0 = con.prepareStatement(sql);
		pstmt.executeUpdate(); 
        pstmt0.executeUpdate(); 
        
        String sql1 = "insert into sorting_gpu (name, price, gpu_output, gpu_power, url, image) SELECT name, price, gpu_output, gpu_power, URL, image From gpu_product order by gpu_stream limit "+String.valueOf(total/5)+" OFFSET "+String.valueOf(total/5*r1-total/5)+"";

        PreparedStatement pstmt1 = con.prepareStatement(sql1);

		pstmt1.executeUpdate(); 

        rs.close();
        stm.close();
        pstmt0.close();
		pstmt.close();
        pstmt1.close();
        
		con.close();
	}catch(ClassNotFoundException e) {
		out.println(e);
	}catch(SQLException e){
        out.println(e);
	}
	response.sendRedirect("survey_ram.html");
%>