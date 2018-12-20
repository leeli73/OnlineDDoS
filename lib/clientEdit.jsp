<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ include file="tools.jsp" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>

<%
if(request.getMethod()!="POST")
{
	out.println("错误的访问方式！");
	return;
}
String Sign = removeAllBlank(request.getParameter("sign"));
String Client = removeAllBlank(request.getParameter("text"));
 String mysqlurl="jdbc:mysql://127.0.0.1:3306/onlineddos";
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
			Connection conn=DriverManager.getConnection(mysqlurl, dbuser, dbpwd);
			PreparedStatement ps=null;
			ResultSet rs=null;
			try
			{
				if(Sign.equals("add"))
				{
					String[] Lines = Client.split("\n");
					int result = 0;
					for(int i=0;i<Lines.length;i++)
					{
						String[] Line = Lines[i].split("-");
						String sql="insert into clientlist values('"+Line[0]+"','"+Line[1]+"','0')";
						ps = conn.prepareStatement(sql);
						int count = ps.executeUpdate();
						if(count > 0)
						{
							result++;
						}
					}
					out.println("Insert Client Count:"+result);
				}
				else if(Sign.equals("check"))
				{
					String sql="select * from clientlist";
					int result = 0;
					ps = conn.prepareStatement(sql);
					rs = ps.executeQuery();
					while(rs.next())
					{
						String sqlurl = rs.getString(1);
						String statu = rs.getString(3);
						try {
						   String surl="http://"+sqlurl;
						   URL url = new URL(surl);
						   URLConnection rulConnection   = url.openConnection();
						   HttpURLConnection httpUrlConnection  =  (HttpURLConnection) rulConnection;
						   httpUrlConnection.setConnectTimeout(1000);
						   httpUrlConnection.setReadTimeout(1000);
						   httpUrlConnection.connect();
						   String code = new Integer(httpUrlConnection.getResponseCode()).toString();
						   if(code.startsWith("2"))
						   {
								sql="update clientlist set Client_LastStatus='200' where Client_URL='"+url+"'";
								ps = conn.prepareStatement(sql);
								int count = ps.executeUpdate();
								if(count > 0)
								{
									result++;
								}
						   }
						   else if(code.startsWith("5"))
						   {
							    sql="update clientlist set Client_LastStatus='500' where Client_URL='"+url+"'";
								ps = conn.prepareStatement(sql);
								int count = ps.executeUpdate();
								if(count > 0)
								{
									result++;
								}
						   }
						   else
						   {
							    sql="update clientlist set Client_LastStatus='404' where Client_URL='"+url+"'";
								ps = conn.prepareStatement(sql);
								int count = ps.executeUpdate();
								if(count > 0)
								{
									result++;
								}
						   }
						  }catch(Exception ex){
							   System.out.println(ex.getMessage());
						  }
					}
					out.println("Update Client Status Count:"+result);
				}
				else if(Sign.equals("remove"))
				{
					String sql="delect from clientlist where Client_LastStatus='404'";
					int result = 0;
					ps = conn.prepareStatement(sql);
					int count = ps.executeUpdate();
					if(count > 0)
					{
						out.println("Delect Client Count:"+result);
					}
				}
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