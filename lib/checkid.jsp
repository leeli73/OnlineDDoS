<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.security.NoSuchAlgorithmException" %>
<%
if(request.getMethod()!="POST")
{
    out.println("错误的访问方式！");
    return;
}
String id = request.getParameter("id");
int sign = 0;
String code = request.getParameter("code");
if(code!=null)
{
	sign = 1;
}
id = id + getHash(id,"SHA");
String PrivateCode = getHash(id,"MD5");
if(sign == 1)
{
	if(code.equals(PrivateCode))
	{
		out.println("T");
	}
	else
	{
		out.println("F");
	}
	return ;
}
else
{
	out.println(PrivateCode);
}
%>
<%!
public String getHash(String source, String hashType) {  
        char hexDigits[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};  
        try {  
            MessageDigest md = MessageDigest.getInstance(hashType);  
            md.update(source.getBytes());
            byte[] encryptStr = md.digest();
            char str[] = new char[16 * 2];
            int k = 0;
            for (int i = 0; i < 16; i++) {
                byte byte0 = encryptStr[i];
                str[k++] = hexDigits[byte0 >>> 4 & 0xf];
                str[k++] = hexDigits[byte0 & 0xf];
            }
            return new String(str);
        } catch (NoSuchAlgorithmException e) {  
            e.printStackTrace();  
        }  
        return null;  
    } 
%>