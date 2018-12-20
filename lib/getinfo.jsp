<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ include file="tools.jsp" %>
<%
            if(request.getMethod()!="POST")
            {
                out.println("错误的访问方式！");
                return;
            }
            String email = removeAllBlank(request.getParameter("email"));
            String mes = "";
            if(email == "" || email == null)
            {
                out.println("邮箱地址不能为空！");
                return;
            }
            if((mes=CheckSafe(email))!="True")
            {
                out.println(mes);
                return;
            }
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
			String info="";
            int sign = 0;
			try
			{
				String sql="select * from userinfo where UserInfo_Email = '"+email+"'";
				ps = conn.prepareStatement(sql);
				rs = ps.executeQuery();
				while(rs.next())
				{
                    sign = 1;
					info = rs.getString(1)+"-"+rs.getString(3);
					out.println(info);
				}
                if(sign == 0)
                {
                    out.println("no");
                    return;
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