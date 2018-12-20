<!DOCTYPE html>
<html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <link rel="stylesheet" href="https://v40.pingendo.com/assets/4.0.0/default/theme.css" type="text/css"> </head>

<body>
  <ul class="list-group">
	<%
		    String url="jdbc:mysql://127.0.0.1:3306/onlineddos";
		    String dbuser="root";
			String dbpwd="root";
			try
			{
				Class.forName("com.mysql.jdbc.Driver");
			}
			catch (ClassNotFoundException e)
			{
				e.printStackTrace();
			}
			Connection conn=DriverManager.getConnection(url, dbuser, dbpwd);
			PreparedStatement ps=null;
			ResultSet rs=null;
			try
			{
				String sql="select * from clientlist";
				ps = conn.prepareStatement(sql);
				rs = ps.executeQuery();
				while(rs.next())
				{
					out.println("<li class=\"list-group-item d-flex justify-content-between align-items-center\">");
					out.println(rs.getString(1)+"&nbsp;&nbsp;"+rs.getString(2));
					String status = rs.getString(3);
					if(status.equals("0"))
					{
						out.println("<span class=\"badge badge-pill badge-warning\">NULL</span>");
					}
					else
					{
						if(status.equals(new String("404")))
						{
							out.println("<span class=\"badge badge-pill badge-danger\">404</span>");
						}
						else if(status.equals(new String("200")))
						{
							out.println("<span class=\"badge badge-primary badge-pill\">200</span>");
						}
						else if(status.equals(new String("500")))
						{
							out.println("<span class=\"badge badge-pill badge-warning\">500</span>");
						}
					}
					
				}
				out.println("</li>");
			}
			catch (SQLException e)
			{
				e.printStackTrace();
			}
			finally
			{
					try
					{
						if(rs!=null)	
							rs.close();
					}
					catch (SQLException e)
					{
						e.printStackTrace();
					}
					finally
					{
							try
							{
								if(ps!=null)	
									ps.close();
							}
							catch (SQLException e)
							{
								e.printStackTrace();
							}
							finally
							{
								try
								{
									if(conn!=null)
										conn.close();
								}
								catch (SQLException e)
								{
										e.printStackTrace();
								}
							}
					}
			}
%>
  </ul>
</body>

</html>